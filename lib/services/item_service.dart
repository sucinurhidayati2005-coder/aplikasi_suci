import 'package:flutter/material.dart';
import '../models/lost_item.dart';

export '../models/lost_item.dart';

/// Penyimpanan laporan di memori (hilang saat app di-restart).
class ItemService {
  static const categories = [
    'Kartu Mahasiswa',
    'Dompet',
    'HP',
    'Kunci',
    'Tas',
    'Lainnya',
  ];

  static IconData iconFor(String category) {
    switch (category) {
      case 'Kartu Mahasiswa':
        return Icons.badge_rounded;
      case 'Dompet':
        return Icons.account_balance_wallet_rounded;
      case 'HP':
        return Icons.smartphone_rounded;
      case 'Kunci':
        return Icons.vpn_key_rounded;
      case 'Tas':
        return Icons.work_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  /// Berubah setiap ada laporan baru / status berubah, supaya layar ikut refresh.
  static final ValueNotifier<int> changes = ValueNotifier(0);

  static final List<LostItem> items = [
    LostItem(
      id: 1,
      name: 'HP Samsung Biru',
      category: 'HP',
      location: 'Masjid Kampus',
      date: DateTime(2026, 10, 25),
      description: 'Casing biru tua, layar retak di pojok kanan atas.',
      contact: '081234567801',
    ),
    LostItem(
      id: 2,
      name: 'Kartu Mahasiswa a.n. Budi',
      category: 'Kartu Mahasiswa',
      location: 'Perpustakaan',
      date: DateTime(2026, 10, 20),
      description: 'Kartu terjatuh di dekat meja baca lantai 1.',
      contact: '081234567802',
    ),
    LostItem(
      id: 3,
      name: 'Kunci Motor Honda',
      category: 'Kunci',
      location: 'Parkiran Gedung A',
      date: DateTime(2026, 10, 18),
      description: 'Gantungan kunci berbentuk beruang cokelat.',
      contact: '081234567803',
      found: true,
    ),
  ];

  static int get lostCount => items.where((e) => !e.found).length;
  static int get foundCount => items.where((e) => e.found).length;

  /// ID berikutnya (auto-increment sederhana, tidak direset saat data dihapus).
  static int _nextId = 4;
  static int get nextId => _nextId++;

  /// CREATE
  static void add(LostItem item) {
    items.insert(0, item);
    changes.value++;
  }

  /// UPDATE
  static void update(LostItem updated) {
    final index = items.indexWhere((e) => e.id == updated.id);
    if (index == -1) return;
    items[index] = updated;
    changes.value++;
  }

  /// UPDATE status
  static void markFound(LostItem item) {
    item.found = true;
    changes.value++;
  }

  /// DELETE
  static void delete(LostItem item) {
    items.removeWhere((e) => e.id == item.id);
    changes.value++;
  }
}
