# 网络

codeOS 的网络由 NetworkManager 管理，通过 [顶栏](05-the-top-bar.md) 的网络图标或 `Super + Ctrl + W` 操作。

那个面板会扫描 Wi-Fi、显示信号强度并连接。以太网什么都不用做——插上就好。如果更愿意待在终端里，`nmtui` 提供同样的控制，还有 `omarchy network` 命令组。

## 分享 Wi-Fi

不想大声把密码念出来，就在 Wi-Fi 连接时运行 _Setup > Network > QR Code_。屏幕上会出现一个 QR 码，任何手机相机一扫就能加入。这种东西你知道之后用得比想象的多。

如果真的需要密码本身，`omarchy network password <interface>` 会打印出来。

## DNS

codeOS 默认用 DHCP 分配的 DNS。可以通过 _Setup > Network > DNS_ 为整台电脑覆盖，Cloudflare 和 Google 一键可选。选 _Custom_ 自己填服务器。

终端里 `omarchy dns` 打印当前提供商，`omarchy dns Cloudflare` 设置一个。

## 固定 Wi-Fi 频段

如果路由器把 2.4GHz、5GHz 和 6GHz 都叫同一个名字，你的笔记本有时会赖在慢的那个上。`omarchy network band` 显示当前在哪个频段，`omarchy network band 5` 固定到 5GHz。`auto` 让它自动选。

固定的是频段而不是具体的接入点，所以你可以在不同 AP 之间正常漫游。

## 网速怎么样

_Trigger > Speed Test > Network Speed Test_ 用一对表盘测量实际上传和下载速度。终端里是 `omarchy network speedtest down` 或 `up`（同一菜单里还有磁盘速度测试，如果你想测另一个瓶颈）。

## 防火墙

防火墙默认开启，阻塞所有入站流量，唯一例外是 53317 端口，这样 [LocalSend](22-guis.md) 开箱即用。

SSH 默认关闭，要开的话用 _Setup > Security > SSHD_，会启动守护进程、开放 22 端口并限速防暴力破解，还会授权密钥。Docker 也锁得很紧，容器不会不小心暴露到公网。完整情况见 [安全](48-security.md)。

## Tailscale

[Tailscale](https://tailscale.com/) 是 mesh VPN，让你通过互联网安全访问所有电脑和服务器变得简单。从 _Install > Service > Tailscale_ 安装。

装好后顶栏会有 Tailscale 面板，可以连接/断开 tailnet、切换账户、选择出口节点（你自己的机器和 Mullvad 区域都在列表里）。它还能浏览你的机器，Taildrop 就在这里：选中一台机器按 `s` 发文件，或 `c`、`n`、`d` 分别复制它的 IP、名字或完整 DNS 名。终端里 `omarchy tailscale send <machine> [file...]`，发给你的文件自动落到 `~/Downloads`。通知会一直等到你点开或忽略，所以你离开机器时发来的文件回来还在。

安装还会添加一个 Tailscale 管理控制台的 web 应用。

## 不工作了怎么办

重启前，先单独重启出问题的那个子系统。_Update > Hardware_ 下有 Wi-Fi、Bluetooth、Audio 和 Trackpad，重新加载其中一个能解决大部分"五分钟前还好好的"的情况。见 [故障排查](45-troubleshooting.md)。
