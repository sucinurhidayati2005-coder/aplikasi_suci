import 'package:flutter/material.dart';

class LostItem {
  final String name;
  final String category;
  final String location;
  final DateTime date;
  final String description;
  final String contact;
  bool found;

  LostItem({
    required this.name,
    required this.category,
    required this.location,
    required this.date,
    required this.description,
    required this.contact,
    this.found = false,
  });
}

String formatDate(DateTime d) {
  const bulan = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  return '${d.day} ${bulan[d.month - 1]} ${d.year}';
}

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
      name: 'HP Samsung Biru',
      category: 'HP',
      location: 'Masjid Kampus',
      date: DateTime(2026, 10, 25),
      description: 'Casing biru tua, layar retak di pojok kanan atas.',
      contact: '081234567801',
    ),
    LostItem(
      name: 'Kartu Mahasiswa a.n. Budi',
      category: 'Kartu Mahasiswa',
      location: 'Perpustakaan',
      date: DateTime(2026, 10, 20),
      description: 'Kartu terjatuh di dekat meja baca lantai 1.',
      contact: '081234567802',
    ),
    LostItem(
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

  static void add(LostItem item) {
    items.insert(0, item);
    changes.value++;
  }

  static void markFound(LostItem item) {
    item.found = true;
    changes.value++;
  }
}
