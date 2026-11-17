import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../theme.dart';

class ItemCard extends StatelessWidget {
  final LostItem item;
  final bool detailed;
  final VoidCallback? onMarkFound;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ItemCard({
    super.key,
    required this.item,
    this.detailed = false,
    this.onMarkFound,
    this.onEdit,
    this.onDelete,
  });

  Widget _meta(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Icon(icon, size: 15, color: AppColors.muted),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final color = item.found ? AppColors.found : AppColors.lost;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 6, color: color),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color.withAlpha(30),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(ItemService.iconFor(item.category),
                              color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.ink,
                                ),
                              ),
                              _meta(Icons.place_outlined, item.location),
                              _meta(Icons.event_outlined, formatDate(item.date)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: color.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.found ? 'Ditemukan' : 'Hilang',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (detailed) ...[
                      const SizedBox(height: 12),
                      Text(
                        item.description,
                        style: const TextStyle(
                            color: AppColors.ink, fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_outlined,
                                  size: 16, color: AppColors.muted),
                              const SizedBox(width: 6),
                              Text(item.contact,
                                  style: const TextStyle(
                                      color: AppColors.muted, fontSize: 13)),
                            ],
                          ),
                          if (!item.found && onMarkFound != null)
                            TextButton.icon(
                              onPressed: onMarkFound,
                              icon: const Icon(Icons.check_circle_outline,
                                  size: 18),
                              label: const Text('Tandai ditemukan'),
                              style: TextButton.styleFrom(
                                  foregroundColor: AppColors.found),
                            ),
                        ],
                      ),
                      if (onEdit != null || onDelete != null) ...[
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (onEdit != null)
                              TextButton.icon(
                                onPressed: onEdit,
                                icon: const Icon(Icons.edit_rounded, size: 18),
                                label: const Text('Ubah'),
                              ),
                            if (onDelete != null)
                              TextButton.icon(
                                onPressed: onDelete,
                                icon: const Icon(Icons.delete_rounded,
                                    size: 18),
                                label: const Text('Hapus'),
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.lost),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
