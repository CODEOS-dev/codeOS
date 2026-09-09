# 开发工具

## 备选编辑器

codeOS 默认带 [Neovim](https://neovim.io/)，但如果你想要更主流熟悉的，打开 codeOS 菜单（`Super + Space`）去 _Install > Editor_ 看选项。有 VSCode、Cursor、Zed、Sublime Text、Helix、Vim 和 Emacs。没找到想要的？看看 _Install > Package_ 里有没有 Arch 包（没有的话试 _Install > AUR_ 查 AUR）。

原版 `vi` 编辑器也有，直接 `vi filename` 在终端里编辑文件。

`VSCode`、`Cursor`、`VSCodium` 和 `Helix` 支持主题同步。

系统默认编辑器在 _Setup > Defaults > Editor_ 里设。

## 开发环境

codeOS 菜单（`Super + Space`）的 _Install > Development_ 可以安装大量开发环境。当然有 _Ruby on Rails_，还有 JavaScript 的三个主流运行时（Node.js、Bun、Deno），热门 PHP 框架 Laravel 和 Symfony。另外还有 Go、Rust、Python、Java、Elixir（带 Phoenix）、.NET、OCaml、Zig、Clojure 和 Scala。选择非常广！

这些环境大多由 [Mise](https://mise.jdx.dev/) 管理。它让你在同一台机器上安装和运行同一语言的多个版本。就像 Ruby 的 rbenv/rvm 或 Python 的 virtualenv，但一套搞定多种语言。

比如装 Ruby 就运行 `mise use -g ruby`，既安装又设为全局默认。或者项目有 .ruby-version 文件的话，在项目根目录直接 `mise i`。

## Docker

[Docker](https://www.docker.com/) 不用多介绍。它让你运行隔离容器，codeOS 会装好 Docker 本身和 [Docker Compose](https://docs.docker.com/compose/)。

默认你的用户 **不在** `docker` 组里。那个组相当于无密码 root——里面的任何东西都能 `docker run -v /:/host` 接管机器——所以一个恶意脚本或依赖以你的身份运行就等于给了 root。所以命令行里用 `sudo docker ps`、`sudo docker compose up`，而和守护进程对话的图形工具——`Super + Shift + D` 打开的 Docker TUI 和 Windows VM——在需要时会请求授权。如果你想用免组的便利并且理解风险，可以在 **Setup > Security > Sudoless Docker**（或运行 `omarchy-setup-security-sudoless-docker`）启用，会先警告再把你加入 `docker` 组；之后直接 `docker` 和 `d` 别名就能用了。

按 `Super + Shift + D` 打开 Lazydocker，在酷炫的 TUI 里管理容器；第一次会请求授权，除非你启用了 sudoless Docker。

可以在 codeOS 菜单的 _Install > Development > Docker DB_ 里装本地开发常用的数据库。

## GitHub CLI

[GitHub CLI](https://cli.github.com/) 让你登录 GitHub 账号并克隆私有仓库。它也是懒加载的 mise 桩代码，第一次运行 `gh` 会自动安装。认证用 `gh auth login`。然后就可以用 `gh repo clone org/repo` 克隆私有仓库。

还可以做很多其他 GitHub 操作，直接运行 `gh` 看全部。

`ghui` 也有懒安装桩代码，用来在 TUI 里管理 Pull Request。[lazygit](https://github.com/jesseduffield/lazygit) 也是预装的，如果你也想在 TUI 里管理 git 本身。
