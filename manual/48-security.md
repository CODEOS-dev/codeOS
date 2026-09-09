# 安全

codeOS 极其重视安全。它旨在成为一台能在 _真实世界_ 里做 _正经工作_ 的操作系统。丢了笔记本不能变成安全事故。所以我们做了这些：

1. **全盘加密强制开启**：这是保护数据物理安全最重要的一步。如果电脑丢了或被盗，数据通过标准 LUKS（Linux Unified Key Setup）完全加密。
2. **防火墙默认启用**：所有入站流量默认阻塞，只有 [LocalSend](https://localsend.org/) 用的 53317 端口例外。甚至 SSH 默认也关着，直到你通过 _Setup > Security > SSHD_ 开启，开启时会打开 22 端口（限速防暴力破解）。我们还用 [ufw-docker](https://github.com/chaifeng/ufw-docker) 加固 Docker 访问，防止容器意外暴露到公网。
3. **Arch 始终保持最新**：codeOS 基于 Arch 这个滚动发行版。意味着任何包发现安全漏洞并打好补丁后，`omarchy-update` 里很快就能装到。所以你始终跑的是一切的最新最安全版本。
4. **codeOS 维护自己的包和镜像**：默认只依赖 Arch 官方 core/extra/multilib 仓库和自己的 Omarchy Package Repository。可以直接从 AUR 装软件，但基础安装不依赖——只有少数可选安装，比如第三方浏览器，会从 AUR 拉。
5. **Cloudflare 保护 DDoS**：所有 codeOS 分发基础设施——ISO、codeOS 包、Arch 镜像——都在 Cloudflare 强大的 DDoS 护盾后面并通过其 CDN 托管。可用性非常好。

## 修改密码

加密安装上你有两个密码：引导时解锁磁盘的密码，以及登录和 `sudo` 用的密码。都可以在 codeOS 菜单的 _Update > Password_ 下修改——_Drive Encryption_ 改前者，_User_ 改后者。改磁盘密码需要先输入当前密码，所以手头要有。

## 把用过的机器交给别人

要把机器交给别人，不用重装。在 codeOS 菜单里运行 _Setup > Reset Computer_，输入 `reset` 确认，然后重启。它会清空所有用户账户和 `/home` 里的一切，丢弃安装后你装的所有包和系统改动，清除机器身份——网络连接、host key 等。起来就是第一次开机的 setup 向导，新主人可以填自己的名字、密码和加密密码。

它通过恢复安装器拍的基线快照实现，所以只在从 codeOS ISO 安装的机器上可用。无加密磁盘上的重置只是删除而不是安全擦除，所以如果数据敏感，还是全新安装更安全。

## 免密 sudo

有时你想让 `sudo` 不再询问——最常见的是 AI Agent 帮你做一大段系统工作时。_Setup > Security > Passwordless Sudo_ 会临时关闭 15 分钟然后自动恢复。计时器到之前再运行一次可以提前结束，15 分钟不够的话用 `omarchy-sudo-passwordless 30` 自定义分钟数。重启也会清掉免密 sudo 规则。

要清楚这一点：开启期间，任何以你身份运行的东西都可以无需提示地做 root 能做的任何事。这就是它的目的，也是它的风险。

## 签名密钥

所有 ISO 签名和 Omarchy 仓库包的公钥是 `40DFB630FF42BCFFB047046CF0134EE680CAC571`（[在 openpgp.org 验证](https://keys.openpgp.org/search?q=pkgs%40omarchy.org)）。`omarchy/omarchy-keyring` 包里也包含这个密钥，用于无缝更新。

任何 ISO 版本的签名可以在 URL 后加 .sig 找到。比如 https://iso.omarchy.org/omarchy-x.x.x.iso.sig。
