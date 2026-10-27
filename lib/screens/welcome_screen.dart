import 'package:flutter/material.dart';
import '../theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _illustration() {
    return SizedBox(
      width: 230,
      height: 230,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 230,
            height: 230,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.royal.withAlpha(14)),
          ),
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.royal.withAlpha(24)),
          ),
          Transform.rotate(
            angle: -0.18,
            child: Container(
              width: 120,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.royal,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.badge_rounded,
                      size: 56, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(
                      width: 62,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(190),
                          borderRadius: BorderRadius.circular(4))),
                  const SizedBox(height: 7),
                  Container(
                      width: 42,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(120),
                          borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ),
          ),
          Positioned(
            right: 14,
            bottom: 22,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.navy,
                boxShadow: [
                  BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 16,
                      offset: Offset(0, 8)),
                ],
              ),
              child: const Icon(Icons.search_rounded,
                  size: 34, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _illustration(),
                    const SizedBox(height: 36),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        color: AppColors.royal,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Barang hilang di kampus? Temukan lagi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Laporkan barang yang hilang, atau cek barang yang sudah ditemukan teman-temanmu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.muted, fontSize: 15, height: 1.45),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.royal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.royal,
                          side: const BorderSide(color: AppColors.royal),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        child: const Text('Registrasi'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
