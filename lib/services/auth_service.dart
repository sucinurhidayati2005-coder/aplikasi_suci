/// Penyimpanan akun sederhana (di memori, hilang saat app di-restart).
/// Ganti dengan API/database kalau sudah dibutuhkan.
class AuthService {
  static final Map<String, Map<String, String>> _users = {};
  static String? currentName;

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
    return true;
  }

  static void logout() => currentName = null;
}
