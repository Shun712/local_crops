# 特定のserver.pidファイルが存在するときにサーバーが再起動しないようにする
#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /local_crops/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"