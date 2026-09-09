# codeOS CLI

codeOS 通常通过快捷键和 codeOS 菜单（`Super + Space`）控制，但也可以通过 `omarchy` CLI 控制。这在你让 AI Agent 帮你定制或配置时特别有用。

CLI 可以访问菜单和其他地方用的所有内部工具。在终端里运行 `omarchy` 就能看到全部可用命令。

大概长这样：

```
~ ❯ omarchy
Omarchy command center

Usage:
  omarchy <command> [args...]
  omarchy commands [--all] [--json] [--check]
  omarchy <group> --help
  omarchy <group> <command> --help

Common commands:
  omarchy update              Update Omarchy and system packages
  omarchy theme list          List available themes
  omarchy theme set <name>    Apply a theme
  omarchy font list           List available fonts
  omarchy screenshot          Take a screenshot
  omarchy debug               Print debugging information

Groups:
  agent          AI coding agent usage data
  audio          Audio input and output controls
  bar            Omarchy shell bar layout and settings
  battery        Battery status helpers
  bluetooth      Bluetooth device controls
  branch         Omarchy git branch management
  branding       About and screensaver branding
  brightness     Display and keyboard brightness
  capture        Screenshots and screen recording
  channel        Omarchy release channel management
  clipboard      Clipboard helpers
  cmd            Command and shortcut helpers
  config         System configuration helpers
  debug          Diagnostics and support logs
  ...
```

每个命令组都可以深入探索：

```
~ ❯ omarchy capture
Capture commands — Screenshots and screen recording:
  omarchy capture qr                                                                                                                                                                                                       Decode a QR code from a screenshot region
  omarchy capture screenrecording [--fullscreen] [--with-desktop-audio] [--with-microphone-audio] [--with-webcam] [--webcam-device=<device>] [--webcam-size=<small|medium|large>] [--resolution=<size>] [--stop-recording]  Start or stop screen recording
  omarchy capture screenrecording with webcam                                                                                                                                                                              Pick a webcam and start a screen recording with it
  omarchy capture screenshot [smart|region|windows|fullscreen] [slurp|copy|save] [--editor=<name>]                                                                                                                         Take a screenshot
  omarchy capture text                                                                                                                                                                                                     Extract text from a screenshot region with OCR
  omarchy capture webcam resize <smaller|larger|reset|small|medium|large>                                                                                                                                                  Resize the active webcam recording overlay
```

每个命令都支持 `--help`，不管是整个命令组（`omarchy capture --help`）还是单独命令（`omarchy capture screenshot --help`）。

### 从终端打开菜单

codeOS 菜单也是可脚本化的，对自定义快捷键很方便。`omarchy menu` 在根目录打开菜单，可以直接跳到树里任意位置：`omarchy menu summon style.theme` 直接到主题选择器，`omarchy menu toggle system` 打开系统菜单（已打开则关闭），`omarchy menu close` 收起菜单。
