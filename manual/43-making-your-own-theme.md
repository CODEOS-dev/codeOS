# 自己做主题

可以把自己的主题放到 `~/.config/omarchy/themes`。复制一个已有的主题当基础（在 `/usr/share/omarchy/themes` 里找），然后尽情调。只要在那个文件夹里，就会出现在主题选择菜单里。

主要要改的文件是 `colors.toml`。它定义了一套颜色，用来为终端（Foot/Alacritty/Ghostty/Kitty）、btop、Chromium、Hyprland、Neovim、Helix、VSCode、Obsidian 以及整个 codeOS Shell（顶栏、菜单、通知、OSD 和锁屏）生成配置。

也可以用自带的 Aether 应用——漂亮的 GUI 界面里玩颜色、搜索背景。在应用菜单里按 `Super + Alt + Space` 启动。

### 安装的主题里有什么

你写在 `~/.config/omarchy/themes` 里的主题想放什么都行——这是你的机器你的文件，codeOS 全部应用。

用 `omarchy theme install` 从别人的仓库装的主题只保留颜色相关的内容，丢掉会在你的机器上运行代码的少数文件：任何 `.lua` 文件、终端配置（`alacritty.toml`、`foot.ini`、`ghostty.conf`、`kitty.conf`）和 `vscode.json`。主题的 `hyprland.lua` 是合成器登录时执行的 Lua、终端配置定义终端启动的程序、`vscode.json` 指定要装的 VSCode 扩展。装别人的主题应该只改你桌面长什么样，永远不该改你跑什么。

其他一切都照主题作者写的原样——`btop.theme`、`chromium.theme`、`helix.toml`、`icons.theme`、`shell.toml`、背景和预览图全部保留。只有被丢掉的那些会从 `colors.toml` 在你机器上重新生成。

codeOS 通过主题内部是否有自己的 git 仓库来区分——也就是 `omarchy theme install` clone 时留下的。你自己写的主题归你自己管理，网上拉下来的只带颜色。

### 浅色模式

做浅色主题时，在 `colors.toml` 顶部设 `mode = "light"`。然后所有应用会自动配合切换到浅色模式（旧方式是在主题根目录放一个空文件叫 `light.mode`，仍然有效）。

### 图标颜色

如果想让文件管理器图标和主题配色匹配，加一个叫 `icons.theme` 的文件，写上你想用的图标集名。默认可选：`Yaru Yaru-blue Yaru-dark Yaru-magenta Yaru-olive Yaru-prussiangreen Yaru-purple Yaru-red Yaru-sage Yaru-wartybrown Yaru-yellow`。

### 解锁图片

带 `unlock.png` 和 `preview-unlock.png` 图片的主题会出现在 _Style > Unlock_ 下。`unlock.png` 最好是透明 png。预览图可以用 `omarchy plymouth preview` 创建。

### 为 codeOS 不覆盖的应用做主题

如果用的应用不在上面那串列表里，可以用模板教 codeOS 给它做主题。在 `~/.config/omarchy/themed/` 里放一个文件，命名为它生成的配置文件名加 `.tpl` 后缀，用 `{{ background }}`、`{{ foreground }}`、`{{ accent }}`、`{{ red }}`、`{{ color0 }}` 到 `{{ color15 }}` 以及调色板里其他颜色作为占位符。每次切主题时，文件就会用新主题的颜色重新生成。

那个文件夹里有一个完整注释的 `alacritty.toml.tpl.sample` 可以参考——列出了所有可用变量，还有 `_strip` 和 `_rgb` 修饰符给那些不要 `#` 或要十进制 RGB 的应用。你的模板优先于 codeOS 自己的，所以也可以用它来覆盖内置应用的主题方式。

### 分发自己的主题

想让别人用你的主题，需要放到公开的 git 服务器上，比如 GitHub。然后别人可以在 codeOS 菜单的 _Install > Style > Theme_ 里用那个 URL 安装。建议遵循命名规范 `omarchy-[主题名]-theme`，这样安装后主题选择菜单里只显示 `[主题名]`。

剩下的 `[主题名]` 就成了主题的目录名，所以必须是 codeOS 能安全处理的：以字母、数字或下划线开头，其余部分可以是字母、数字、`.`、`_`、`+` 和 `-`。大写会自动转小写，但其他任何东西——空格、引号、非英文字符——安装时会被拒绝而不是被转成目录名。所以 `omarchy-tokyo-night-theme`、`omarchy-flexoki_light-theme` 和 `omarchy-c++-theme` 都能正常安装。

记住从仓库安装后，主题里的 `.lua`、终端配置或 `vscode.json` 都会被丢掉，所以别围绕这些构建主题。

想让主题出现在[额外主题页面](https://omarchy.org/themes/)上，给[omarchy-site 仓库](https://github.com/omacom-io/omarchy-site)发 pull request。
