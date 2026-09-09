# 硬件认证

### 指纹认证

很多笔记本带指纹传感器做认证。codeOS 里通过 codeOS 菜单（`Super + Space`）的 _Setup > Security > Fingerprint_ 来使用。

它会安装指纹包、录入你的指纹、验证，然后就可以在锁屏上解锁（`Super + Ctrl + L`）、sudo 授权和系统提示上用了。

笔记本合盖时，指纹提示会自动跳过，直接要密码，不会等一个你碰不到的传感器。如果外接键盘没有传感器，sudo 时提示录指纹的话直接按 `CTRL + C` 就行。

通过 codeOS 菜单的 _Remove > Security > Fingerprint_ 移除指纹认证。

### Fido2 认证

如果用 Fido2 设备，可以通过 codeOS 菜单（`Super + Space`）的 _Setup > Security > Fido2_ 设置用它做 `sudo` 认证。它覆盖 sudo 和系统授权提示，但不会解锁电脑。

通过 codeOS 菜单的 _Remove > Security > Fido2_ 移除 Fido2 认证。
