# 显示器

codeOS 默认假设你在用支持 2x 缩放的 Retina 级显示器。这是获得漂亮锐利的程序员字体所需要的。这也是几乎所有高端高分辨率新笔记本优化的目标。在 27" 5K [Apple Studio Display](https://www.apple.com/studio-display/)/[ProArt PA27JCV](https://www.asus.com/us/displays-desktops/monitors/proart/proart-display-5k-pa27jcv/)/[Samsung S9](https://www.samsung.com/us/computing/monitors/5k/27-viewfinity-s9-5k-monitor-with-thunderbolt-4-matte-display-and-smart-features-ls27c900panxza/)/[Kuycon G27P](https://kuycon.us/monitors/G27P/) 或 32" 6K [Apple XDR](https://www.apple.com/pro-display-xdr/)/[ProArt PA32QCV](https://www.asus.com/displays-desktops/monitors/proart/proart-display-6k-pa32qcv/)/[Kuycon G32P](https://kuycon.us/monitors/G32P/) 上你也想用这个。

但如果你的显示器 PPI 不到 218，就需要改显示器设置。比如 27" 或 32" 4K 显示器，可以打开 `~/.config/hypr/monitors.lua`（通过 codeOS 菜单的 _Setup > Monitors_），换成适合这种组合的推荐值：

```lua
local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6
```

如果是 1080p 或 1440p，可能直接用 1x 缩放就行：

```lua
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1
```

`GDK_SCALE` 的改动对改完后启动的应用生效（而且 GTK 只接受整数，所以要保持最接近你显示器缩放的整数）。所以改完后把变大的窗口关掉（或用 `Ctrl + Alt + Del` 关所有窗口！）。

也可以用 `Super + /` 快速在主要缩放比例（1x、1.25x、1.6x、2x、3x、4x）之间往高调，`Super + Alt + /` 往低调。用默认配置的话，这些改动重启后还保留。

### 让文字变大或变小

显示器缩放会改变一切的大小。如果你只是想让文字大一点或小一点，有一个单一开关：

```
omarchy display text size 14
```

接受 9 到 20 之间的像素值，会同步调整 codeOS Shell、GTK 应用和终端，整个桌面保持比例。不带参数运行看当前值，`omarchy display text size reset` 回到默认。Foot 是唯一比较落后的：它没法重新加载配置，所以已运行的终端保持旧大小，新开的终端才用新值。

### 笔记本外接显示器的扩展和镜像

笔记本接上外接屏幕时默认自动扩展显示。可以通过 codeOS 菜单的 _Trigger > Hardware_ 或 `Super + Ctrl + Alt + Delete` 改成镜像。特别适合作演示时，想用投影展示同时自己在操作。

扩展模式下，合上笔记本盖子会自动关闭内屏。打开盖子会重新开启。也可以通过 codeOS 菜单的 _Trigger > Hardware_ 或 `Super + Ctrl + Delete` 手动控制。

### 排列多屏

Hyprland 对多屏支持很好。更多关于布局的内容见 [Hyprland 显示器文档](https://wiki.hypr.land/Configuring/Basics/Monitors/)。也可以[把特定工作区绑定到特定显示器](https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/)。在 codeOS 里，这些规则作为 `hl.monitor` 条目放在 `~/.config/hypr/monitors.lua` 里——文件里带了注释示例，展示如何固定某个显示器的分辨率、位置和旋转。

也可以看看 [Hyprmon](https://github.com/erans/hyprmon/)，一个帮你多屏定位的 TUI。

### 控制亮度

显示器亮度由专用的亮度增减功能键控制。按住 Shift 再按就能直接跳到最亮或最暗。这些键控制你当前聚焦的那个显示器，所以支持 DDC/CI 的外接显示器和笔记本屏幕一样可以调整。

### Apple 显示器

如果你用 Apple 显示器，聚焦在 Apple 显示器上时，常规键盘亮度键会自动生效。这通过 `asdcontrol` 命令实现。

注意如果用 Apple 6K XDR 显示器，`hyprctl monitors` 里可能会出现一个幽灵屏幕。可以在 _Setup > Monitors_ 里用 `hl.monitor({ output = "DP-2", disabled = true })` 关掉它。

Intel 机器上，用常规 Thunderbolt 线连 Apple 显示器。没有 Thunderbolt 的机器，通常需要用 [DP + USB-A -> USB-C 线缆](https://www.amazon.com/dp/B0BNX7MS6N) 才能用。
