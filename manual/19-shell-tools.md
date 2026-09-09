# Shell 工具

除了标准 Linux 工具，codeOS 还预装了一批增强版 Shell 工具。重点介绍以下几个。

## fzf

[fzf](https://junegunn.github.io/fzf/) 通过 `ff` 别名提供文件模糊查找。进入任意目录，输入 `ff`，就能在右侧预览的帮助下模糊找到树里的任意文件。

`Ctrl + R` 可以用 fzf 模糊搜索命令历史。

这个工具也被 Neovim 在你输入 `Space Space` 时使用。

完整手册见 `man fzf`。

## Zoxide

[Zoxide](https://github.com/ajeetdsouza/zoxide) 是 `cd` 的替代品。它记住你去过的目录，下次更容易跳回去。比如你 `cd ~/.config/omarchy` 过一次，下次直接 `cd omarchy`（甚至 `cd oma`），Zoxide 就把你带过去。

完整手册见 `man zoxide`。

## ripgrep

[ripgrep](https://github.com/BurntSushi/ripgrep) 用 `rg <pattern> <path>` 搜索文件内容，比如 `rg Controller app/` 在 app 目录里找所有 `Controller` 出现的地方。

这个工具也被 Neovim 在你输入 `Space S G` 时使用。

完整手册见 `man rg`。

## eza

[eza](https://eza.rocks/) 是 `ls` 的替代品。给你更多信息、颜色和图标的目录列表。默认 `ls` 已经被 alias 成 eza。`lt` 可以看两层深度的嵌套列表。`lsa` 包含隐藏文件。`lta` 嵌套列表加隐藏文件。

完整手册见 `man eza`。

## fd

[fd](https://github.com/sharkdp/fd) 是 `find` 更易用的替代品。`fd person.rb` 在当前目录树里找 `person.rb` 文件。`fd person.rb /` 搜整个文件系统。`fd person.rb / -H` 搜整个文件系统，包括隐藏目录。

完整手册见 `man fd`。

## bat

[bat](https://github.com/sharkdp/bat) 就是带语法高亮、行号和分页的 `cat`。运行 `bat somefile.rb` 你就知道为什么回不去了。它在后台也帮你做事：你的 man pages 颜色就是它给的，`ff` 里的预览也是它渲染的。

完整手册见 `man bat`。

## tldr

[tldr](https://tldr.sh/) 是 man pages 的解药——不用先翻三屏历史才看到一个例子。`tldr tar` 直接给你那几个你真正想要的用法。

## yt-dlp

[yt-dlp](https://github.com/yt-dlp/yt-dlp) 从 YouTube 和上百个其他网站下载视频。`yt-dlp <url>` 把当前可用的最高画质抓到当前目录。

完整手册见 `man yt-dlp`。

## try

[try](https://github.com/tobi/try) 用日期戳目录方便地管理编程实验。所有实验都在 `~/Work/tries` 下，通过 `try` 访问。
