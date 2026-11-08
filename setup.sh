#!/usr/bin/env bash
# Cài CleanYourTV (https://github.com/Gathin23/cleanyourtv) trên máy tính cùng mạng Wi-Fi với TV.
# Cách dùng: TV_HOST=192.168.1.50 ./setup.sh
set -euo pipefail
REPO=https://github.com/Gathin23/cleanyourtv
COMMIT=d451b175ab3f869f9a5d66993fb2dd501c96920b   # bản đã kiểm tra ngày 2026-11-08
DIR="${CLEANYOURTV_DIR:-$HOME/cleanyourtv}"

if [ ! -d "$DIR/.git" ]; then
  git clone "$REPO" "$DIR"
fi
git -C "$DIR" fetch --quiet origin
git -C "$DIR" checkout --quiet "$COMMIT"

cd "$DIR"
[ -x tools/venv/bin/python ] || python3 -m venv tools/venv
tools/venv/bin/pip install --quiet -r tools/requirements.txt
echo "Đã cài vào $DIR"

if [ -n "${TV_HOST:-}" ]; then
  echo "Kết nối TV $TV_HOST (bấm 'Cho phép' trên TV nếu được hỏi)..."
  TV_HOST="$TV_HOST" tools/venv/bin/python -I tools/tv.py --probe
else
  echo "Đặt TV_HOST=<IP của TV> rồi chạy lại để kiểm tra kết nối."
fi
