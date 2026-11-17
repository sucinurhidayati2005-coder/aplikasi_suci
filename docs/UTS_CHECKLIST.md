# Persiapan UTS Mini App v1.0

Catatan: selama sesi UTS **tidak boleh memakai AI tools**, tidak boleh membuka kode mahasiswa lain, dan
tidak boleh berkomunikasi dengan mahasiswa lain. Dokumen ini hanya untuk persiapan sebelum hari UTS.

## Checklist sebelum hari UTS
- [ ] Repository bisa diakses dosen (public / dosen jadi collaborator)
- [ ] Commit terakhir jelas / sudah ada tag v1.0
- [ ] README.md dan CHANGELOG.md sampai v1.0 (isi tanggal dan link bukti)
- [ ] Screenshot/video demo siap
- [ ] Hafal username & password GitHub/GitLab dan LMS
- [ ] `flutter pub get` dan `flutter run -d chrome` berjalan tanpa error
- [ ] Tidak ada API key/token/password/credential di repository dan evidence
- [ ] Siap menjelaskan kode (lihat daftar di bawah)

## Git: tag v1.0
```bash
git add .
git commit -m "Mini App v1.0 release"
git push
git tag v1.0
git push origin v1.0
```

## Git: commit hasil Live Coding (format wajib)
```bash
git add .
git commit -m "UTS: [deskripsi singkat perubahan]"
git push
```

## Peta kode untuk dijelaskan saat UTS
| Pertanyaan | Lokasi kode |
|---|---|
| Navigasi / daftar route | `lib/main.dart` |
| Model data | `lib/models/lost_item.dart` |
| Data disimpan di list, tambah/ubah/hapus | `lib/services/item_service.dart` |
| Validasi input | `lib/utils/validators.dart` |
| Form + `setState` + status | `lib/screens/profile_screen.dart` |
| Create/Update lewat form | `lib/screens/report_screen.dart` |
| Delete + dialog konfirmasi, empty state | `lib/screens/item_list_screen.dart` |
| `dispose()` dan `mounted` | `profile_screen.dart`, `report_screen.dart` |

Latihan modifikasi kecil (kerjakan sendiri tanpa AI): ubah judul halaman, ubah warna tombol/AppBar
(`theme.dart`), tambah satu validasi, ubah teks SnackBar, tunjukkan kode empty state.

## Template Online Text LMS
```
Nama: 
NIM: 
Kelas: 
Nama Aplikasi: Temukan Barangmu
Link Repository: 
Link Commit/Tag/Release v1.0: 
Link Commit Hasil Live Coding: 
Link Screenshot/Video Demo: 
Fitur yang Sudah Berjalan: Login/registrasi, form tervalidasi, profil, CRUD laporan barang (tambah, lihat, ubah, hapus), pencarian dan filter, empty state, SnackBar dan dialog konfirmasi.
Soal Live Coding yang Didapat: [tulis dari Quiz]
Jawaban Soal Live Coding: [tulis sendiri setelah mengerjakan]
Penjelasan Bagian Kode: [tulis sendiri]
Kendala Teknis: [isi atau "Tidak ada kendala"]
Solusi yang Dicoba: 
Pernyataan Integritas: [isi sendiri setelah UTS selesai]
```
