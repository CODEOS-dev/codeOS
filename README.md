# codeOS

codeOS 是基于 Omarchy 的中文本土化 Linux 发行版。保留 Omarchy 的全部特色功能，加入：

- 中文本土化（locale、镜像源、字体、输入法）
- 中文手册

## 特色功能（继承自 Omarchy Quattro）

- **Arch Linux + Hyprland + Quickshell** — 滚动更新、Wayland 平铺窗口、统一桌面壳
- **Agent-First 架构** — AI Agent 深度集成到系统入口、工作台和故障诊断
- **opinionated** — 开箱即用的开发者工作站，不用折腾 dotfile
- **强制 LUKS 全盘加密**、**默认 Btrfs + Snapper 快照**
- **一键安装** — 约 5 分钟完成

## 中文本土化内容

- 默认 locale: `zh_CN.UTF-8`（自动回退到 `en_US.UTF-8`）
- 镜像源: 中科大 / 清华 / 阿里云 / 华科 / 浙大
- 字体: Noto Sans/Serif CJK SC + 文泉驿 + JetBrains Mono
- 输入法: fcitx5 + rime + 中文增强包
- 时区: `Asia/Shanghai`
- Pacman: 中文输出 + ILoveCandy
- Fontconfig: 中文字体优先顺序

## 构建

```bash
# 本地测试 shell 脚本语法
find bin/ -type f -exec bash -n {} +
find install/ -name '*.sh' -exec bash -n {} +

# 运行完整测试套件（需要 Omarchy 运行环境）
./test/all
```

## ISO 构建

待补充（Omarchy 使用独立 ISO builder，需要在 Linux 环境中运行）。

## 与上游 Omarchy 的关系

本仓库 fork 自 `omacom/omarchy` 的 `quattro` 分支。所有上游提交应定期合并进来。本土化变更集中在：

- `default/pacman/mirrorlist-*` — 国内镜像源
- `default/bash/envs` — locale 默认值
- `default/environment.d/10-omarchy-fcitx.conf` — 输入法环境变量
- `install/omarchy-base.packages` — 中文支持包
- `install/post-install/localize-zh.sh` — post-install 本土化脚本
- `themes/sulfur/` — Minecraft 主题
- `manual/*.md` — 中文手册（保留英文原文对照）
- `.github/workflows/ci.yml` — CI 检查本土化配置

## License

MIT，继承自 Omarchy 上游许可证。
