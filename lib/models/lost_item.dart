/// Model data laporan barang hilang/ditemukan.
/// Semua data bersifat simulasi (mock), bukan data pribadi nyata.
class LostItem {
  final int id;
  String name;
  String category;
  String location;
  DateTime date;
  String description;
  String contact;
  bool found;

  LostItem({
    required this.id,
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
