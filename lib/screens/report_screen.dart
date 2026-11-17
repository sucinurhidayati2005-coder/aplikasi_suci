import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../theme.dart';
import '../utils/validators.dart';
import '../widgets/page_header.dart';
import '../widgets/status_text.dart';

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

  String _status = '';

  LostItem? _editing; // null = mode tambah, terisi = mode ubah
  bool _loaded = false;

  bool get _isEdit => _editing != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is LostItem) {
      _editing = arg;
      _nameC.text = arg.name;
      _locationC.text = arg.location;
      _descC.text = arg.description;
      _contactC.text = arg.contact;
      _category = arg.category;
      _date = arg.date;
    }
  }

  @override
  void dispose() {
    _nameC.dispose();
    _locationC.dispose();
    _descC.dispose();
    _contactC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final last = _date.isAfter(now) ? _date : now;
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: last,
    );
    if (!mounted) return;
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _status = 'Periksa kembali input yang belum valid');
      return;
    }
    if (_isEdit) {
      // UPDATE
      ItemService.update(LostItem(
        id: _editing!.id,
        name: _nameC.text.trim(),
        category: _category,
        location: _locationC.text.trim(),
        date: _date,
        description: _descC.text.trim(),
        contact: _contactC.text.trim(),
        found: _editing!.found,
      ));
    } else {
      // CREATE
      ItemService.add(LostItem(
        id: ItemService.nextId,
        name: _nameC.text.trim(),
        category: _category,
        location: _locationC.text.trim(),
        date: _date,
        description: _descC.text.trim(),
        contact: _contactC.text.trim(),
      ));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEdit
            ? 'Data berhasil diperbarui'
            : 'Data berhasil ditambahkan'),
      ),
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
      title: _isEdit ? 'Ubah Laporan' : 'Lapor Barang Hilang',
      subtitle: _isEdit
          ? 'Perbarui detail laporan, lalu simpan.'
          : 'Makin lengkap detailnya, makin mudah barangmu ditemukan.',
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
              validator: (v) => Validators.name(v, 'Nama barang'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationC,
              decoration: const InputDecoration(
                labelText: 'Lokasi Terakhir',
                hintText: 'Contoh: Kantin Kampus',
                prefixIcon: Icon(Icons.place_outlined),
              ),
              validator: (v) => Validators.name(v, 'Lokasi'),
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
              validator: (v) => Validators.minLength(v, 'Ciri-ciri', 10),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contactC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Kontak (No. HP)',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              validator: Validators.phone,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: Icon(_isEdit ? Icons.save_rounded : Icons.send_rounded,
                    size: 20),
                label: Text(_isEdit ? 'Simpan Perubahan' : 'Kirim Laporan'),
              ),
            ),
            StatusText(_status, isError: true),
          ],
        ),
      ),
    );
  }
}
