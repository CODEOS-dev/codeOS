# 截屏与录屏

所有屏幕捕获操作都挂在 Print Screen 键上。单独按一下是截屏，加修饰键就是录屏、取色或区域内文本提取。如果你的键盘没有 Print Screen 键，`Super + Ctrl + C` 可以打开同样的捕获菜单。

| 快捷键 | 功能 |
| ------ | -------- |
| `Print Screen` | 截屏 |
| `Alt + Print Screen` | 录屏（或停止正在进行的录制） |
| `Super + Print Screen` | 取色器 |
| `Super + Ctrl + Print Screen` | 区域内提取文字 |
| `Super + Ctrl + C` | 捕获菜单 |
| `Super + Ctrl + .` | 转码图片或视频 |

## 截屏

按 `Print Screen`，屏幕会冻结让你瞄准。拖动框选任意区域，或者点一下自动吸附到对应矩形——点到窗口就截窗口，点到顶栏或空隙就截整个显示器。改主意了？再按一下 `Print Screen` 取消。

结果同时保存两处：图片目录里的 PNG 文件和剪贴板，这样可以直接 `Super + V` 粘贴到聊天窗口。会弹出带缩略图的通知。点击它（或按 `Super + Alt + ,` 激活最近的通知）可以在 Tensaku 标注编辑器里打开，加箭头和框再发送。

默认保存在 `~/Pictures`，文件名 `screenshot-2026-08-13_14-22-05.png`。想放别的文件夹，设置 `OMARCHY_SCREENSHOT_DIR`——放环境变量的位置见 [FAQ](46-faq.md)。目录不存在的话 codeOS 会自动创建。也可以用 `OMARCHY_SCREENSHOT_EDITOR` 换标注编辑器。

终端里用 `omarchy screenshot` 可以截同样的图，还能更精确：`omarchy capture screenshot region` 只允许自由框选，`windows` 吸附到窗口和显示器矩形，`fullscreen` 跳过选择器直接截聚焦的显示器。第二个参数 `copy` 只放剪贴板，`save` 只存磁盘。

### 键盘驱动的选择器

选择器出现时，完全可以不用鼠标：

| 按键 | 功能 |
| --- | -------- |
| `Return` | 捕获高亮的窗口 |
| `Ctrl + Return` | 捕获整个屏幕 |
| `Tab` / `Ctrl + Tab` | 高亮下一个/上一个窗口 |
| 方向键 | 高亮该方向的窗口 |

方向键和 Tab 会把光标移到选中的窗口上，高亮跟着走，你能看到将要捕获的内容。这些绑定只在选择器出现时存在，所以不会和你自己的配置冲突。

## 录屏

`Alt + Print Screen` 打开 _Trigger > Capture > Screenrecord_，会问你要不要录音频：无音频、桌面音频、桌面音频+麦克风、桌面音频+麦克风+摄像头。最后一个只有插了摄像头才出现。选好后会出现和截屏一样的选择器：拖动框选区域，或者点窗口/显示器。

录屏基于 gpu-screen-recorder，GPU 编码 60fps，不行就退回 CPU。结果是 `~/Videos` 里的 MP4 文件，文件名 `screenrecording-2026-08-13_14-22-05.mp4`。设置 `OMARCHY_SCREENRECORD_DIR` 可以换目录——注意和截屏目录不同，这个目录必须已存在，否则录制不会开始。

录制时顶栏会出现一个小指示器，点击停止。也可以再按 `Alt + Print Screen`，或者用 _Trigger > Capture > Screenrecord_ 下的 _Stop Screenrecording_（只在录制时出现）。

停止时会做一些处理：去掉第一帧，有音频的话用 PipeWire 把开头的爆音消掉并归一化到 -14 LUFS。然后弹出带缩略图的通知，点击用 mpv 播放。

### 摄像头覆盖层

录制时启用摄像头的话，画面会固定在右下角，裁剪成竖幅。如果它挡住了你需要的东西，可以随时调整大小：

| 快捷键 | 功能 |
| ------ | -------- |
| `Super + Alt + [` | 缩小摄像头覆盖层 |
| `Super + Alt + ]` | 放大摄像头覆盖层 |

有三档尺寸——小、中、大，快捷键在它们之间切换，默认中等。尺寸和录制画面成比例，所以不管录的是 1080p 还是 6K 屏幕，摄像头在画面里占的份额都一样。如果你是框选录制而不是全屏，覆盖层锚定在选中区域的角上而非显示器的，保证不跑出画面。

终端里可以直接用 `omarchy-capture-webcam-resize small`，或 `reset` 回到中等。

## 文字、QR 码和取色

`Super + Ctrl + Print Screen` 选中区域后 OCR 到剪贴板，详见 [文本提取与听写](11-text-extraction-dictation.md)。

_Trigger > Capture > QR Code_ 同样的方式扫描 QR 码。选中有码的区域，解码后的内容放到剪贴板。它只找 QR 码——密集屏幕内容容易被误识别成条形码。注意：解码结果只去了剪贴板，不打印、不在通知里，而且标记为敏感所以不会留在 [剪贴板历史](08-unified-clipboard-history.md) 里。QR 码经常携带敏感信息——比如 2FA 背后的 `otpauth://` URI——你肯定不希望它留痕。粘贴还是照样能用。

`Super + Print Screen`（或 _Trigger > Capture > Color_）把光标变成吸管。点屏幕上的任何东西，颜色值放到剪贴板。再按一次快捷键取消不选。

## 分享前转码

4K 录屏或手机拍的原始 HEIC 经常太大没法直接发。`Super + Ctrl + .`（或 _Trigger > Transcode_）解决这个问题。它会在 `~/Pictures` 和 `~/Videos` 上弹出模糊文件选择器，然后让你选格式和尺寸。

图片转 jpg 或 png，质量高/中/低分别限制宽度 3160/2160/1080 像素。视频转 mp4 或动图，4K/1080p/720p。转换后的文件写在原文件旁边，文件名带分辨率——`demo-1080p.mp4`——路径复制为文件 URI 到剪贴板，可以直接粘贴到支持文件的应用里。

终端也能直接用，如果你已经知道想要什么：`omarchy transcode ~/Videos/demo.mov mp4 1080p`。还有 `omarchy transcode ascii` 把图片转成 ASCII 艺术——这个主要给 [品牌定制](41-branding.md) 用。

## 发送到别处

拿到文件后，`Super + Ctrl + S` 打开分享菜单，通过 LocalSend 发到网络上的其他设备。详见 [图形应用](22-guis.md)。
