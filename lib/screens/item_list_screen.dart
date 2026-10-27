import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../theme.dart';
import '../widgets/item_card.dart';
import '../widgets/page_header.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  String _query = '';
  int _filter = 0; // 0 = semua, 1 = hilang, 2 = ditemukan

  List<LostItem> _visible() {
    final q = _query.trim().toLowerCase();
    return ItemService.items.where((it) {
      if (_filter == 1 && it.found) return false;
      if (_filter == 2 && !it.found) return false;
      if (q.isEmpty) return true;
      return it.name.toLowerCase().contains(q) ||
          it.location.toLowerCase().contains(q) ||
          it.category.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const labels = ['Semua', 'Hilang', 'Ditemukan'];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/report'),
        backgroundColor: AppColors.royal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Lapor',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          const PageHeader(
            title: 'Daftar Barang',
            subtitle: 'Barang hilang dan ditemukan di kampus.',
            bottomPadding: 24,
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: ValueListenableBuilder<int>(
                  valueListenable: ItemService.changes,
                  builder: (context, _, __) {
                    final list = _visible();
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 96),
                      children: [
                        TextField(
                          onChanged: (v) => setState(() => _query = v),
                          decoration: const InputDecoration(
                            hintText: 'Cari nama, lokasi, atau jenis barang',
                            prefixIcon: Icon(Icons.search_rounded),
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (var i = 0; i < labels.length; i++)
                              ChoiceChip(
                                label: Text(labels[i]),
                                selected: _filter == i,
                                showCheckmark: false,
                                selectedColor: AppColors.navy,
                                backgroundColor: Colors.white,
                                side: BorderSide.none,
                                labelStyle: TextStyle(
                                  color: _filter == i
                                      ? Colors.white
                                      : AppColors.ink,
                                  fontWeight: FontWeight.w600,
                                ),
                                onSelected: (_) => setState(() => _filter = i),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (list.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 48),
                            child: Column(
                              children: [
                                Icon(Icons.inbox_outlined,
                                    size: 56, color: AppColors.muted),
                                SizedBox(height: 12),
                                Text('Belum ada barang yang cocok',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.ink)),
                                SizedBox(height: 4),
                                Text('Coba ubah kata kunci atau filter.',
                                    style: TextStyle(color: AppColors.muted)),
                              ],
                            ),
                          )
                        else
                          for (final item in list)
                            ItemCard(
                              item: item,
                              detailed: true,
                              onMarkFound: () => ItemService.markFound(item),
                            ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
