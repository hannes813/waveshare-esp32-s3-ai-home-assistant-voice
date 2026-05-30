#!/usr/bin/env bash
set -euo pipefail

docker rm -f wyoming-whisper 2>/dev/null || true

docker run -d \
  --name wyoming-whisper \
  --restart unless-stopped \
  --network host \
  rhasspy/wyoming-whisper \
  --model tiny \
  --language de

docker logs -f wyoming-whisper
