# Temukan Barangmu

## Deskripsi
Temukan Barangmu adalah aplikasi prototype untuk membantu mahasiswa melaporkan
barang hilang di kampus dan melihat barang yang sudah ditemukan.

## Milestone Saat Ini
Data Module v0.3 (dibangun di atas Form & Validation v0.2)

## Versi
v0.3 - Data Module

## Daftar Screen
- Welcome
- Login
- Registrasi
- Home (statistik + laporan terbaru)
- Profil Saya (Form Data Pengguna, BAB 6)
- Form Lapor Barang (juga dipakai sebagai form Ubah Laporan)
- Daftar Barang / Data Module (cari, filter, ubah, hapus, tandai ditemukan)

## Cara Menjalankan
```bash
flutter pub get
flutter run -d chrome
```

---

## BAB 6 - Form & Validation v0.2

### Fitur
- Form dengan `Form`, `GlobalKey<FormState>`, dan `TextFormField` + `validator`.
- Form: Login, Registrasi, Profil Saya, Lapor Barang.
- Aturan validasi dipusatkan di `lib/utils/validators.dart`.
- Pesan error yang jelas di bawah input.
- User feedback: `SnackBar` dan teks status (`StatusText`, state via `setState`).
- `TextEditingController` selalu di-`dispose()`; `mounted` dicek sebelum memakai `context` setelah proses.
- Navigasi v0.1 tetap berjalan.

### Aturan Validasi
| Input | Aturan | Pesan error |
|---|---|---|
| Nama / Nama barang / Lokasi | Wajib, minimal 3 karakter | "... tidak boleh kosong" / "... minimal 3 karakter" |
| Email | Wajib, format `x@y.z` | "Email tidak boleh kosong" / "Format email belum sesuai" |
| Password | Wajib, minimal 6 karakter | "Password tidak boleh kosong" / "Password minimal 6 karakter" |
| Konfirmasi password | Wajib, sama dengan password | "Password tidak sama" |
| Ciri-ciri barang | Wajib, minimal 10 karakter | "Ciri-ciri minimal 10 karakter" |
| Kontak | Wajib, 8-15 angka | "Nomor kontak harus 8-15 angka" |

### Skenario Uji BAB 6
| Skenario | Input | Hasil yang diharapkan |
|---|---|---|
| Form kosong | Semua kosong, tekan submit | Pesan error di tiap input + status "Periksa kembali input yang belum valid" |
| Nama terlalu pendek | Nama: `An` | "Nama minimal 3 karakter" |
| Email tidak valid | `tanpa-at` | "Format email belum sesuai" |
| Form valid | Nama & email benar (Profil) | SnackBar "Data berhasil diproses" + teks status berubah |
| Navigasi tetap berjalan | Home -> Profil -> kembali | Tanpa error |

---

## BAB 7 - Data Module v0.3

### Model Data
`LostItem` (`lib/models/lost_item.dart`): id, name, category, location, date, description, contact, found.

### Sumber Data
Data sementara di memori aplikasi menggunakan `List<LostItem>` dan mock data
(3 data awal di `lib/services/item_service.dart`). Data hilang saat aplikasi di-restart.
Input create/update memakai form tervalidasi dari BAB 6.

### Fitur
- **Create**: tambah laporan lewat form Lapor.
- **Read**: daftar, pencarian, filter Semua/Hilang/Ditemukan.
- **Update**: tombol "Ubah" membuka form yang sama (terisi data lama); "Tandai ditemukan".
- **Delete**: tombol "Hapus" dengan dialog konfirmasi.
- Empty state di Daftar Barang dan Home.
- SnackBar setelah tambah, ubah, hapus, dan tandai ditemukan.
- Navigasi v0.1 dan Form & Validation v0.2 tetap berjalan.

### Skenario Uji BAB 7
| Skenario | Aksi | Hasil yang diharapkan |
|---|---|---|
| Read data awal | Buka Daftar Barang | 3 data awal tampil |
| Create | Lapor Barang, isi form valid, kirim | Data baru di atas + SnackBar "Data berhasil ditambahkan" |
| Update | "Ubah", ganti nilai, simpan | Data berubah + SnackBar "Data berhasil diperbarui" |
| Delete | "Hapus" lalu "Hapus" di dialog | Data hilang + SnackBar "Data berhasil dihapus" |
| Batal hapus | "Hapus" lalu "Batal" | Data tetap ada |
| Empty state | Hapus semua data | "Belum ada data. Silakan tambahkan data baru." |
| Form BAB 6 tetap jalan | Kirim form kosong | Validasi dan feedback tetap berfungsi |

## Build APK
```bash
flutter build apk --release
# hasil: build/app/outputs/flutter-apk/app-release.apk
```

## Catatan Keamanan Data
Data yang digunakan merupakan data simulasi dan tidak memuat data pribadi nyata,
API key, token, password, credential, atau data sensitif. Nomor kontak pada mock
data adalah nomor contoh.
