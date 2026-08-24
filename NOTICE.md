# NOTICE

## 上游

OpenClaw is MIT-licensed software © 2026 OpenClaw Foundation.

- Source: https://github.com/openclaw/openclaw
- License: ./LICENSE (copied from upstream MIT text)
- Third-party notices: https://github.com/openclaw/openclaw/blob/main/THIRD_PARTY_NOTICES.md

This repository does **not** vendor the OpenClaw source tree. Clone upstream when you need to build.

## 本仓库

OpenClaw-zh-mac is a public personal notebook for building OpenClaw.app on Apple Silicon with the Control UI set to zh-CN. It is not an official OpenClaw Foundation release, not an App Store package, and not a notarized installer.

Maintainer: liuxiang147 (Mr.AK)
Public URL: https://github.com/liuxiang147/OpenClaw-zh-mac

## 不分发什么

Do not upload:

- ad-hoc signed `OpenClaw.app` / DMG (useless to other machines, oversized)
- `node_modules`
- `~/.openclaw` (tokens, sessions, local config)
- Apple signing certificates, provisioning profiles, Team IDs
