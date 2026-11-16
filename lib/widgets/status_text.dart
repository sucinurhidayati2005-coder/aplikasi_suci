import 'package:flutter/material.dart';
import '../theme.dart';

/// Teks status sederhana (state) yang berubah setelah form disubmit.
class StatusText extends StatelessWidget {
  final String message;
  final bool isError;

  const StatusText(this.message, {super.key, this.isError = false});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();
    final color = isError ? AppColors.lost : AppColors.found;
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Icon(isError ? Icons.error_outline : Icons.check_circle_outline,
              size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message,
                style: TextStyle(
                    color: color, fontSize: 13.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
