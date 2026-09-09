# 系统睡眠

codeOS 默认启用挂起（suspend）和休眠（hibernation），但如果你的机器上有问题，可以关掉。

### 电源模式

笔记本上，codeOS 会记住插电和用电池时各自的电源模式，插拔时自动切换。默认插电用 performance、电池用 balanced。

`omarchy powerprofiles list` 查看你的机器有哪些模式可选，`omarchy powerprofiles set autodetect power-saver` 设置当前状态要用的模式。不想拔电源就设置另一个状态，直接指定：`omarchy powerprofiles set battery power-saver`。下次切到那个状态时就是你选的模式。

### 切换挂起

在终端里跑 `omarchy toggle suspend` 切换挂起选项的显示/隐藏（在 _System_ 下，或 `Super + Esc`），然后你可以测试它在你的系统上是否稳定工作。不行的话同样命令再隐藏。

### 切换休眠

在终端里跑 `omarchy hibernation setup` 设置休眠。休眠会在启动驱动器上创建一个和你物理 RAM 大小相同的 /swap 子卷，所以确保有足够空间。32GB 内存的机器需要至少 32GB+ 空闲空间。休眠也需要默认的 Limine 引导加载器。

设置好后，_System_（或 `Super + Esc`）下会出现休眠选项，同样测试是否稳定。不行的话 `omarchy hibernation remove` 去掉它。
