#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Replace a placeholder with an environment variable
sed -i "s|REPLACE_ME_TOKEN|${OPENCODE_AUTH_TOKEN}|g" /home/batman/.local/share/opencode/auth.json
sed -i "s|REPLACE_ME_NAME|${GITHUB_USER}|g" /home/batman/.gitconfig
sed -i "s|REPLACE_ME_EMAIL|${GITHUB_EMAIL}|g" /home/batman/.gitconfig

# Hand over control to the CMD specified in the Dockerfile or docker run
exec "$@"
