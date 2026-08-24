# Mac 本地打包（Apple Silicon）

**目的：** 从官方源码打出可以双击运行的 `OpenClaw.app`。不花钱，不走 App Store，不用 $99 证书。

**先决条件**

- Apple Silicon Mac（M1 / M3 已验证）
- 从 App Store 装好 Xcode，不是只装 Command Line Tools
- Homebrew 在 `/opt/homebrew`
- 网络能 git clone GitHub

## 1. 工具链

```bash
sudo xcode-select -s /Applications/Xcode.app
xcode-select -p
# 应该打出 /Applications/Xcode.app/Contents/Developer

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install pnpm git
```

CLI 不要 `npm i -g` 装到 `/usr/local`（会 EACCES）。用用户前缀：

```bash
mkdir -p "$HOME/.local"
npm install --prefix "$HOME/.local" -g openclaw
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
```

把 PATH 写进 `~/.zprofile`，否则新终端会 `command not found: openclaw`。

## 2. 浅克隆上游（不要全量 clone）

完整仓库约 2.69GiB，浅克隆够用：

```bash
git clone --depth 1 https://github.com/openclaw/openclaw.git ~/openclaw
cd ~/openclaw
pnpm install
```

## 3. 打包

没有付费 Developer ID 时必须开 ad-hoc：

```bash
cd ~/openclaw
ALLOW_ADHOC_SIGNING=1 OPENCLAW_SKIP_MLX_TTS=1 ./scripts/package-mac-app.sh
```

成功标志：

- `Codesign complete`
- Bundle ready → `~/openclaw/dist/OpenClaw.app`
- 日志里会有 `apple-app-i18n`（macOS 字符串）和 Copying app localizations

`xattr` 清除隔离属性不是必须成功。权限被拒就跳过，右键打开即可。

## 4. 打开

1. Finder 进 `~/openclaw/dist/`
2. 右键 `OpenClaw.app` → 打开
3. 日常也走 App，不要把浏览器当主 UI

Gateway 用 LaunchAgent 常驻：

`~/Library/LaunchAgents/ai.openclaw.gateway.plist`

默认绑 loopback `127.0.0.1:18789`。本机 App 连这个地址即可。
iPhone 节点要连同局域网时，才把 `gateway.bind` 改成 `lan`。

## 5. 配置 schema 坏了

若 `~/.openclaw/openclaw.json` 报 invalid schema：

```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak
openclaw doctor --fix
```

不要手动杀 Gateway pid；LaunchAgent 会拉起已经在跑的那份二进制。

## 6. CLI 与 Gateway 版本不一致

本机曾出现：

- CLI：`~/.local` 里的 `openclaw` 2026.7.1-2
- Gateway：`~/Downloads/openclaw-2026.8.1-beta.2` 的 LaunchAgent

以 **正在跑的 Gateway** 为准。不要为了让 CLI `--version` 省心就 kill 掉 18789 上的进程。

## 不要做的事

- 不要 `git add dist/ OpenClaw.app node_modules`
- 不要把本仓库当源码主仓库；源码永远是 `openclaw/openclaw`
- 不要为了「发布」去买证书
