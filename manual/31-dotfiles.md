# 点文件

codeOS 主要通过 `~/.config` 里所谓的"点文件"（dotfiles）配置。那些是你的文件，你随便改。`/usr/share/omarchy` 里的属于 codeOS 本身，你不该去动。如果要改 `/usr/share/omarchy` 里的任何东西，应该在 `~/.config` 里覆盖对应的值。

关键配置文件可以直接从 codeOS 菜单（`Super + Space`）里编辑，比如 _Setup > Monitors_、_Setup > Keybindings_、_Setup > Input_、_Setup > Config > [file]_。这样改完退出编辑器后，需要重启的进程会自动重启（默认编辑器是 Neovim——记得 `:wq`！——也可以通过 _Setup > Defaults > Editor_ 换）。

以下是 `~/.config` 里关键文件及其作用：

| 文件                  | 用途              |
| ----------------------- | --------------------- |
| `~/.config/hypr/hyprland.lua` | Hyprland 主配置。加载 codeOS 默认值和你的覆盖文件。[Hyprland 配置文档](https://wiki.hypr.land/Configuring/)。  |
| `~/.config/hypr/bindings.lua` | 自定义快捷键和默认值覆盖。 |
| `~/.config/hypr/monitors.lua` | 控制显示器、分辨率和位置。 |
| `~/.config/hypr/input.lua` | 控制键盘布局、鼠标和触摸板设置。 |
| `~/.config/hypr/looknfeel.lua` | 控制间距、边框、动画等外观。 |
| `~/.config/hypr/autostart.lua` | 控制随会话启动的额外进程。 |
| `~/.config/omarchy/shell.json` | 控制 codeOS Shell：顶栏位置、布局、小组件，以及屏保、锁屏和空闲计时。 |
| `~/.config/foot/foot.ini` | 控制终端（默认 foot）。 |
| `~/.XCompose` | 定义快速 emoji 和名字/邮箱自动补全。改完记得跑 `omarchy-restart-xcompose`。 |

如果你做了大量修改来定制自己的 setup，备份所有这些点文件是个好主意。[Stow 是个很棒的备份方式](https://www.youtube.com/watch?v=NoFiYOqnC4o)。

### 随会话启动自己的应用

如果想让某些东西每次登录都运行——比如同步守护进程、聊天应用、自己的脚本——放到 `~/.config/hypr/autostart.lua`：

```lua
o.launch_on_start("my-service")
```

这会作为会话的一部分启动，所以你登出时会被正确清理。

### 在系统事件上运行脚本

codeOS 在几个关键时刻触发钩子，你可以把自己的脚本挂上去。它们放在 `~/.config/omarchy/hooks/<event>.d/`，每个事件一个目录，里面所有可执行文件都会在事件发生时运行：

| 事件 | 触发时机 |
| ----- | ------------ |
| `post-boot` | 桌面启动后立即 |
| `post-update` | `omarchy update` 期间，包和迁移都完成后 |
| `pre-refresh-pacman` | `omarchy refresh pacman` 重新同步包配置前 |
| `theme-set` | 主题切换后（主题名在 `$1`） |
| `font-set` | 字体切换后（字体名在 `$1`） |
| `battery-low` | 电量过低时（百分比在 `$1`） |

每个目录里已经有一个 `.sample` 文件展示钩子的格式——把 `.sample` 去掉就能用。要安装写好的脚本，用 `omarchy hook install post-boot ~/my-hook`，它会把脚本复制进去并设为可执行。

### 添加自定义菜单项

codeOS 菜单（`Super + Space`）可以通过编辑 `~/.config/omarchy/extensions/omarchy-menu.jsonc` 添加自己的行。条目用点分隔的 id 作为键，id 决定了它在树里的位置，所以 `personal` 出现在根菜单，`personal.notes` 出现在它里面：

```jsonc
"personal": {"icon":"","label":"Personal"},
"personal.notes": {"icon":"󰎞","label":"Notes","action":"omarchy-launch-editor ~/notes"},
```

复用已有的 id 就会覆盖那一条而不是新建。文件里有全部可用字段的注释说明。

### 添加自己的 shell exports、函数和别名

codeOS 自带一批符合人体工学的别名和有用函数，但你肯定想加自己的。别名、函数和 exports 都应该加在 `~/.bashrc` 里。这个文件更新时不会被覆盖。想改 codeOS 默认值也可以安全地加在这里。

### 修改 codeOS 内部文件

听着，这是你的电脑。你想干嘛都行，但我建议不要直接改 `/usr/share/omarchy` 里的文件。它们属于 codeOS 的 pacman 包，下次更新你的改动就会被覆盖。你最好在 `~/.config/*` 文件夹里覆盖你不喜欢的默认值。

几乎所有东西都可以这么改，比如默认快捷键。编辑 `~/.config/hypr/bindings.lua`，比如把 [Obsidian](https://obsidian.md/) 换成 [Joplin](https://joplinapp.org/)（用 `omarchy-pkg-add joplin-bin` 安装）：

```lua
o.rebind("SUPER + SHIFT + O", "Joplin", "joplin-desktop")
```

`o.rebind` 会先移除已有绑定再加新的。它接受和 `o.bind` 同样的参数，包括启动助手和绑定选项。用 `o.bind` 添加绑定，或 `hl.unbind` 只移除不替换。

如果你硬要 hack codeOS 内部文件，通过 _Update > Channel > Dev_ 切到 dev 通道。它会把 codeOS 链接到 `~/omarchy` 里源码的 git checkout，你想怎么改就怎么改。没人拦你！

### 重置所有改动

如果配置搞砸了，随时可以通过 codeOS 菜单里的 _Update > Config_ 恢复默认。或者运行 `omarchy reinstall configs` 全部重置。
