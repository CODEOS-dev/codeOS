# 常见问题

### 如何切换键盘布局？

编辑 `~/.config/hypr/input.lua` 文件，添加以下内容即可通过 `Left Alt + Right Alt` 切换布局：

```
hl.config({
  input = {
    -- 使用多个键盘布局，并通过 Left Alt + Right Alt 在它们之间切换
    kb_layout = "us,fr",
    kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
  },
})
```

一旦配置了多个布局，顶栏会自动显示当前的键盘布局（也可以点击它来切换）。

### 如何把时钟格式改成 12 小时制？

右键点击顶栏上的时钟，可以快速循环切换常见格式，包括 12 小时制。你也可以直接设置格式：

```
omarchy bar set omarchy.clock format "dddd h:mm AP"
```

这样会显示类似"星期日 10:55 上午"的格式。

### 如何修改时区？

在 codeOS 菜单中选择 _Update > Timezone_，然后从列表中选择。如果时区是对的但时钟本身有偏差，_Update > Time_ 会为你重新启动时间同步。

### 如何修改 DNS、分享 Wi-Fi 或检查网络速度？

这些都在[网络配置](35-networking.md)一章里。

### 如何检查硬盘速度？

_Trigger > Speed Test > Disk Speed Test_ 会实时测量硬盘的读写速度，或者在终端运行 `omarchy disk speedtest`。

### 为什么我在 Chromium 中无法登录 Google 账户？

普通的开源 Chromium 构建版不包含 Google 账户登录所需的 OAuth 凭据。在 codeOS 菜单中运行 _Install > Service > Chromium Account_ 来添加这些凭据，重启浏览器后登录就能正常进行了。

### 如何添加打印机？

打印功能开箱即用，你可以在应用启动器（`Super + Space`）中的 _Print Settings_ 里手动添加每台打印机。

选择 _Add_，稍等片刻让它自动检测：通过 USB 连接的打印机以及大多数网络打印机都能被自动找到。如果你的打印机不在列表中，选择 _Network Printer > Internet Printing Protocol (ipp)_ 并输入其地址——打印机自身的显示屏或网页通常会告诉你这个地址，一般类似 `192.168.1.50`，队列是 `ipp/print`。点击 _Forward_ 后会提供驱动选择：现代打印机优先使用免驱动的 _IPP Everywhere_ 配置文件，较老的打印机则选择对应型号的驱动。

右键点击打印机，选择 _Set as Default_ 来设为应用的首选打印机，或选择 _Properties_ 来设置纸张大小、双面打印和打印质量。

自动发现功能（网络上的打印机无需添加就能出现）正在重构中，暂时关闭了，所以目前需要手动添加。打印到 PDF 文件则完全不需要任何打印机。

### 如何修改截图或录屏文件的保存位置？

如果你想把截图保存到 `~/Pictures/Screenshots` 而不只是 `~/Pictures`，可以在 `~/.config/uwsm/env.d/` 下的文件中添加以下内容（例如 `~/.config/uwsm/env.d/capture`）：

```
export OMARCHY_SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
```

录屏文件同理，使用 `OMARCHY_SCREENRECORD_DIR`。

记得先创建你想保存到的目录，然后重启 codeOS 才能生效。

### 如何让 Apple Studio Display 的扬声器和摄像头正常工作？

你可能以为插上 USB-C 就能全部正常工作，但遗憾并不是这样。我找到的可靠解决方案是使用 [WJESOG DisplayPort + USB-A => USB-C 线材](https://www.amazon.com/WJESOG-DisplayPort-Adapter-Converter-Thunderbolt/dp/B0BNX7MS6N/)。用了之后扬声器和摄像头就能正常工作了。

另外，codeOS 内置了对 Apple 显示器（Studio 和 XDR）的亮度控制，使用常规键盘亮度键即可调节。

### 如何卸载不需要的预装软件？

如果你不想用 Obsidian、LibreOffice 或其他任何预装的程序，可以非常轻松地卸载它们。

运行 _Remove > Package_ 查看所有已安装的软件包。然后用 tab 键选择要卸载的软件包，按 return 键开始批量卸载。

也可以从 codeOS 菜单中选择 _Remove > Web App_ 来移除任何你不想要的预装 Web App。

或者运行 _Remove > Preinstalls_ 一次性清除所有预装的额外组件——Web App、TUI 和可选应用——以及关联的快捷键绑定，让你在 `~/.config/hypr/bindings.lua` 中有一个干净的起点来重新配置自己的快捷键。

---

遇到错误或故障？参见[故障排查](45-troubleshooting.md)。
