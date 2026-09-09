# TUI 应用

## Lazygit

[Lazygit](https://github.com/jesseduffield/lazygit) 是 GitHub Desktop 等 GUI 工具的绝佳替代品，在终端里运行。

直接在 git 管理的任何目录里运行 `lazygit` 就能启动。也可以在 Neovim 里用 `Space G G` 启动。

用 `Tab` 在不同面板间跳。在 Files 面板里用 `Space` 选中要暂存的文件，然后用 `c` 创建新提交。`?` 看全部命令。

## Lazydocker

[Lazydocker](https://github.com/jesseduffield/lazydocker) 和 Lazygit 同精神，也给你终端界面管理容器和镜像。

按 `Super + Shift + D` 启动。

用 `s` 停止容器、`r` 启动/重启。`?` 看全部命令。

## Btop

[Btop](https://github.com/aristocratos/btop) 是漂亮的资源管理器，展示内存、CPU、磁盘和网络使用。还列出所有活跃进程，允许你管理它们。

codeOS 叫它 Activity，按 `Super + Ctrl + T` 启动。它作为浮动窗口打开，可以用 `Super + T` 变平铺。

## Herdr

[Herdr](https://github.com/omacom-io/herdr) 是终端工作区管理器，给你工作区、标签页和分屏，全部持久运行——你可以脱离会话以后再回来。

按 `Super + Ctrl + Return` 启动（或重新附着已有会话）。codeOS 自带的 Herdr 配置和它的 Tmux 配置类似，前缀键也是 `Ctrl + Space`。用 `Super + Ctrl + K` 浏览全部键位绑定。

## Fastfetch

[Fastfetch](https://github.com/fastfetch-cli/fastfetch) 显示系统信息：内核版本、运行时长、主题、CPU、内存等等。是流行的 neofetch 工具的后继。

codeOS 把它打包成 codeOS 菜单（`Super + Space`）里的 _About_。

## 磁盘使用

当磁盘满了又不知道什么在吃空间时，从应用启动器（`Super + Space`）打开 _Disk Usage_。它就是交互模式的 [dua](https://github.com/Byron/dua-cli)，指向整个文件系统，你可以一层层走进元凶目录，按大小排序，直接在里面删东西。

## Cliamp

[Cliamp](https://www.cliamp.stream/) 是灵感来自 Winamp 2.x 的复古终端音乐播放器，还带内置的 lo-fi 电台。按 `Super + Shift + Alt + M` 启动，或从 codeOS 菜单的 _Apps_ 里打开。按 `?` 看全部键位。

## Wi-Fi 和 Bluetooth 呢？

Wi-Fi 和 Bluetooth 没有 TUI——那些事交给 codeOS Shell 了。点顶栏的 Wi-Fi 图标（或按 `Super + Ctrl + W`）看网络并连接，点 Bluetooth 图标（或按 `Super + Ctrl + B`）配对和连接设备。详见 [网络](35-networking.md)。

## 添加自己的

任何终端程序都可以有完整的应用待遇。去 codeOS 菜单的 _Install > TUI_（`Super + Space`），给它起个名字、一个启动命令、窗口样式和图标，它就会出现在应用启动器里和其他应用一样。_Remove > TUI_ 可以再次移除。
