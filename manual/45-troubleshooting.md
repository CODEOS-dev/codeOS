# 故障排查

### 更新后搞坏系统了！

先尝试[回滚系统](47-system-snapshots.md)到最近一次更新前的版本。不行的话，用 `omarchy-debug` 到 Discord 的 #omarchy-help 分享问题。都不行，就用 `omarchy-reinstall` 重装默认配置和包。

### 为什么有些应用在我显示器上超大？

codeOS 假设用 2x 高分辨率显示器，这需要在 `~/.config/hypr/monitors.lua` 里把 `GDK_SCALE` 设为 2。但如果你用 1x 显示器，可以把 `local omarchy_gdk_scale = 2` 改成 1（然后重启任何变大的应用）。详见 [显示器手册](33-monitors.md)。

对 Spotify，可以用 `Ctrl + Minus` 缩小 UI（`Ctrl + Plus` 放大）。

### Caps Lock 为什么不工作了？

在 codeOS 里，Caps Lock 被指定用作 xcompose 键。这就是你能做到[快速 emoji](07-hotkeys.md#quick-emojis)和[其他自动补全](07-hotkeys.md#quick-completions)的方式。如果真的怀念 Caps Lock，编辑 `~/.config/hypr/input.lua` 把 xcompose 键改成别的，比如右 Alt 键：

```
hl.config({
  input = {
    kb_options = "compose:ralt",
  },
})
```

### Wi-Fi、Bluetooth、Audio 或 Touchpad 突然不工作了

重启前，先单独重启出问题的那个子系统。codeOS 菜单里的 _Update > Hardware_ 下有 Wi-Fi、Bluetooth、Audio 和 Trackpad，重新加载其中一个能解决大部分"五分钟前还好好的"的情况——蓝牙耳机连不上、挂起后触摸板死掉、拔掉显示器后声音消失。

### 外接音响为什么不出声？

可能是没设成默认输出。点击顶栏右侧的扬声器图标，打开音量弹窗，里面可以选输出设备（还能按应用调音量）。

### 笔记本音响声音不对

某些笔记本上，codeOS 会自动应用一个音响调优来纠正内置扬声器的频率响应。`omarchy audio tuning status` 查看你的机器上是否启用了调优，`omarchy audio tuning off` 关掉它听原生效果。

### 为什么我输密码登录或 sudo 时不行了？

可能是密码输错太多被锁了。如果在锁屏上，可以按 `CTRL + ALT + F2` 打开一个新的 TTY，以 root 登录后运行 `faillock --reset --user [你的用户名]`。这会重置锁定，就好了。

### 1Password 的 SSH Agent/CLI 授权提示为什么不出来？

有两个原因：

要出现漂亮的授权提示，Settings > Advanced > Use Hardware Acceleration 必须开启。_注意：这需要重启才能生效。_

 ![troubleshooting-1password](images/troubleshooting-1password.webp)

或者如果你启动后还没开过 1Password，提示也不会出来。
