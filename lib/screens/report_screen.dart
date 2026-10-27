import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../theme.dart';
import '../widgets/page_header.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _locationC = TextEditingController();
  final _descC = TextEditingController();
  final _contactC = TextEditingController();
  String _category = ItemService.categories.first;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _nameC.dispose();
    _locationC.dispose();
    _descC.dispose();
    _contactC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ItemService.add(LostItem(
      name: _nameC.text.trim(),
      category: _category,
      location: _locationC.text.trim(),
      date: _date,
      description: _descC.text.trim(),
      contact: _contactC.text.trim(),
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan berhasil dikirim')),
    );
    Navigator.pop(context);
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.ink)),
      );

  @override
  Widget build(BuildContext context) {
    return HeaderScaffold(
      title: 'Lapor Barang Hilang',
      subtitle: 'Makin lengkap detailnya, makin mudah barangmu ditemukan.',
      maxWidth: 560,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Jenis barang'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in ItemService.categories)
                  ChoiceChip(
                    avatar: Icon(
                      ItemService.iconFor(c),
                      size: 18,
                      color: _category == c ? Colors.white : AppColors.muted,
                    ),
                    label: Text(c),
                    selected: _category == c,
                    showCheckmark: false,
                    selectedColor: AppColors.navy,
                    backgroundColor: const Color(0xFFF2F4F8),
                    side: BorderSide.none,
                    labelStyle: TextStyle(
                      color: _category == c ? Colors.white : AppColors.ink,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: _nameC,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                hintText: 'Contoh: Dompet kulit hitam',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Nama barang wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationC,
              decoration: const InputDecoration(
                labelText: 'Lokasi Terakhir',
                hintText: 'Contoh: Kantin Kampus',
                prefixIcon: Icon(Icons.place_outlined),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Lokasi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Hilang',
                  prefixIcon: Icon(Icons.event_outlined),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                child: Text(formatDate(_date)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descC,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Ciri-ciri barang',
                hintText: 'Warna, merek, tanda khusus...',
                alignLabelWithHint: true,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Deskripsi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contactC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Kontak (No. HP)',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              validator: (v) => (v == null || v.trim().length < 8)
                  ? 'Nomor kontak tidak valid'
                  : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send_rounded, size: 20),
                label: const Text('Kirim Laporan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
