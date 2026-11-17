# CHANGELOG

## v1.0 - Mini App Release (UTS)
Tanggal: [YYYY-MM-DD]
Perubahan:
- Mengintegrasikan seluruh milestone v0.0 sampai v0.3 dalam satu aplikasi.
- Melengkapi identitas aplikasi (nama, tema, tujuan, pengguna sasaran) di README.
- Menambahkan tabel fitur minimal Mini App v1.0 dan checklist kesiapan UTS (`docs/UTS_CHECKLIST.md`).
- Menaikkan versi aplikasi ke 1.0.0.
Bukti:
- Tag/release v1.0: [isi link]
- Screenshot/video demo: [isi link]

## v0.3 - Data Module (BAB 7)
Tanggal: 2026-11-16
Perubahan:
- Menambahkan model data `LostItem` (field `id`) di `lib/models/lost_item.dart`.
- Menambahkan local/mock data dengan auto-increment ID.
- Menambahkan fitur tambah data (Create) melalui form tervalidasi BAB 6.
- Menambahkan fitur ubah data (Update) melalui form edit.
- Menambahkan fitur hapus data (Delete) dengan dialog konfirmasi.
- Menambahkan empty state pada Daftar Barang dan Home.
- Menambahkan SnackBar untuk tambah, ubah, hapus, dan tandai ditemukan.
- Memastikan navigasi dan Form & Validation v0.2 tetap berjalan.
Bukti:
- Screenshot/video aplikasi berjalan: [isi link]
- Bukti skenario CRUD: [isi link]
- Commit Git: [isi link]
- AI_USAGE.md tersedia.

## v0.2 - Form & Validation (BAB 6)
Tanggal: [YYYY-MM-DD]
Perubahan:
- Menambahkan `lib/utils/validators.dart` berisi aturan validasi (wajib diisi, panjang minimal, format email, kontak).
- Menerapkan validator pada form Login, Registrasi, dan Lapor Barang.
- Menambahkan screen Profil Saya (form Nama + Email) dengan SnackBar dan teks status.
- Menambahkan `StatusText` sebagai state sederhana (setState) setelah submit.
- Menambahkan pengecekan `mounted` sebelum memakai context setelah proses.
- Memastikan semua `TextEditingController` di-dispose.
- Memastikan navigasi v0.1 tetap berjalan.
Bukti:
- Screenshot/video skenario validasi: [isi link]
- Commit Git: [isi link]
- AI_USAGE.md tersedia.

## v0.1 - Navigation (BAB 5)
- Navigasi antar-screen: Welcome, Login, Registrasi, Home, Lapor, Daftar Barang.

## v0.0 - Prototype (BAB 3)
- Struktur awal aplikasi Flutter dan tema.
