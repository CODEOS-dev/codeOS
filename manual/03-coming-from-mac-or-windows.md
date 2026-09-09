# 从 Mac 或 Windows 过来

如果你用了很多年的 macOS 或 Windows，你的手指记住了上百种你以为早就忘掉的操作直觉。本章就是翻译层：告诉你这些直觉在 codeOS 里对应什么。各项功能本身会在其他章节详细展开——这里只是一张地图。

### Super 是一切的核心

你围绕 Cmd 或 Windows 键养成的所有肌肉记忆，都会迁移到一个键上：Super。在 PC 键盘上就是 Windows 键，它也是 codeOS 中几乎所有快捷键的锚点。

你对 Spotlight、Raycast 或开始菜单的反应，会变成按 `Super + Space`。它会打开 codeOS 菜单——能启动应用、改设置、装软件、截屏——几乎什么都能做。开始输入来过滤。还有一个纯应用菜单在 `Super + Alt + Space`。详见 [导航](04-navigation.md)。

### 没有 Dock，也没有桌面图标

没有东西可点击来启动应用，桌面也不需要摆放图标。应用通过快捷键启动（终端用 `Super + Return`，浏览器用 `Super + Shift + Return`，`Super + K` 可以看所有绑定列表），或者从菜单启动。唯一常驻的 UI 元素是 [顶栏](05-the-top-bar.md)，它替代了菜单条、系统托盘和通知中心——而且顶栏上几乎每个小组件都对左键、右键和中键有不同反应。

### 窗口自动排列

最大的思维转变：你不用拖动窗口，也不用把它们吸附到屏幕的一半。打开一个窗口，它全屏铺开。再开一个，它们就平分。你永远不会把一个窗口从另一个下面捞出来，因为窗口不会重叠。

当你确实需要一个浮动窗口时，`Super + T` 可以把当前窗口从平铺中切换出来（再按一次切回去）。但先给平铺一个真正尝试的机会——它是整个系统的核心。[导航](04-navigation.md) 会带你逐步熟悉。

工作区（Workspace）你应该会觉得熟悉：它们就是 macOS 的 Spaces 或 Windows 的虚拟桌面，区别是你真的会用，因为 `Super + 1/2/3/4` 直接跳到对应工作区，`Super + Shift + 1/2/3/4` 把当前窗口送过去。没有动画延迟，瞬间切换。这意味着如果你以前习惯用多显示器，现在可能都不需要了。

### 复制粘贴就那样工作

在 Mac 上你到处用 Cmd + C。在 Windows 上你到处用 Ctrl + C——除了终端里会杀掉你的程序。codeOS 给你的是 `Super + C`、`Super + X`、`Super + V`，它们在任何地方都能用，包括终端。不用为 shell 单独学一套。

Windows 用户：你的 Win + V 剪贴板历史搬到了 `Super + Ctrl + V`，而且既存文字也存图片。详见 [统一剪贴板与历史](08-unified-clipboard-history.md)。

### 对照表

| 你想找的 | 在 codeOS 里 |
| ------------- | ---------- |
| Spotlight / Raycast / 开始菜单 | `Super + Space` — codeOS 菜单 |
| AirDrop | LocalSend，通过 `Super + Ctrl + S` — 详见 [图形应用](22-guis.md) |
| Cmd + Shift + 4 / Win + Shift + S | `Print Screen` — 详见 [截屏与录屏](12-screenshots-recording.md) |
| 通知中心 | `Super + Shift + Alt + ,` 打开通知历史 |
| Time Machine（系统级） | 每次更新自动 [系统快照](47-system-snapshots.md) |
| App Store / 下载安装器 | 菜单里的 _Install_，或 `omarchy pkg add` — 详见 [其他软件包](29-other-packages.md) |
| 系统设置 / 控制面板 | 菜单里的 _Setup_，直接编辑纯配置文件 — 详见 [点文件](31-dotfiles.md) |

### 有些东西确实不一样

很多设置存放在你编辑的文本文件里，而不是点来点去的面板。听起来很原始，但你很快会意识到这意味着每一项调整都能看到、复制到下一台机器、纳入版本控制。_Setup_ 菜单会直接把你带到对应的文件，并在你改完后重启需要重启的东西。

更新通过一个命令完成——菜单里的 _Update > Omarchy_——它更新 codeOS 本身以及系统上的所有软件包，更新前自动做快照。没有各种应用各自弹出的更新提示。详见 [更新](30-updates.md)。

软件通过包管理器安装，而不是下载安装器。

还有，当你关闭窗口时，应用真的会退出。没有 macOS 那种程序还在后台运行但窗口全关了的中间状态。`Super + W`——或者 `Super + Q`，如果你带过来的肌肉记忆是这个——意味着彻底没了。

### 在 Mac 硬件上

codeOS 在 Intel Mac 上运行良好——详见 [Mac 支持](44-mac-support.md)。而且键盘对你很友好：codeOS 不会重映射任何键，Linux 把 Command 键当作 Super，所以 Super 就在 Cmd 一直所在的位置。你的拇指根本不会察觉到变化。

### 给它两周时间

直觉迁移比你想象的要快。快速过一遍 [快捷键](07-hotkeys.md) 章节，每当忘了某个绑定时，按 `Super + K`——它会显示全部。这是唯一一个你真正需要记住的快捷键。
