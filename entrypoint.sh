#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Replace a placeholder with an environment variable
sed -i "s|OPENCODE_AUTH_TOKEN|${OPENCODE_AUTH_TOKEN}|g" /home/batman/.local/share/opencode/auth.json

# Hand over control to the CMD specified in the Dockerfile or docker run
exec "$@"
