#!/usr/bin/env bash
# Cài skill video-shotcraft (https://github.com/Vincentwei1021/video-shotcraft) cho Claude Code và Codex.
# Cách dùng: ./setup.sh
set -euo pipefail
REPO=https://github.com/Vincentwei1021/video-shotcraft.git
COMMIT=1266a3ec4831289c4d893d42dd5102723658039a   # bản đã kiểm tra ngày 2026-11-07
DIR="${VIDEO_SHOTCRAFT_DIR:-$HOME/video-shotcraft}"

if [ ! -d "$DIR/.git" ]; then
  git clone "$REPO" "$DIR"
fi
git -C "$DIR" fetch --quiet origin
git -C "$DIR" checkout --quiet "$COMMIT"
echo "Đã tải về $DIR"

link_skill() {   # $1 = thư mục skills của agent
  mkdir -p "$1"
  ln -sfn "$DIR" "$1/video-shotcraft"
  echo "Đã liên kết: $1/video-shotcraft -> $DIR"
}
link_skill "$HOME/.claude/skills"                       # Claude Code
[ -d "$HOME/.codex" ] && link_skill "$HOME/.codex/skills" # Codex (nếu có cài)

for bin in node npm ffmpeg ffprobe; do
  command -v "$bin" >/dev/null || echo "THIẾU: $bin (cần để render video)"
done
command -v uv >/dev/null || echo "Tuỳ chọn: cài uv nếu muốn phân tích nhịp nhạc BGM"
echo "Xong. Mở Claude Code và nói: \"Dùng video-shotcraft làm video quảng cáo cho sản phẩm của tôi\"."
