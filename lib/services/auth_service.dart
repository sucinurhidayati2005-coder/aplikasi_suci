import 'package:flutter/foundation.dart';

/// Penyimpanan akun sederhana (di memori, hilang saat app di-restart).
/// Ganti dengan API/database kalau sudah dibutuhkan.
class AuthService {
  static final Map<String, Map<String, String>> _users = {};
  static String? currentName;
  static String? currentEmail;

  /// Berubah saat profil diperbarui, supaya sapaan di Beranda ikut refresh.
  static final ValueNotifier<int> profileChanges = ValueNotifier(0);

  static bool register(String name, String email, String password) {
    final key = email.trim().toLowerCase();
    if (_users.containsKey(key)) return false;
    _users[key] = {'name': name.trim(), 'password': password};
    return true;
  }

  static bool login(String email, String password) {
    final user = _users[email.trim().toLowerCase()];
    if (user == null || user['password'] != password) return false;
    currentName = user['name'];
    currentEmail = email.trim().toLowerCase();
    return true;
  }

  /// Memperbarui nama dan email akun yang sedang login.
  /// Mengembalikan false jika email baru sudah dipakai akun lain.
  static bool updateProfile(String name, String email) {
    final newKey = email.trim().toLowerCase();
    final oldKey = currentEmail;
    if (oldKey == null) {
      currentName = name.trim();
      currentEmail = newKey;
      profileChanges.value++;
      return true;
    }
    if (newKey != oldKey && _users.containsKey(newKey)) return false;
    final data = _users.remove(oldKey) ?? {'password': ''};
    data['name'] = name.trim();
    _users[newKey] = data;
    currentName = name.trim();
    currentEmail = newKey;
    profileChanges.value++;
    return true;
  }

  static void logout() {
    currentName = null;
    currentEmail = null;
  }
}
