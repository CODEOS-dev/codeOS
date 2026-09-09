# 浏览器

codeOS 预装 [Chromium](https://www.chromium.org/) 作为默认浏览器。是纯开源构建，主题和系统其他部分匹配，也是 `Super + Shift + Return` 打开的、每个 [Web App](25-web-apps.md) 运行的基础。

如果 Chromium 不合口味，你不是没得选。codeOS 菜单的 _Install > Browser_ 里有 Chrome、Edge、Brave、Brave Origin、Firefox 和 [Zen](https://zen-browser.app/)。选一个 codeOS 就会安装它、配置好策略目录、应用你的当前主题。

## 设为默认

安装浏览器不会自动设为默认。装好后去 _Setup > Defaults > Browser_ 选——菜单里只列你真正安装过的，当前默认的打勾标记。

终端里：

```bash
omarchy default browser firefox
```

不带参数运行会告诉你当前默认。这个命令设置 XDG handler，所以不止 codeOS 的快捷键跟着走——任何打开链接的东西，从聊天应用到终端命令，都会去你选的浏览器。

## 复制 URL 和下载视频

Chromium 系浏览器（Chromium 本身、Chrome、Edge 和 Brave）自带两个 codeOS 扩展，可以从浏览器延伸到系统其他部分。

**Copy URL** 用 `Alt + Shift + L` 把当前标签页地址放到剪贴板。比点地址栏再复制快，而且因为走的是系统剪贴板而不是浏览器的，你会收到 codeOS 通知确认，URL 立即可用于 [剪贴板历史](08-unified-clipboard-history.md) 和其他任何应用。也有工具栏按钮，喜欢点的话随便。

**Download Video** 用 `Alt + Shift + D` 抓取当前页面正在播放的视频。它把 URL 交给 [yt-dlp](https://github.com/yt-dlp/yt-dlp)，所以远超 YouTube 的范围，下载保存到 `~/Videos`。进度用和音量、亮度一样的屏幕显示，原地更新而不是堆通知。想换保存目录设 `OMARCHY_YTDLP_DIR`——放环境变量的位置见 [FAQ](46-faq.md)。

两个扩展都通过一个小型 native messaging host 和 codeOS 对话，这个 host 会在装浏览器时一起装。就是它让网页的视频能进你的 home 目录、URL 能进剪贴板管理器——普通扩展自己做不到。

这些只适用于 Chromium 系。Firefox 和 Zen 没有。

## Firefox 和 Zen

Firefox 和 Zen 是不同系的，所以待遇不同：codeOS 为它们安装策略文件做合理默认，并让它们进入原生 Wayland 模式——对分数缩放和平滑触摸板滚动来说你需要这个。

它们没有上面那两个 Chromium 扩展，也不被 codeOS 改主题，所以这些部分需要你自己搞。

## 卸载

装过的都可以在 _Remove > Browser_ 里卸。Chromium 不在列表里——它是基础系统的一部分。
