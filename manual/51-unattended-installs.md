# 无人值守安装

codeOS ISO 可以无人值守安装。如果安装器发现第二块带 `cidata` 标签、放着配置文件的驱动器，就把它们复制下来，跳过整个 setup 向导，自动重启进装好的系统。不需要特殊 ISO 构建，也不需要额外引导菜单——没这样的驱动器，一切照旧走正常向导。

这让 codeOS 很适合做临时开发环境的基础镜像：在 Proxmox 或用 Packer 建 VM，启动后走人，SSH 进去。`cidata` 就是 cloud-init 的 `NoCloud` 标签，所以常见虚拟化工具都知道怎么挂这样的驱动器。

## 配置文件

这些文件就是安装器自己的向导会写的，所以最简单的获取方法是跑一次交互式安装（比如在 VM 里），然后把 `/root` 里写出来的复制走：

| 文件 | 必需 | 用途 |
|------|----------|---------|
| `user_configuration.json` | 是 | 磁盘、主机名、时区、键盘 |
| `user_credentials.json` | 是 | 用户名和密码哈希 |
| `user_full_name.txt` | 否 | Git 全名 |
| `user_email_address.txt` | 否 | Git 邮箱 |
| `user_encrypt_installation.txt` | 否 | 当配置里有 `disk_encryption` 块时填 `true` |
| `authorized_keys` | 否 | SSH 公钥，每行一个 |
| `tailscale_authkey` | 否 | Tailscale auth key，首次启动加入 tailnet |

用 `openssl passwd -6 "yourpassword"` 生成 `user_credentials.json` 里的密码哈希。

也可以放一个叫 `defer-provisioning` 的空文件来代替 `user_credentials.json`。这会触发和交互式安装里相同的[为下一位所有者准备的安装](02-getting-started.md)：机器安装时不带任何个人信息，谁第一次启动谁选键盘、建用户。这是给批量部署机器用的模式，驱动器里不带任何人的凭据。

## SSH 访问

有 `authorized_keys` 时，安装器会把这些 key 设为用户的 `~/.ssh/authorized_keys`，启用 `sshd` 并开放防火墙。（原版 codeOS 安装带 openssh 但服务是关的、端口是封的，所以无人值守的机器本来是无法远程访问的。）安装只加你的 key——不会松开 SSH 守护进程的其他认证设置。

有 `tailscale_authkey` 时，机器首次启动就加入你的 tailnet：Tailscale 从 ISO 捆绑包里安装，防火墙放行 tailnet 接口，一个后台任务一有网络就跑 join，重试到成功为止。用可复用的、预授权的 key，这样一个驱动器镜像就能服务多台机器。

## 构建 cidata 驱动器

任何文件系统都行，标签对就行。一个小 ISO 是最简单的方式：

```bash
mkdir cidata
cp user_configuration.json user_credentials.json authorized_keys cidata/
genisoimage -output cidata.iso -volid cidata -joliet -rock cidata/
```

然后把它和 codeOS ISO 一起挂到 VM 上。完整 Proxmox 示例：

```bash
qm create 101 --name my-omarchy \
  --bios ovmf --machine q35 --cpu host --cores 4 --memory 8192 \
  --ostype l26 --scsihw virtio-scsi-single \
  --efidisk0 local-lvm:0,efitype=4m,pre-enrolled-keys=0 \
  --scsi0 local-lvm:40,discard=on,iothread=1 \
  --net0 virtio,bridge=vmbr0 --vga virtio --serial0 socket \
  --ide2 local:iso/omarchy.iso,media=cdrom \
  --ide3 local:iso/cidata.iso,media=cdrom \
  --boot order='scsi0;ide2'

qm start 101
```

引导顺序特意先磁盘再 ISO：第一次启动时空磁盘会跳到 ISO，装好后系统永远从磁盘引导。

## 两个注意事项

加密的无人值守安装不完全无人——还是有人要在第一次启动时输入 LUKS 密码。而且 `user_configuration.json` 里的 `disk_encryption` 块明文存了那个密码，所以从加密安装构建的 cidata 驱动器要当作机密处理。
