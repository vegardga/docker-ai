# usage: ai [--no-state] [name [folder]]
#   ai                          - fzf pick from all docker-ai-* containers
#   ai <name>                   - create/attach to docker-ai-<name>, mounts pwd
#   ai <name> <dir>             - create/attach to docker-ai-<name>, mounts dir
#   ai --no-state <name>        - same, but omits ai state mounts
ai() {
  # prefer docker, fall back to podman
  local runtime
  if command -v podman &>/dev/null; then
    runtime=podman
  elif command -v docker &>/dev/null; then
    runtime=docker
  else
    echo "Neither docker nor podman found" >&2
    return 1
  fi

  # parse flag
  local no_state=0
  if [[ "$1" == "--no-state" ]]; then
    no_state=1
    shift
  fi

  # specified dir or current
  local dir="${2:-$(pwd)}"

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
  # take away admin superpowers and stop apps from giving themselves more.
  local -a security_flags=(--cap-drop=ALL --security-opt=no-new-privileges)

  # stuff to mount in the container
  local -a volumes=(
    -v "${dir}:${dir}" -w "${dir}"
    -v "$HOME/.m2:/home/batman/.m2"
    -v "$HOME/.gradle:/home/batman/.gradle"
    -v "$HOME/.gitconfig.docker-ai:/home/batman/.gitconfig.private:ro"
  )

  if (( !no_state )); then
    volumes+=(
      # opencode
      -v "$HOME/.local/share/opencode:/home/batman/.local/share/opencode"
      -v "$HOME/.local/state/opencode:/home/batman/.local/state/opencode"
      -v "$HOME/.config/opencode/opencode.json:/home/batman/.config/opencode/opencode.json:ro"
    )
  fi

  # named container: create or attach
  if [[ -n "$1" ]]; then
    local container="docker-ai-$1"
    if $runtime ps --format '{{.Names}}' | grep -qx "$container"; then
      $runtime exec -it "$container"
    elif $runtime ps -a --format '{{.Names}}' | grep -qx "$container"; then
      $runtime start "$container" && $runtime exec -it "$container"
    else
      echo "Starting $container in $dir ($runtime)"
      $runtime run -dit --name "$container" "${userns_flags[@]}" "${gpu_flags[@]}" "${security_flags[@]}" "${volumes[@]}" docker-ai bash
      sleep 0.5
      $runtime exec -it "$container"
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
    $runtime exec -it "$container"
  else
    echo "Failed to start $container ($runtime)" >&2
    return 1
  fi
}
