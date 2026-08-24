#!/usr/bin/env bash
# OpenClaw-zh-mac · Apple Silicon ad-hoc 打包包装
# 在上游源码仓库根目录执行（例如 ~/openclaw），不要在本笔记仓库里执行。
set -euo pipefail

if [[ ! -f ./scripts/package-mac-app.sh ]]; then
  echo "error: run this from the openclaw/openclaw source tree, not from OpenClaw-zh-mac" >&2
  exit 1
fi

export ALLOW_ADHOC_SIGNING=1
export OPENCLAW_SKIP_MLX_TTS=1
exec ./scripts/package-mac-app.sh "$@"
