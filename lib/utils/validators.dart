/// Kumpulan aturan validasi input (BAB 6 - Form & Validation v0.2).
/// Setiap fungsi mengembalikan pesan error jika tidak valid, atau null jika valid.
class Validators {
  /// Wajib diisi.
  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field tidak boleh kosong';
    }
    return null;
  }

  /// Wajib diisi + panjang minimal.
  static String? minLength(String? value, String field, int min) {
    final empty = required(value, field);
    if (empty != null) return empty;
    if (value!.trim().length < min) return '$field minimal $min karakter';
    return null;
  }

  /// Nama: wajib diisi, minimal 3 karakter.
  static String? name(String? value, [String field = 'Nama']) =>
      minLength(value, field, 3);

  /// Email: wajib diisi + format dasar (ada @ dan titik pada domain).
  static String? email(String? value) {
    final empty = required(value, 'Email');
    if (empty != null) return empty;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim());
    if (!ok) return 'Format email belum sesuai';
    return null;
  }

  /// Password: wajib diisi, minimal 6 karakter.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  /// Nomor HP: wajib diisi, hanya angka (boleh diawali +), 8-15 digit.
  static String? phone(String? value) {
    final empty = required(value, 'Kontak');
    if (empty != null) return empty;
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value!.trim())) {
      return 'Nomor kontak harus 8-15 angka';
    }
    return null;
  }
}
