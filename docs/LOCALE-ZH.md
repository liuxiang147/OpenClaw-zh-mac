# Control UI 简体中文

**结论：** 里面的控制台语言不是 Xcode scheme 决定的。在 **已打开的 OpenClaw.app** 里改 Language。Xcode 界面语言跟 OpenClaw 无关。

## 操作（推荐）

1. 打开 `~/openclaw/dist/OpenClaw.app`
2. 进 Settings（设置）
3. Appearance → Language → **zh-CN / 简体中文**
4. 刷新 Control UI

这会写 `localStorage` 键 `openclaw.i18n.locale`。

## 配置持久化（可选）

若 `~/.openclaw/openclaw.json` schema 有效：

```bash
openclaw config set ui.prefs.locale zh-CN
```

若报 invalid schema：

```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak
openclaw doctor --fix
openclaw config set ui.prefs.locale zh-CN
```

## 两套字符串

| 层 | 谁管 | 中文覆盖 |
| --- | --- | --- |
| 内嵌 Control UI | 源码里的 i18n locale（含 zh-CN） | 官方已有；缺键回落英文 |
| macOS 原生菜单 | Swift / `apple-app-i18n` | 打包脚本会 Copying app localizations |

不要期待「Xcode 全部汉化」会把 App 里的英文变中文。

## 长期用法

- 日常进 App，不进浏览器
- Gateway 留在 LaunchAgent
- 不要把 18789 当成网站书签
