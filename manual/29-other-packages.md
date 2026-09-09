# 其他软件包

Arch 在官方仓库和 Arch User Repository（AUR）之间提供了极其丰富的软件包，覆盖几乎所有类型的软件。

使用起来再简单不过了。安装新的 Arch 包，打开 codeOS 菜单（`Super + Space`）的 _Install > Package_，输入想要的包名。会自动模糊过滤全部包列表。（也可以手动在终端里用 `omarchy pkg add [package]`）。

AUR 同理，用 _Install > AUR_。只是记住 AUR 不受 Arch 团队审核。就像 RubyGems 或 npm，任何人都可以上传。

想移除包，用 codeOS 菜单里的 _Remove > Package_。会移除包、配置文件和依赖。（也可以手动用 `omarchy pkg drop [package]`）。
