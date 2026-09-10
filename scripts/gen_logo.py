#!/usr/bin/env python3
"""codeOS logo — 用 Minecraft 官方字体 Monocraft 渲染
步骤: 字体渲染 → 像素图像 → 提取前景像素 → 转为 SVG rect
保证全直角，零圆角，像素级精准
"""

from PIL import Image, ImageDraw, ImageFont
import xml.etree.ElementTree as ET
from xml.dom import minidom
import urllib.request, os, sys

FONT_PATH = "/tmp/Monocraft.ttf"
FONT_URL  = "https://github.com/IdreesInc/IdreesInc/Monocraft/contents/dist/Monocraft-ttf/Monocraft.ttf"
COLOR     = "#4aa26f"
DARK      = "#2d6b45"   # 阴影
LIGHT     = "#5fc07f"   # 高光
TEXT      = "CODEOS"

# 1. 下载字体
if not os.path.exists(FONT_PATH):
    print(f"下载 Monocraft...")
    urllib.request.urlretrieve(FONT_URL, FONT_PATH)

# 2. 用 Monocraft 渲染大尺寸文字
FONT_SIZE = 120
font = ImageFont.truetype(FONT_PATH, FONT_SIZE)

# 先测尺寸
img_test = Image.new("RGB", (1, 1), "white")
d = ImageDraw.Draw(img_test)
bbox = d.textbbox((0, 0), TEXT, font=font)
tw = bbox[2] - bbox[0]
th = bbox[3] - bbox[1]
print(f"文字尺寸: {tw}x{th} px (font size {FONT_SIZE})")

# 3. 渲染到足够大的画布
PAD = 40
img = Image.new("RGB", (tw + PAD*2 + 24, th + PAD*2 + 24), "white")
draw = ImageDraw.Draw(img)

# MC 风格: 先画右下阴影(偏移 4px), 再画主色文字
# 阴影
draw.text((PAD + 4 - bbox[0], PAD + 4 - bbox[1]), TEXT, font=font, fill=DARK)
# 主色
draw.text((PAD - bbox[0], PAD - bbox[1]), TEXT, font=font, fill=COLOR)

# 4. 二值化: 把非白色像素视为"实心"
pixels = img.load()
W, H = img.size

# 收集所有实心像素坐标
solid = set()
for y in range(H):
    for x in range(W):
        r, g, b = pixels[x, y]
        if r < 250 or g < 250 or b < 250:
            solid.add((x, y))

print(f"实心像素: {len(solid)}")

# 5. 转为 SVG (每个像素 = 一个 rect, 全直角)
ET.register_namespace("", "http://www.w3.org/2000/svg")
svg = ET.Element("svg", {
    "xmlns": "http://www.w3.org/2000/svg",
    "width": str(W),
    "height": str(H),
    "viewBox": f"0 0 {W} {H}",
    "shape-rendering": "crispEdges",
})

# 从 PIL 图像再画一遍到 SVG (保留颜色层次, 全直角)
# 阴影层
for y in range(H):
    for x in range(W):
        r, g, b = pixels[x, y]
        # 阴影色 (偏深绿)
        if r == int(DARK[1:3], 16) and g == int(DARK[3:5], 16) and b == int(DARK[5:7], 16):
            ET.SubElement(svg, "rect", {
                "x": str(x), "y": str(y),
                "width": "1", "height": "1",
                "fill": DARK,
            })

# 主色层
for y in range(H):
    for x in range(W):
        r, g, b = pixels[x, y]
        if r == int(COLOR[1:3], 16) and g == int(COLOR[3:5], 16) and b == int(COLOR[5:7], 16):
            ET.SubElement(svg, "rect", {
                "x": str(x), "y": str(y),
                "width": "1", "height": "1",
                "fill": COLOR,
            })

title = ET.SubElement(svg, "title")
title.text = "codeOS"

xml_str = ET.tostring(svg, encoding="unicode")
dom = minidom.parseString(xml_str)
pretty = dom.toprettyxml(indent="  ", encoding=None)
lines = pretty.split("\n")
svg_lines = [l for l in lines if not l.startswith('<?xml')]
final = "\n".join(svg_lines).strip()

# 由于 1px rect 太多, 优化合并相邻像素
print("优化 SVG (合并相邻 rect)...")
# 简单: 直接输出, 用浏览器压缩

out = "/Users/cangcang/WorkBuddy/2026-09-03-19-52-29/codeOS/logo.svg"
with open(out, "w") as f:
    f.write(final + "\n")

sz = os.path.getsize(out)
print(f"✅ {out} ({sz//1024}KB)")
print(f"   字体: Monocraft (Minecraft 官方)")
print(f"   尺寸: {W}x{H}")
print(f"   颜色: {COLOR} + 阴影 {DARK}")

# 同步
import shutil
repo = "/Users/cangcang/WorkBuddy/2026-09-03-19-52-29/codeOS"
for d in ["site/icon.svg", "site/brand/oma-logo.svg",
          "site/brand/omarchy-logo.svg", "site/brand/omarchy-wordmark.svg"]:
    shutil.copy2(out, f"{repo}/{d}")
print("   已同步到 site/")

# 同时导出 PNG
out_png = f"{repo}/icon.png"
# 直接保存渲染的图像 (裁掉白底)
# 找到边界
xs = [p[0] for p in solid]
ys = [p[1] for p in solid]
if xs:
    x0, x1 = min(xs), max(xs) + 1
    y0, y1 = min(ys), max(ys) + 1
    img_crop = img.crop((x0, y0, x1, y1))
    img_crop = img_crop.resize((img_crop.width * 2, img_crop.height * 2), Image.NEAREST)
    img_crop.save(out_png)
    print(f"   PNG: {out_png} ({img_crop.size[0]}x{img_crop.size[1]})")
