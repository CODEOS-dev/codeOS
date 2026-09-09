# 常见调整

这里收集了 codeOS setup 的常见定制。注意系统更新可能偶尔需要把某些配置恢复到原始状态。如果发生，你的改动不会丢失，而是放到同目录的 `.bak` 文件里。

如果搞砸了，可以通过 codeOS 菜单的 _Update > Config_ 恢复个别配置到原始状态。如果 **真的** 搞砸了全部，用 `omarchy-reinstall` 重置所有配置。

### 一直显示托盘图标

默认托盘图标（比如 Dropbox、1password、Steam）隐藏在托盘展开箭头后面，悬停箭头才显示。想让它们一直露出来，右键展开箭头打开托盘图标管理器，把想一直可见的固定住（也可以把不想看的藏起来）。

### 圆角窗口

codeOS 默认方角设计，但如果你想柔和一点，可以改 `~/.config/hypr/looknfeel.lua`，把 rounding 那行的注释去掉：

```
hl.config({
  decoration = {
    -- 使用圆角窗口
    rounding = 8,
  },
})
```

### 去掉窗口间距

在笔记本显示器上，有人不想浪费像素在窗口间距上（甚至顶栏也可以用 `Super + Shift + Space` 关掉）。用 `Super + Shift + Backspace` 一键关掉所有间距和边框，或者在 `~/.config/hypr/looknfeel.lua` 里去掉注释永久生效：

```
hl.config({
  general = {
    -- 窗口间无间距无边框
    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,
  },
})
```
