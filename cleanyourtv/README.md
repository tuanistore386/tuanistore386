# CleanYourTV cho Sony và Samsung

Công cụ gốc: <https://github.com/Gathin23/cleanyourtv> (hướng dẫn tiếng Việt: `README.vi.md` trong repo đó).
Tắt app rác, quảng cáo, telemetry qua ADB trên mạng LAN và cài launcher gọn. Không root, chỉ **tắt** (không gỡ), có script khôi phục.

## Khả năng theo hãng

| Hãng | Hệ điều hành | Dọn app + launcher | Ghi chú |
|---|---|---|---|
| Sony Bravia / KD / XR | Android TV / Google TV | **Có** | Cần Android 8.0+ cho launcher. Repo gốc có ~30 danh sách Sony trong `examples/sony-*`. |
| Samsung | Tizen | **Không** | Tizen không có ADB, không tắt được app, không đổi được màn hình chính. Chỉ chỉnh tay trong Cài đặt + chặn DNS ở router (xem dưới). |

## 1. Cài trên máy tính (macOS / Linux, cùng Wi-Fi với TV)

```bash
git clone https://github.com/tuanistore386/tuanistore386
cd tuanistore386/cleanyourtv
TV_HOST=192.168.1.50 ./setup.sh     # thay bằng IP của TV
```

Script clone repo gốc vào `~/cleanyourtv` (cố định commit đã kiểm tra), tạo venv Python, cài thư viện và thử kết nối TV.

## 2. Sony: bật ADB trên TV

1. **Cài đặt → Hệ thống → Giới thiệu** → bấm OK 7 lần vào **Bản dựng (Build)**.
2. Quay lại **Tuỳ chọn nhà phát triển** → bật **Gỡ lỗi USB** (và **Gỡ lỗi qua mạng/ADB** nếu có).
3. Xem IP: **Cài đặt → Mạng & Internet** → chọn mạng đang dùng.
4. Chạy `setup.sh`, bấm **Cho phép** trên TV.

## 3. Sony: chọn danh sách đúng model

```bash
cd ~/cleanyourtv
ls examples | grep -i sony
cat examples/<model-sony>/debloat.txt     # đọc kỹ, bỏ dòng app mình còn dùng
```

Model có sẵn: Bravia 4K GB/UR2/UR3/VH1/VH2/VH21, Bravia 9 II, AE1/AE2, BF1, TL2, VU31,
KD-43X80L, KD-55X85J, KD-65X80J, KD-65X82L, KD-55XE8596, KD-55XF7596, KD-55XF8096, XR-65A80J, XBR-65X900F…
Không có model của bạn → dùng `PROMPT.md` với Claude Code để tự dò TV, **không** dùng danh sách model khác.

## 4. Sony: tắt app và cài launcher

```bash
export TV_HOST=192.168.1.50
tools/disable.sh examples/<model-sony>/debloat.txt       # giữ file bản ghi để hoàn tác

# Launcher (cần JDK 17 + Android SDK 34)
launcher/build-and-install.sh
# Giữ launcher gốc của Sony vẫn bật:
STOCK_LAUNCHER=none launcher/build-and-install.sh
```

Hoàn tác: `tools/restore.sh examples/<model-sony>/debloat.txt`.

Windows: dùng `tools\disable.ps1`, `tools\restore.ps1`, `launcher\build-and-install.ps1 -TvHost <IP>`.

## 5. Samsung Tizen: chỉnh tay

CleanYourTV không chạy trên Tizen. Làm trong menu TV:

- **Cài đặt → Hỗ trợ → Điều khoản & Chính sách**: tắt *Dịch vụ thông tin xem (Viewing Information Services)*,
  *Quảng cáo dựa trên sở thích (Interest-Based Advertisement)*, *Nhận dạng giọng nói* nếu không dùng.
- **Cài đặt → Chung → Tính năng thông minh**: tắt *Tự chạy Smart Hub* / *Tự chạy ứng dụng cuối*.
- Chặn quảng cáo/telemetry bằng DNS ở router (Pi-hole, AdGuard Home, NextDNS).

Tên menu khác nhau theo năm sản xuất và firmware.
