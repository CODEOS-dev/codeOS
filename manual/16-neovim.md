# Neovim

[Neovim](https://neovim.io/) 是 [vi 编辑器](https://en.wikipedia.org/wiki/Vi_(text_editor)) 的现代实现——那个 1976 年 Bill Joy 创建的老古董。它是一个模式编辑器，插入模式和命令模式分开，学会哪怕一小部分极其丰富的键命令集后，它就是超能力。但学习曲线也确实陡！

如果你完全没接触过 vim 风格编辑，我推荐去 YouTube 看 [ThePrimeagen 的 Vim As Your Editor 系列](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)，能教你基础。只是有心理准备：不像主流编辑器，vim 的基础熟练度需要更长时间，但一旦掌握，回报也更大。

Neovim 几乎可以无限配置。想自己玩的话可以从零搭。[Typecraft 有一门从零搭建 Neovim 的课程](https://www.youtube.com/watch?v=zHTeCSVAFNY)，[ThePrimeagen 也有](https://www.youtube.com/watch?v=w7i4amO_zaE)。

但 codeOS 自带一套完整的 Neovim 配置——`omarchy-nvim` 包——精心调优以展示开箱即用的最佳体验。你一行配置都不用写！它基于 [LazyVim](https://www.lazyvim.org/)，一个 Neovim 插件和配置的发行版，非常棒。

## LazyVim 基础

简短介绍里就不教你 vim 了，但可以给你展示 LazyVim 的一些基础和导航方式。

首先，Neovim 有 leader 键的概念。这是通向所有命令的门户。LazyVim 把它设成了 `Space`。按一下，等一秒，就会看到很多内联说明的选项。

这里是我常用的几个命令：

- `Space Space` - 模糊搜索当前目录下的任意文件。
- `Space S G` - 用 rg 搜索所有文件内容并带预览。
- `Space E` - 切换文件树开/关。
- `Ctrl + W W` - 在文件树和编辑器之间跳。
- `Shift + H` - 在打开的标签页之间左移（vim 叫 buffer）。
- `Shift + L` - 在打开的标签页之间右移。
- `Space B D` - 关闭一个标签页。
- `Space B O` - 关闭除当前外的所有标签页。
- `Space G G` - 在浮动分屏里启动 LazyGit。
- `Space U W` - 切换软换行。

在文件树里（`Space E` 打开，`Ctrl + W W` 跳过去），`a` 新建文件、`A` 新建目录。在树里按 `?` 看所有命令。

想学 vim 基础语法的话，我写过 [三段式语法](https://world.hey.com/dhh/wonderful-vi-a1d034d3)，教你怎么打出那些酷炫的连招！

所有命令见 [LazyVim 键位页面](https://www.lazyvim.org/keymaps)。

## 启动 Neovim

可以按 `Super + Shift + N` 启动（这个绑定会启动你的默认编辑器，codeOS 默认就是 Neovim），但更方便的方式是在终端里 `cd` 到项目目录然后输入 `n`。`n` 是 `nvim` 的别名，默认打开当前目录。`n myfile.txt` 打开单个文件。

## 用 Neovim 编辑需要 sudo 的文件

如果要编辑只能超级用户改的文件，可以用 `sudoedit /etc/sudoers.d/00-sudo-only-file`，这样能带上你全部的 Neovim 插件配置。
