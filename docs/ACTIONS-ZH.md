# GitHub Actions 自动化说明

**结论：** 本仓库已接好免费可用的 CI + 文档部署。真正的「可分发 Mac 安装包自动发布」需要 Apple 付费证书与公证，官方流程也不是公开仓库里随便跑就能完成的。

## 本仓库已启用的工作流

| 工作流 | 触发 | 作用 | 费用 |
| --- | --- | --- | --- |
| `CI` | push / PR / 手动 | 检查文档与脚本是否齐全、语法正确 | Ubuntu，几乎可忽略 |
| `Deploy Docs` | push main / 手动 | 把说明部署到 GitHub Pages | Ubuntu，几乎可忽略 |
| `macOS Ad-hoc Package` | **仅手动** | 在 GitHub 的 macOS runner 上试打 ad-hoc 包 | **贵**：macOS 分钟 ×10 |

查看运行：https://github.com/liuxiang147/OpenClaw-zh-mac/actions

## 启用 GitHub Pages（首次需要点一次）

1. 打开 https://github.com/liuxiang147/OpenClaw-zh-mac/settings/pages
2. **Source** 选 **GitHub Actions**
3. 推送 `main` 或手动跑一次 `Deploy Docs`
4. 站点地址一般是：`https://liuxiang147.github.io/OpenClaw-zh-mac/`

## 什么叫「自动化部署」，在本场景下分别指什么

| 目标 | 能不能免费自动化 | 说明 |
| --- | --- | --- |
| 文档网站上线 | 能 | `Deploy Docs` → GitHub Pages |
| 校验笔记仓库没坏 | 能 | `CI` |
| 在 CI 里验证打包脚本还能跑 | 能，但贵 | `macOS Ad-hoc Package`，产物不能分发 |
| 把 `.app` 装到你自己的 Mac | 不能靠云端直接装 | 只能本机打包或本机下载后右键打开 |
| 公证 / Sparkle 更新 / 别人能双击安装 | 不能免费 | 需要 Developer ID + notary；官方也走私有发布链路 |

## 官方 macOS 发布（对照）

上游公开的 `macos-release.yml` 目前是 **validation-only**：校验 tag / 构建 JS，**不签名、不公证、不上传 Mac 资产**。真正的签名发布在 `openclaw/releases` 私有工作流，并依赖 Foundation 证书。

本机免费路线仍然是：

```bash
ALLOW_ADHOC_SIGNING=1 OPENCLAW_SKIP_MLX_TTS=1 ./scripts/package-mac-app.sh
```

## 不建议的做法

- 在 Actions 里保存 Apple 证书 / 公证密码（除非你明确要付费发布）
- 把 ad-hoc `.app` 当 Release 资产长期挂着给人装
- 在 fork 上全量开启上游全部 CI（分钟消耗大，且大量密钥你没有）

## 可选：本机 Self-hosted Runner

若希望「推代码 → 自己的 Mac 自动打包」，可在本机装 [GitHub Actions Runner](https://docs.github.com/en/actions/hosting-your-own-runners)，用 `runs-on: self-hosted`。签名与 TCC 都在你自己的机器上完成，不消耗云端 macOS 分钟。需要时再说，我可以按你的机器写一份最小 workflow。
