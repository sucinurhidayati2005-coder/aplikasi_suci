import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/item_service.dart';
import '../theme.dart';
import '../widgets/item_card.dart';
import '../widgets/page_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: AuthService.profileChanges,
              builder: (context, _, __) => PageHeader(
              title: 'Halo, ${AuthService.currentName ?? 'Pengguna'}!',
              subtitle: 'Temukan Barangmu!',
              showBack: false,
              bottomPadding: 68,
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_rounded),
                  color: Colors.white,
                  tooltip: 'Profil',
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  color: Colors.white,
                  tooltip: 'Logout',
                  onPressed: () {
                    AuthService.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                  },
                ),
              ],
            )),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ValueListenableBuilder<int>(
                      valueListenable: ItemService.changes,
                      builder: (context, _, __) => _Body(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final latest = ItemService.items.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.search_rounded,
                color: AppColors.lost,
                count: ItemService.lostCount,
                label: 'Masih dicari',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_rounded,
                color: AppColors.found,
                count: ItemService.foundCount,
                label: 'Sudah ditemukan',
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Text('Menu',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.ink)),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _MenuTile(
                  icon: Icons.add_alert_rounded,
                  color: AppColors.lost,
                  title: 'Lapor Barang Hilang',
                  subtitle: 'Isi ciri-ciri dan lokasi terakhir.',
                  onTap: () => Navigator.pushNamed(context, '/report'),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _MenuTile(
                  icon: Icons.manage_search_rounded,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  title: 'Daftar Barang',
                  subtitle: 'Cari barang hilang dan yang ditemukan.',
                  onTap: () => Navigator.pushNamed(context, '/items'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            const Expanded(
              child: Text('Laporan terbaru',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/items'),
              child: const Text('Lihat semua'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (latest.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: softShadow,
            ),
            child: const Column(
              children: [
                Icon(Icons.inbox_outlined, size: 48, color: AppColors.muted),
                SizedBox(height: 10),
                Text('Belum ada data. Silakan tambahkan data baru.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.ink)),
              ],
            ),
          )
        else
          for (final item in latest) ItemCard(item: item),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int count;
  final String label;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$count',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink)),
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12.5, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(height: 16),
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.muted, height: 1.35)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
