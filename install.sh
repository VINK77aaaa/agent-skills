#!/usr/bin/env bash
# 把本仓库 skills/ 下的技能安装到 agent 技能目录。
# 用法：bash install.sh [--copy] [--target DIR]...
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$ROOT/skills"
MODE="link"
TARGETS=()

usage() {
  cat <<'EOF'
用法: bash install.sh [选项]

  --copy            复制技能目录（默认优先符号链接）
  --target DIR      指定安装目录，可重复传入
  --help            显示本帮助

不带 --target 时自动探测：~/.workbuddy-ai/skills、~/.claude/skills、
~/.codex/skills；都没找到则装到 ~/.agent-skills。
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --copy) MODE="copy"; shift ;;
    --link) MODE="link"; shift ;;
    --target)
      [ $# -ge 2 ] || { echo "错误: --target 需要一个目录参数" >&2; exit 2; }
      TARGETS+=("$2"); shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "错误: 未知参数 $1" >&2; usage; exit 2 ;;
  esac
done

if [ ${#TARGETS[@]} -eq 0 ]; then
  for c in "$HOME/.workbuddy-ai/skills" "$HOME/.claude/skills" "$HOME/.codex/skills"; do
    [ -d "$c" ] && TARGETS+=("$c")
  done
  if [ ${#TARGETS[@]} -eq 0 ]; then
    TARGETS+=("$HOME/.agent-skills")
    echo "未探测到已知技能目录，将安装到 $HOME/.agent-skills"
  fi
fi

[ -d "$SRC" ] || { echo "错误: 找不到 $SRC" >&2; exit 1; }

for t in "${TARGETS[@]}"; do
  mkdir -p "$t"
  echo "==> $t"
  for d in "$SRC"/*/; do
    name="$(basename "$d")"
    dst="$t/$name"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
      echo "    跳过 $name（$dst 已存在，需先移除再装）"
      continue
    fi
    if [ "$MODE" = "link" ]; then
      if ln -s "$d" "$dst" 2>/dev/null; then
        echo "    链接 $name"
      else
        cp -r "$d" "$dst"
        echo "    复制 $name（符号链接不可用，已改为复制）"
      fi
    else
      cp -r "$d" "$dst"
      echo "    复制 $name"
    fi
  done
done

echo
echo "完成。重启 agent 会话后技能才会被加载。"
echo "rideclaw-mcp 需要令牌：见 docs/credentials.md"
