# video-shotcraft – biến Claude Code thành đoàn làm phim

Skill gốc: <https://github.com/Vincentwei1021/video-shotcraft> (Apache-2.0) · Thư viện cảnh quay: <https://vincentwei1021.github.io/video-shotcraft/>

Không phải AI tạo video. Agent chụp trang web/sản phẩm thật, chọn cảnh từ 124 thẻ (150 shot), dựng storyboard,
làm chuyển động bằng Remotion, cắt theo nhịp nhạc, thêm hiệu ứng âm thanh, kiểm tra từng khung hình và xuất **MP4 1920×1080**.
Có thêm Motion Workbench (trình chỉnh kiểu CapCut trên trình duyệt) và xuất bản nháp JianYing.

## Cài (macOS / Linux)

```bash
git clone https://github.com/tuanistore386/tuanistore386
cd tuanistore386/video-shotcraft
./setup.sh
```

Script clone skill vào `~/video-shotcraft` (cố định commit đã kiểm tra) và liên kết vào `~/.claude/skills/` (và `~/.codex/skills/` nếu có Codex).

Cần: **Node.js + npm**, **ffmpeg/ffprobe**. Tuỳ chọn: `uv` (phân tích nhịp BGM). Remotion tự tải Chrome headless lần render đầu.

## Dùng

Mở Claude Code trong thư mục dự án, nói bằng lời – không cần lệnh:

| Nói | Kết quả |
|---|---|
| `Dùng video-shotcraft làm video quảng cáo cho website icheckvn.info` | Agent kiểm tra sản phẩm, đề xuất 1 trong 3 chế độ (template Ink Press / tự sáng tạo / cùng sáng tạo) rồi làm |
| `Làm video ra mắt bằng template Ink Press` | Nhanh nhất: thay ảnh chụp, chữ, logo vào template có sẵn |
| `Dùng shot deck-deal-flyin và row-embed để giới thiệu tính năng này` | Chọn cảnh theo tên (copy từ Gallery) |

Sau khi xong, mở trình chỉnh sửa: `node ~/video-shotcraft/workbench/scripts/open.mjs <thư-mục-dự-án>`

## Gợi ý cho công việc của anh

- **icheckvn.info / info247.vn**: video demo tra IMEI/iCloud từ chính giao diện web thật.
- **Cửa hàng Apple**: video giới thiệu trang sản phẩm, bảng giá, chính sách bảo hành.
- **Thuê xe VinFast**: video quảng cáo trang đặt xe (cần có website/landing page để chụp).

## Lưu ý

- Linux không màn hình: render thêm `--concurrency=1`, dùng chrome-headless-shell (xem README gốc, mục *Headless Linux*).
- Đăng TikTok/YouTube tự động (Upload-Post) chỉ chạy khi anh yêu cầu, có bước xác nhận trước.
