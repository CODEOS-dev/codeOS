# 开关、空闲与屏保

日常里你改的很多东西其实不是设置。是一个模式，开一小时再关掉：工作到很晚开夜灯、做演示时开勿扰、看东西时保持清醒。codeOS 叫它们"开关"，每个都有三种操作方式——快捷键、菜单入口、CLI 命令——全部指向同一个状态。

### 开关菜单

`Super + Ctrl + O` 直接打开 _Trigger > Toggle_，也可以从 codeOS 菜单（`Super + Space`）里进去。列表里的每一项都是一个开关，不用关心状态存在哪里。

终端里同样的开关用 `omarchy toggle <thing>`。单独运行 `omarchy toggle` 看全部。

| 开关 | 快捷键 | 命令 |
| ------ | ------ | ------- |
| 夜灯 | `Super + Ctrl + N` | `omarchy toggle nightlight` |
| 静音通知 | `Super + Ctrl + ,` | `omarchy toggle notification silencing` |
| 保持清醒（空闲不锁定） | `Super + Ctrl + I` | `omarchy toggle idle` |
| 崩溃捕获 | — | `omarchy toggle crash-capture` |
| 屏保 | — | `omarchy toggle screensaver` |
| 顶栏 | `Super + Shift + Space` | `omarchy toggle bar` |
| 触摸板 | `XF86TouchpadToggle` | `omarchy toggle touchpad` |
| 触摸屏 | — | `omarchy toggle touchscreen` |
| 挂起 | — | `omarchy toggle suspend` |
| 混合 GPU | — | `omarchy toggle hybrid gpu` |

触摸板、触摸屏和混合 GPU 的开关在 _Trigger > Hardware_（`Super + Ctrl + H`）下，不在 Toggle 里，因为只有检测到对应硬件时才显示。触摸板和触摸屏的开关在 Hyprland 重载后还能保持——禁用的设备名存到一个小状态文件里，Hyprland 启动时读它再次禁用。

Toggle 菜单里还有几个不是 `omarchy toggle` 命令但行为一样的项：顶栏的电量百分比、工作区布局（`Super + L`）、窗口间距（`Super + Shift + Backspace`）、单窗口正方形比例（`Super + Ctrl + Backspace`）。

这些开关大多就是 `~/.local/state/omarchy/toggles/` 下的标志文件。想在脚本里判断某个开关状态，`omarchy-toggle-enabled` 用退出码告诉你答案：

```bash
omarchy-toggle-enabled screensaver-off && echo "screensaver is off"
```

标志都是以"关闭状态"命名的——`screensaver-off`、`suspend-off`、`bar-off`——所以存在就表示该功能已禁用。

### 顶栏的指示器

模式开启时，顶栏中间、时钟旁边会出现一个小图标，就是指示器小组件。它覆盖了听写、录屏、待处理提醒、夜灯、勿扰、保持清醒。

未激活的指示器默认隐藏。把鼠标移到那个区域就会淡入变暗显示，这样你可以直接点击开启，不用记快捷键。点击激活的指示器就关掉它。如果想一直看到所有指示器，在 `~/.config/omarchy/shell.json` 里给 `omarchy.indicators` 条目设 `alwaysShow` 为 `true`——顶栏小组件配置方式见 [顶栏](05-the-top-bar.md)。

### 夜灯

`Super + Ctrl + N` 把屏幕色温调到 4000K，再按一下回到 6500K。底层用 hyprsunset，如果没运行 toggle 会帮你启动。

默认 hyprsunset 什么也不做。`~/.config/hypr/hyprsunset.conf` 默认是一个 identity 配置，就是为了让显示器保持原样直到你主动开夜灯。想让它按时间自动切换，换成时间配置：

```
profile {
    time = 20:00
    temperature = 4000
}
```

然后在 `~/.config/hypr/autostart.lua` 里加 `o.launch_on_start("hyprsunset")` 让它登录时启动。toggle 用的 4000K/6500K 是固定值，想调别的色温要改配置文件。

### 勿扰

`Super + Ctrl + ,` 静音通知。开启时不会弹出 toast 通知，顶栏上会出现一个被划掉的铃铛图标提醒你为什么桌面突然安静了。

但什么都不会丢。被静音的通知直接写入通知历史——当你回来想看"刚才漏了什么"时，这就是完整记录。按 `Super + Shift + Alt + ,` 打开。通知的更多内容见 [通知提醒](10-notices.md)。

有两种消息还是能穿透：codeOS 自己对你刚做完事情的确认 toast（比如"主题已更换"、"截图已保存"），以及命令行发出的紧急告警。聊天应用把所有消息都标紧急来硬闯的不算。

### 空闲行为

空闲行为由 codeOS Shell 管理，计时设置在 `~/.config/omarchy/shell.json` 的顶层 `idle` 块里：

```json
{
  "version": 1,
  "idle": {
    "screensaver": 150,
    "lock": 300
  }
}
```

两个数字都是从进入空闲时开始算的秒数——互不从属。默认配置下，空闲两分半钟后屏保启动，五分钟后锁屏，不管屏保有没有跑过。保存文件后 Shell 会立即采用新计时。

如果锁屏前你动了下屏保就退了，这算活动，待执行的锁屏会被取消。不会因为看了一眼机器就被锁在外面。

想完全关闭空闲锁定，按 `Super + Ctrl + I`（或 `omarchy toggle idle`）开启保持清醒，顶栏会出现咖啡杯图标。做长演示或看编译进度时开这个。再按一下恢复正常。`omarchy toggle idle status` 会输出 JSON 格式的当前状态，方便脚本用。

这里只管锁屏和屏保，不管电源。挂起和休眠在 [系统睡眠](36-system-sleep.md) 里单独配置。

### 屏保

codeOS 的屏保是 ASCII 艺术加随机文字效果，每个显示器一个实例。任意按键或鼠标移动退出。

可以从 _System > Screensaver_（`Super + Esc`）手动触发，即使你关了空闲屏保也能强制弹出。默认没绑定快捷键。

`omarchy toggle screensaver` 用来关闭空闲屏保，如果你想让机器一空闲就直接锁屏的话。它需要一个能自动配置的终端——Alacritty、Foot、Ghostty 或 Kitty——如果你的默认终端不是这些，会提示你。

屏保显示的 logo 可以改，在 _Style > Screensaver_。上传 png 或 svg，codeOS 会把它转成 ASCII。详见 [品牌定制](41-branding.md)。

### 锁屏

`Super + Ctrl + L` 锁屏。它会运行 codeOS Shell 的锁屏、黑屏、把键盘布局重置到第一个（避免用错字母输密码），并且如果 1Password 在运行的话顺便锁一下。

锁屏支持密码，设置好指纹后也能用指纹。这些以及其他认证方式见 [硬件认证](37-hardware-authentication.md)。
