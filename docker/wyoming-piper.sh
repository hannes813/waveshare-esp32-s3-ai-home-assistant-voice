#!/usr/bin/env bash
set -euo pipefail

mkdir -p /volume1/docker/piper

docker rm -f wyoming-piper 2>/dev/null || true

docker run -d \
  --name wyoming-piper \
  --restart unless-stopped \
  -p 10200:10200 \
  -v /volume1/docker/piper:/data \
  rhasspy/wyoming-piper \
  --voice de_DE-thorsten-high

docker logs -f wyoming-piper
