# Shoutout to Torgeir - https://gist.github.com/torgeir/dbe931351d91644f295ca8a296b8e4fb
# usage: ai [--no-state] [name [dir...]]
#   ai                          - fzf pick from all docker-ai-* containers
#   ai <name>                   - create/attach to docker-ai-<name>, mounts pwd
#   ai <name> <dir>             - create/attach to docker-ai-<name>, mounts dir
#   ai <name> <dir1> <dir2>...  - same, mounts multiple dirs; cwd is dir1
#   ai --no-state <name>        - same, but omits ai state mounts
#   ai --no-gradle <name>       - same, but omits gradle state mounts
#   ai -e VAR <name>            - same, expose environment variable VAR to the container
ai() {
  # prefer podman, fall back to docker
  local runtime
  if command -v podman &>/dev/null; then
    runtime=podman
  elif command -v docker &>/dev/null; then
    runtime=docker
  else
    echo "Neither docker nor podman found" >&2
    return 1
  fi

  # parse flags
  local no_state=0 no_gradle=0
  local -a env_flags=()

  # parse flags
  while [[ "${1:-}" == --* || "${1:-}" == -e ]]; do
    case "$1" in
      --no-state)  no_state=1;  shift ;;
      --no-gradle) no_gradle=1; shift ;;
      -e|--env)    env_flags+=(-e "$2"); shift 2 ;;
      --env=*)     env_flags+=(-e "${1#--env=}"); shift ;;
      *)           break ;;
    esac
  done

  local name="${1//[^a-z0-9_-]/-}"
  shift 2>/dev/null || true  # remaining args are dirs

  # collect dirs; default to pwd if none given
  local -a dirs=()
  for d in "$@"; do
    [[ "$d" = /* ]] && dirs+=("$d") || dirs+=("$PWD/$d")
  done
  if (( ${#dirs[@]} == 0 )); then
    dirs=("$PWD")
  fi

  # --userns=keep-id maps your host uid straight through inside the container
  # (batman uid == your uid), so bind mounts just work without chown tricks.
  # only podman supports this; docker gets no --userns flag.
  local -a userns_flags=()
  if [[ "$runtime" == "podman" ]]; then
    userns_flags=(--userns=keep-id)
  fi

  # amd gpu: /dev/kfd for rocm compute, /dev/dri for rendering
  local -a gpu_flags=()
  if [[ -e /dev/kfd ]] && [[ -e /dev/dri ]]; then
    gpu_flags=(--device /dev/kfd --device /dev/dri)
  fi
  # TODO nvidia

  # hardening defaults (drop linux capabilities and block privilege escalation)
  local -a security_flags=(--cap-drop=ALL --security-opt=no-new-privileges)

  # mount every requested dir; working dir is the first one
  local -a volumes=(-w "${dirs[1]}")
  for d in "${dirs[@]}"; do
    volumes+=(-v "${d}:${d}")
  done

  volumes+=(
    -v "$HOME/.m2:/home/batman/.m2"
    -v "$HOME/.gitconfig.docker-ai:/home/batman/.gitconfig.private:ro"
  )

  if (( !no_gradle )); then
    volumes+=(
      -v "$HOME/.gradle:/home/batman/.gradle"
    )
  fi

  if (( !no_state )); then
    [[ -f "$HOME/.claude.json" ]] || touch "$HOME/.claude.json"
    [[ -d "$HOME/.pi" ]] || mkdir -p "$HOME/.pi"

    volumes+=(
      # opencode
      -v "$HOME/.local/share/opencode:/home/batman/.local/share/opencode"
      -v "$HOME/.local/state/opencode:/home/batman/.local/state/opencode"
      -v "$HOME/.config/opencode/opencode.json:/home/batman/.config/opencode/opencode.json:ro"

      # claude: auth token, main state dir, config dir, history/state
      -v "$HOME/.claude.json:/home/batman/.claude.json"
      -v "$HOME/.claude:/home/batman/.claude"
      -v "$HOME/.config/claude:/home/batman/.config/claude"
      -v "$HOME/.local/state/claude:/home/batman/.local/state/claude"

      # pi: everything lives under ~/.pi/agent/ (sessions, auth, settings)
      -v "$HOME/.pi:/home/batman/.pi"
    )
  fi

  # named container: create or attach
  if [[ -n "$name" ]]; then
    local container="docker-ai-$name"
    if $runtime ps --format '{{.Names}}' | grep -qx "$container"; then
      $runtime exec -it "$container" tmux attach
    elif $runtime ps -a --format '{{.Names}}' | grep -qx "$container"; then
      $runtime start "$container" && $runtime exec -it "$container" tmux attach
    else
      echo "Starting $container mounting: ${dirs[*]} ($runtime)"
      $runtime run -dit --name "$container" \
        "${userns_flags[@]}" "${gpu_flags[@]}" "${security_flags[@]}" \
        "${volumes[@]}" \
        "${env_flags[@]}" \
        docker-ai bash -c "exec tmux"
      sleep 0.5
      $runtime exec -it "$container" tmux attach
    fi
    return
  fi

  # no args: pick from all docker-ai-* containers with fzf
  local selection
  selection=$($runtime ps -a --format '{{.Names}}\t{{.Status}}' \
    | grep '^docker-ai-' \
    | fzf --height=40% --reverse --header="container  status") || return 0

  local container
  container=$(echo "$selection" | awk '{print $1}')

  if $runtime start "$container"; then
    $runtime exec -it "$container" tmux attach
  else
    echo "Failed to start $container ($runtime)" >&2
    return 1
  fi
}
