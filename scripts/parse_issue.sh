#!/bin/bash
# parse_issue.sh — 从 GitHub Issue body 中提取 ISO 构建参数
# 用法: parse_issue.sh <issue_number>
# 输出: stdout 为 JSON: {"build_type":"custom","extra_packages":["foo","bar"], "validation_ok":true}

ISSUE_NUM="${1:?需要 Issue 编号}"
REPO="${GITHUB_REPOSITORY:-CODEOS-dev/codeOS}"

# 1. 抓 body（无论成功失败都不要让它炸）
BODY=$(gh api "repos/$REPO/issues/$ISSUE_NUM" --jq '.body' 2>/dev/null || true)
[ -z "$BODY" ] && BODY=""

# 2. 提取额外包 — 找所有 markdown ``` code block 里的非注释非空行
#    GitHub Issue 模板的 section 标题格式不稳定，但 code block 是稳定的
EXTRA=$(echo "$BODY" \
  | awk '/```/{flag=!flag; next} flag' \
  | sed '/^[[:space:]]*#/d' \
  | sed '/^[[:space:]]*$/d' \
  | sed 's/^[[:space:]]*- //' \
  | sed 's/^[[:space:]]*`//;s/`[[:space:]]*$//')

# 3. 包名校验 — 正则：允许字母数字下划线连字符点号，可选 aur: 前缀
#    拒绝任何 shell 特殊字符（; | & $ ` " ' 等）
VALID=()
INVALID=()
while IFS= read -r pkg; do
  [ -z "$pkg" ] && continue
  pkg=$(echo "$pkg" | xargs)  # trim
  if [[ "$pkg" =~ ^(aur:)?[a-zA-Z0-9][a-zA-Z0-9._+-]*$ ]]; then
    VALID+=("$pkg")
  else
    INVALID+=("$pkg")
  fi
done <<< "$EXTRA"

# 4. 构建类型：有有效额外包 = custom，否则 = standard
if [ ${#VALID[@]} -gt 0 ]; then
  BUILD_TYPE="custom"
else
  BUILD_TYPE="standard"
fi

# 5. validation_ok：没有无效包
VALIDATION_OK=true
[ ${#INVALID[@]} -gt 0 ] && VALIDATION_OK=false

# 6. 输出 JSON
VALID_JSON="["
FIRST=true
for p in "${VALID[@]+"${VALID[@]}"}"; do
  $FIRST && FIRST=false || VALID_JSON+=","
  VALID_JSON+="\"$p\""
done
VALID_JSON+="]"

INVALID_JSON="["
FIRST=true
for p in "${INVALID[@]+"${INVALID[@]}"}"; do
  $FIRST && FIRST=false || INVALID_JSON+=","
  INVALID_JSON+="\"$p\""
done
INVALID_JSON+="]"

echo "{\"build_type\":\"$BUILD_TYPE\",\"extra_packages\":$VALID_JSON,\"validation_ok\":$VALIDATION_OK,\"invalid_packages\":$INVALID_JSON}"
