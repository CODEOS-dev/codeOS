# codeOS 中文本土化设置
# 生成 /etc/locale.conf 并启用中文 locale
# 需要在 install root 下执行（ISO chroot 或已安装系统）

set -euo pipefail

# === 1. 启用中文 locale ===
omarchy_log_line "[codeOS-zh] 启用 zh_CN.UTF-8 locale..."

# 检查 locale.gen 是否存在并确保 zh_CN.UTF-8 未被注释
if [[ -f /etc/locale.gen ]]; then
  # 取消注释 zh_CN.UTF-8 和 en_US.UTF-8
  sed -i 's/^#\s*\(zh_CN.UTF-8\s*UTF-8\)/\1/' /etc/locale.gen || true
  sed -i 's/^#\s*\(en_US.UTF-8\s*UTF-8\)/\1/' /etc/locale.gen || true
  # 生成 locale
  locale-gen 2>/dev/null || true
fi

# === 2. 写入 /etc/locale.conf ===
omarchy_log_line "[codeOS-zh] 写入 /etc/locale.conf..."

cat >/etc/locale.conf << 'LOCALE_EOF'
LANG=zh_CN.UTF-8
LANGUAGE=zh_CN:zh:en_US:en
LC_CTYPE=zh_CN.UTF-8
LC_NUMERIC=zh_CN.UTF-8
LC_TIME=zh_CN.UTF-8
LC_COLLATE=zh_CN.UTF-8
LC_MONETARY=zh_CN.UTF-8
LC_MESSAGES=zh_CN.UTF-8
LC_PAPER=zh_CN.UTF-8
LC_NAME=zh_CN.UTF-8
LC_ADDRESS=zh_CN.UTF-8
LC_TELEPHONE=zh_CN.UTF-8
LC_MEASUREMENT=zh_CN.UTF-8
LC_IDENTIFICATION=zh_CN.UTF-8
LOCALE_EOF

# === 3. 设置时区（默认 Asia/Shanghai）===
if [[ -e /usr/share/zoneinfo/Asia/Shanghai ]]; then
  omarchy_log_line "[codeOS-zh] 设置时区为 Asia/Shanghai..."
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 2>/dev/null || true
  echo "Asia/Shanghai" >/etc/timezone 2>/dev/null || true
  # 写入 timedatectl 设置
  if command -v timedatectl &>/dev/null; then
    timedatectl set-timezone Asia/Shanghai 2>/dev/null || true
  fi
fi

# === 4. 配置 pacman 中文输出 ===
# 修改 /etc/pacman.conf 添加 ILoveCandy 和 Color 选项
if [[ -f /etc/pacman.conf ]]; then
  omarchy_log_line "[codeOS-zh] 配置 pacman 中文输出..."
  if ! grep -q '^Color' /etc/pacman.conf; then
    sed -i '/^#Color$/s/^#//' /etc/pacman.conf || true
  fi
  if ! grep -q '^ILoveCandy' /etc/pacman.conf; then
    # 在 MiscOptions 前添加
    sed -i '/^\[options\]/a ILoveCandy' /etc/pacman.conf || true
  fi
fi

# === 5. 配置 fontconfig 中文字体优先 ===
omarchy_log_line "[codeOS-zh] 配置 fontconfig 中文字体优先..."

mkdir -p /etc/fonts/conf.d

cat >/etc/fonts/conf.d/99-codeos-zh-fonts.conf << 'FONT_EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <!-- 中文字体优先顺序 -->
  <alias>
    <family>sans-serif</family>
    <prefer>
      <family>Noto Sans CJK SC</family>
      <family>Noto Sans CJK</family>
      <family>WenQuanYi Zen Hei</family>
      <family>WenQuanYi Micro Hei</family>
      <family>Noto Sans</family>
    </prefer>
  </alias>
  <alias>
    <family>serif</family>
    <prefer>
      <family>Noto Serif CJK SC</family>
      <family>Noto Serif CJK</family>
      <family>Noto Serif</family>
    </prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>JetBrains Mono Nerd Font</family>
      <family>Noto Sans Mono CJK SC</family>
      <family>Noto Sans Mono</family>
    </prefer>
  </alias>
</fontconfig>
FONT_EOF

# 更新字体缓存
fc-cache -f 2>/dev/null || true

# === 6. 配置 fcitx5 默认启用 ===
omarchy_log_line "[codeOS-zh] 配置 fcitx5 默认输入法..."

# 创建 fcitx5 默认 profile（启用拼音）
mkdir -p /etc/fcitx5/profile.d

cat >/etc/fcitx5/profile.d/pinyin.conf << 'FCITX_EOF'
[Groups/0]
# 组名称
Name=默认
# 默认输入法
Default Layout=us
DefaultIM=pinyin

[Groups/0/Items/0]
# 名称
Name=keyboard-us
# 布局
Layout=

[Groups/0/Items/1]
# 名称
Name=pinyin
# 布局
Layout=
# 选项
Options=

[GroupOrder]
0=默认
FCITX_EOF

omarchy_log_line "[codeOS-zh] 中文本土化设置完成"
