# OpenClaw-zh-mac

**结论先行：** 这是 [liuxiang147](https://github.com/liuxiang147) (Mr.AK) 的 OpenClaw **macOS 本地中文构建** 公开仓库。源码与版权归 [OpenClaw Foundation](https://github.com/openclaw/openclaw)，MIT 许可。

**不上传 `OpenClaw.app` 二进制。** ad-hoc 签名只对打包的那台 Mac 有效；GitHub 也不适合放几 GB 的 bundle / `node_modules`。正确发布方式是：公开构建步骤，每人在自己的 Apple Silicon 上打包。

| 项 | 值 |
| --- | --- |
| 公开地址 | https://github.com/liuxiang147/OpenClaw-zh-mac |
| 上游源码 | https://github.com/openclaw/openclaw |
| 许可证 | MIT © OpenClaw Foundation |
| 本机环境 | Apple Silicon · macOS 26.6.2 · Xcode 26.6 |
| Gateway | 2026.8.1-beta.2 · 端口 18789 · LaunchAgent |
| 日常 UI | `OpenClaw.app`（不用浏览器当主控制台） |

## 本仓库有什么 / 没有什么

**有**

- Apple Silicon 上从官方源码打出 `.app` 的步骤
- Control UI 切到简体中文 `zh-CN`
- 免费 ad-hoc 签名的限制说明
- 不要把什么 commit 进 Git 的忽略规则

**没有（也不要推）**

| 禁止上传 | 原因 |
| --- | --- |
| `dist/OpenClaw.app` / `.dmg` | ad-hoc 签名，别人下了 Gatekeeper 会拦；体积超 GitHub 软限制 |
| `node_modules/` | 数 GB，可重装 |
| `~/.openclaw/` | 密钥、会话、本地配置 |
| 证书 / `.p12` / `LocalSigning.xcconfig` | 私人签名材料 |

没有 GitHub Organization。这个仓库挂在个人账号 **liuxiang147** 下，公开。

## 从上游重新打出 Mac 应用

详细步骤见 [docs/BUILD-MAC-ZH.md](docs/BUILD-MAC-ZH.md)。

```bash
git clone --depth 1 https://github.com/openclaw/openclaw.git ~/openclaw
cd ~/openclaw
pnpm install
ALLOW_ADHOC_SIGNING=1 OPENCLAW_SKIP_MLX_TTS=1 ./scripts/package-mac-app.sh
```

产物：`~/openclaw/dist/OpenClaw.app`

第一次打开：右键 → 打开。ad-hoc 签名下 TCC 授权不会永久粘住，属于预期行为，不是破损。

## 把界面切到中文

详细见 [docs/LOCALE-ZH.md](docs/LOCALE-ZH.md)。

1. 打开 **OpenClaw.app**（不要用 Safari 打开控制台端口）
2. Settings → Appearance → Language → **简体中文 (zh-CN)**
3. 可选持久化：先 `openclaw doctor --fix`，再 `openclaw config set ui.prefs.locale zh-CN`

缺翻译的键会回落英文。原生 Swift 菜单与内嵌 Control UI 是两套字符串。

## 为什么不上传 .app

| 原因 | 说明 |
| --- | --- |
| 签名 | ad-hoc 只对本机有效，别人下载后 Gatekeeper 会拦 |
| 体积 | `.app` + 依赖远超 GitHub 100MB 软限制 |
| 密钥 | `~/.openclaw` 与本地状态不能公开 |
| 正确做法 | 公开构建步骤，各自在自己的 Mac 上打包 |

没有 $99 Apple Developer Program就不能公证 / 上架 App Store。本仓库走免费 ad-hoc 路线。

## 许可证

上游 OpenClaw：MIT © 2026 OpenClaw Foundation，见 [LICENSE](LICENSE)。  
本仓库文档与笔记：同样按 MIT 发布。
