# 文本提取与听写

### 文本提取

按 `Super + Ctrl + PrtScr` 在屏幕上框选一个区域进行 OCR。使用 tesseract 开源 OCR 模型快速把选中区域转为文字并放到剪贴板，然后按 `Super + V` 粘贴即可。

从图片底部抓地址、或从网站标题里提取电话号码都非常方便。

 ![text-extraction](images/text-extraction.webp)

### 听写

codeOS 通过 [Voxtype](https://voxtype.io/) 提供 AI 听写功能。通过 codeOS 菜单里的 _Install > AI > Dictation_ 安装。默认加载基础英语模型，大小 150MB。可以在终端运行 `voxtype setup model` 选择其他模型，在 `~/.config/voxtype/config.toml` 里调整所有设置。

安装后，按住 `F9` 或按 `Super + Ctrl + X` 切换听写，听写出来的文字会出现在当前聚焦的输入框里。
