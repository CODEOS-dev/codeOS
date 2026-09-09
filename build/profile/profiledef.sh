#!/bin/bash
# codeOS archiso profile build hook
# 由 mkarchiso 调用，用于定制 ISO 内容

set -euo pipefail

iso_name="codeOS"
iso_label="codeOS $(date +%Y%m)"
iso_publisher="codeOS <https://github.com/CODEOS-dev/codeOS>"
iso_application="codeOS Live ISO"
iso_version="$(date +%Y.%m.%d)"

# 构建类型
install_dir="arch"

# 默认 pacman.conf 路径
pacman_conf="${workdir}/pacman.conf"

# 添加 codeOS 本土化到 live 环境
run_on_build() {
  local airootfs="${airootfs_dir}"

  # 启用中文 locale
  sed -i 's/^#\s*\(zh_CN.UTF-8\s*UTF-8\)/\1/' "${airootfs}/etc/locale.gen" 2>/dev/null || true
  sed -i 's/^#\s*\(en_US.UTF-8\s*UTF-8\)/\1/' "${airootfs}/etc/locale.gen" 2>/dev/null || true

  # 设置默认 locale.conf
  mkdir -p "${airootfs}/etc"
  cat > "${airootfs}/etc/locale.conf" << 'LOCALE_EOF'
LANG=zh_CN.UTF-8
LANGUAGE=zh_CN:zh:en_US:en
LOCALE_EOF

  # 设置 Asia/Shanghai 时区
  ln -sf /usr/share/zoneinfo/Asia/Shanghai "${airootfs}/etc/localtime" 2>/dev/null || true

  # 添加 codeOS 命令别名（live 环境下也能用 develop）
  mkdir -p "${airootfs}/root"
  cat >> "${airootfs}/root/.bashrc" << 'ALIAS_EOF'

# codeOS 别名
alias develop=omarchy
ALIAS_EOF
}

# 构建完成后
run_on_iso_mount() {
  :
}

run_on_iso_umount() {
  :
}
