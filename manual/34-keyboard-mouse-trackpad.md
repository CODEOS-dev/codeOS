# 键盘、鼠标、触摸板

Hyprland 让你可以非常细粒度地配置所有输入设备。可以把键盘重复调到超快，或让触摸板用自然滚动。所有这些都在 `~/.config/hypr/input.lua` 里改，也可以通过 codeOS 菜单（`Super + Space`）的 _Setup > Input_ 进入。在那里设置的任何值都会覆盖 codeOS 的默认。

示例：

```lua
hl.config({
  input = {
    -- 使用多种键盘布局，用 Left Alt + Right Alt 切换
    kb_layout = "us,dk",
    kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",

    -- 调整键盘重复速度
    repeat_rate = 40,
    repeat_delay = 600,

    -- 提高鼠标/触摸板灵敏度（默认 0）
    sensitivity = 0.35,

    touchpad = {
      -- 使用自然（反向）滚动
      natural_scroll = true,

      -- 用双指点击右键而不是右下角
      clickfinger_behavior = true,

      -- 控制滚动速度
      scroll_factor = 0.3,
    },
  },
})

-- 在终端里滚动更快
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
```

[Hyprland wiki 的输入页](https://wiki.hypr.land/Configuring/Basics/Variables/#input)里能看到全部输入选项。

默认 codeOS 把 CapsLock 用作 [快速 emoji](07-hotkeys.md#quick-emojis) 和 [其他补全](07-hotkeys.md#quick-completions) 的 compose 键。如果想把 CapsLock 当回大写锁定，把 compose 键挪到别处，改 `kb_options` 里的 `compose:caps`。比如挪到 Right Alt：

```lua
hl.config({
  input = {
    kb_options = "compose:ralt",
  },
})
```

### 触摸板手势

也可以开[触摸板手势](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/)，比如三指滑动切换工作区：

```lua
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
```

在有 haptic 触摸板的 Dell XPS 上，可以通过 _Trigger > Hardware > Touchpad Haptics_ 把点击力度设为低、中、高。

### 输入中文、日文等其他语言

codeOS 每个会话里都运行 [fcitx5](https://fcitx-im.org/) 输入法框架——就是它驱动 CapsLock compose 序列。意味着非拉丁输入的基础已经就位：用 `omarchy pkg add` 装输入引擎，比如 `fcitx5-mozc`（日文）或 `fcitx5-chinese-addons`（中文），再装 `fcitx5-configtool` 把引擎加到你的输入法并设置切换快捷键。

### 用 ALT 当 SUPER

有些键盘上用主键（Windows/Cmd 键）当 SUPER 不太方便。可以改成用 ALT：

```lua
hl.config({
  input = {
    kb_options = "compose:caps,shift:both_capslock_cancel,altwin:swap_alt_win",
  },
})
```
