# 图形应用（GUI）

## Files

Files（Nautilus）是图形文件管理器。`Super + Shift + F` 打开它，`Super + Shift + Alt + F` 在终端当前目录打开，省很多点击。`Ctrl + L` 让你输入路径，在任意文件上按 `Space` 可以快速预览而不打开。

插上 U 盘或 SD 卡会自动挂载，直接出现在侧边栏。更复杂的操作——格式化磁盘、检查 SMART 健康状态、创建分区——从应用启动器（`Super + Space`）打开 _Disks_。

双击遵循合理默认：图片用 imv 打开、视频用 mpv、PDF 用 Document Viewer、纯文本用 Neovim。

## Obsidian

[Obsidian](https://obsidian.md/) 是免费且高度可扩展的笔记应用，用简单 Markdown 文件存储。

Obsidian 完全免费，个人、商业和非营利都可以用。

它还提供 [商业同步插件](https://obsidian.md/sync)，可以和 iOS、Android 移动端同步（https://obsidian.md/pricing）。

按 `Super + Shift + O` 启动 Obsidian。要用主题同步，必须在设置里选 `Omarchy` 主题。

## Omawrite

[Omawrite](https://github.com/omacom-io/omawrite) 是 codeOS 自己的极简 Markdown 写作应用。没有 vault、没有插件，只有你和文字。

按 `Super + Shift + W` 启动 Omawrite。

## Pinta

[Pinta](https://www.pinta-project.com/) 是基础图片编辑工具，裁剪、缩放等基础操作很好用。别指望它替代 Photoshop。但它有 Magic Wand 和图层！

从应用启动器（`Super + Space`）启动 Pinta。

## Aether

[Aether](https://github.com/bjarneo/aether) 是主题应用，可以从背景图片里提取颜色，生成完整统一的主题。它是 [自己做主题](43-making-your-own-theme.md) 最简单的方式。

从应用启动器（`Super + Space`）启动 Aether。

## LocalSend

[LocalSend](https://localsend.org/) 让你在同一网络上给运行着这个应用的其他设备发文件，像 Apple 的 AirDrop。但它跨平台，所以可以在 Windows、macOS、Android、iOS 之间互发，当然也包括 Linux。

按 `Super + Ctrl + S` 打开分享菜单（或 codeOS 菜单里的 _Trigger > Share_）。有四个选项：

- **Clipboard** 把你复制的内容当文本文件发过去。非常适合把链接或代码片段发到手机上，不用给自己发邮件。
- **File** 打开文件选择器，可以一次选多个。
- **Folder** 发送整个目录。
- **Receive** 打开 LocalSend 让其他设备给你发东西。

终端里也能用：`omarchy share clipboard`、`omarchy share file [path]`、`omarchy share folder [path]`。省略 path 就弹出选择器。

也可以直接从文件管理器发：在 Nautilus 里右键选中内容，选 _Send via LocalSend_。

codeOS 的防火墙默认是关闭的，除了 LocalSend 的端口，所以全新安装就能直接用。详见 [安全](48-security.md)。

## LibreOffice

[LibreOffice](https://www.libreoffice.org/) 是完整的办公套件——文字处理、表格、演示、绘图等。兼容 Microsoft Office 文件，所以能打开那些 Word 文档。

从应用启动器（`Super + Space`）启动 LibreOffice。

## Omacalc

[Omacalc](https://github.com/omacom-io/omacalc) 是 codeOS 自己的极简计算器，在浮动窗口里打开。

按 `Super + Ctrl + Q`（或键盘上的计算器键，如果有的话）启动 Omacalc。

## Signal

[Signal](https://signal.org/) 是端到端加密消息的开创者，对于不想用科技大厂服务的人是很好的选择。

按 `Super + Shift + G` 启动 Signal。它不在基础安装里，第一次按时 codeOS 会提示你安装（也可以在 codeOS 菜单的 _Install > Service_ 里装）。

## mpv

[mpv](https://mpv.io/) 是简单快速的媒体播放器，几乎什么来源、什么格式都能播。看视频很好用。

从应用启动器（`Super + Space`）启动 mpv，或直接在文件管理器里双击视频文件。

## OBS Studio

[OBS Studio](https://obsproject.com/) 让你用多个输入录制或串流视频。可以混合屏幕、摄像头和麦克风输入。codeOS 的截屏就是用它录的。

从应用启动器（`Super + Space`）启动 OBS Studio。

## Kdenlive

[Kdenlive](https://kdenlive.org/) 是优秀的视频编辑器。从 OBS Studio 出来的视频要分享前，用它剪一剪很合适。

从应用启动器（`Super + Space`）启动 Kdenlive。

## Omacut

[Omacut](https://github.com/omacom-io/omacut) 是 codeOS 自己的极简视频裁剪器。当你只需要剪掉片段的头和尾时，比启动一个完整视频编辑器省心。

从应用启动器（`Super + Space`）启动 Omacut。
