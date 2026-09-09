# 快速上手

codeOS 通过 ISO 镜像安装。你可以选择**全盘安装**（接管整个硬盘）或**空闲空间安装**（将 codeOS 安装到硬盘的未分配空间中）——后者就是你与 Windows 或其他系统双启动的方式（参见[双启动安装](50-dual-boot-install.md)——注意你需要先在 Windows 中关闭 BitLocker）。无论哪种方式，安装默认都会启用全盘加密，而全盘选项会擦除所选硬盘的数据，所以在使用现有硬盘之前务必备份！

首先[下载 codeOS ISO](https://codeos.org/)，将其写入 U 盘（Mac/Windows 上使用 [balenaEtcher](https://etcher.balena.io/)，Linux 上使用 [caligula](https://github.com/ifd3f/caligula)），然后从 U 盘启动。

_你必须在 BIOS 中关闭 Secure Boot 和/或 TPM。不关闭这些就无法安装 codeOS。它们是微软专为 Windows 及微软关联的 Linux 发行版设计的安全方案。_

然后回答配置问题，并像这样确认：

 ![install-config](images/install-config.webp)

接着选择安装的硬盘，坐下来看着安装过程进行。在最快的现代机器上不到一分钟就能完成，即使是较老的电脑也不会超过 5 分钟。

 ![install-done](images/install-done.webp)

现在你可以开始使用 codeOS 了！

### 使用有线或 2.4GHz 键盘！

全盘加密不允许你在启动时通过蓝牙键盘输入密码。就像你不能用蓝牙键盘在 PC 上输入 BIOS 密码一样。你需要使用 2.4GHz 接收器或有线连接的键盘（有线在延迟方面也会好得多！）。我个人非常喜欢 [Lofree Flow84](https://www.lofree.co/products/lofree-flow-the-smoothest-mechanical-keyboard)！

### 为其他用户安装

如果你在为其他人设置电脑——比如家人、新员工或买家——你不应该代替他们回答个人问题。在安装程序的第一个界面（键盘选择界面）按 `Ctrl + C`，codeOS 会改为提供为其他用户准备机器的选项。系统会立即安装，但所有个人设置——键盘布局、用户名、密码——都推迟到机器首次启动时进行。硬盘仍然默认加密，新用户在首次启动时设置的密码同时成为加密密码。（你已经在用的机器也可以无需重装直接交接——参见[重置计算机](48-security.md)。）

### 无人值守安装

ISO 还可以完全自动安装——无需键盘，无需向导——只要在第二块硬盘上提供配置即可。这是将 codeOS 作为虚拟机和批量机器的基础镜像的方式。参见[无人值守安装](51-unattended-installs.md)。

### 无加密安装

codeOS 默认启用加密安装。对于任何可能丢失或被盗的电脑来说，这都是安全、负责任的选择。你不会希望任何拿到你硬件的人都能获取你的数据！

但在特殊情况下，比如远程安装 codeOS 到受保护的电脑上，或者用于没有敏感数据的临时安装，你可能想要无加密安装。在磁盘格式化确认界面按 `Ctrl + C` 即可切换到无加密安装模式。

### 卡住了怎么办

如果你遇到困难，通常可以在 [社区 Discord](https://codeos.org/discord) 的 _#omarchy-help_ 频道找到愿意帮忙的人。
