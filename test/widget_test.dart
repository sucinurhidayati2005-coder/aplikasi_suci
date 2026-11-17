import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  void setBigScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  testWidgets('Welcome tampil dan navigasi ke Login', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());

    expect(find.text('Selamat Datang'), findsOneWidget);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Masuk'), findsOneWidget);
  });

  testWidgets('Form login kosong menampilkan pesan error', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);
  });

  testWidgets('Registrasi lalu login masuk ke Beranda', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();

    final reg = find.byType(TextFormField);
    await tester.enterText(reg.at(0), 'Suci');
    await tester.enterText(reg.at(1), 'suci@mail.com');
    await tester.enterText(reg.at(2), 'rahasia123');
    await tester.enterText(reg.at(3), 'rahasia123');
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    final login = find.byType(TextFormField);
    await tester.enterText(login.at(0), 'suci@mail.com');
    await tester.enterText(login.at(1), 'rahasia123');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Suci!'), findsOneWidget);
  });

  testWidgets('Lapor barang hilang muncul di Beranda', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();
    final reg = find.byType(TextFormField);
    await tester.enterText(reg.at(0), 'Suci');
    await tester.enterText(reg.at(1), 'suci2@mail.com');
    await tester.enterText(reg.at(2), 'rahasia123');
    await tester.enterText(reg.at(3), 'rahasia123');
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    final login = find.byType(TextFormField);
    await tester.enterText(login.at(0), 'suci2@mail.com');
    await tester.enterText(login.at(1), 'rahasia123');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lapor Barang Hilang'));
    await tester.pumpAndSettle();

    final f = find.byType(TextFormField);
    await tester.enterText(f.at(0), 'Dompet Hitam');
    await tester.enterText(f.at(1), 'Kantin Kampus');
    await tester.enterText(f.at(2), 'Dompet kulit warna hitam');
    await tester.enterText(f.at(3), '081234567890');
    await tester.tap(find.text('Kirim Laporan'));
    await tester.pumpAndSettle();

    // Kembali ke Beranda, laporan baru tampil di "Laporan terbaru".
    expect(find.text('Dompet Hitam'), findsOneWidget);
  });

  Future<void> registerAndLogin(WidgetTester tester, String email) async {
    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();
    final reg = find.byType(TextFormField);
    await tester.enterText(reg.at(0), 'Suci');
    await tester.enterText(reg.at(1), email);
    await tester.enterText(reg.at(2), 'rahasia123');
    await tester.enterText(reg.at(3), 'rahasia123');
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    final login = find.byType(TextFormField);
    await tester.enterText(login.at(0), email);
    await tester.enterText(login.at(1), 'rahasia123');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
  }

  testWidgets('BAB 6: validasi registrasi (nama pendek, email salah)',
      (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();

    final reg = find.byType(TextFormField);
    await tester.enterText(reg.at(0), 'An');
    await tester.enterText(reg.at(1), 'tanpa-at');
    await tester.tap(find.text('Daftar'));
    await tester.pump();

    expect(find.text('Nama minimal 3 karakter'), findsOneWidget);
    expect(find.text('Format email belum sesuai'), findsOneWidget);
  });

  testWidgets('BAB 6: form profil valid menampilkan status', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());
    await registerAndLogin(tester, 'profil@mail.com');

    await tester.tap(find.byIcon(Icons.person_rounded));
    await tester.pumpAndSettle();

    final f = find.byType(TextFormField);
    await tester.enterText(f.at(0), 'Suci Baru');
    await tester.tap(find.text('Simpan'));
    await tester.pump();

    expect(find.text('Data valid: Suci Baru (profil@mail.com)'),
        findsOneWidget);
  });

  testWidgets('BAB 7: ubah dan hapus laporan', (tester) async {
    setBigScreen(tester);
    await tester.pumpWidget(const MyApp());
    await registerAndLogin(tester, 'crud@mail.com');

    await tester.tap(find.text('Daftar Barang'));
    await tester.pumpAndSettle();
    expect(find.text('HP Samsung Biru'), findsOneWidget);

    // UPDATE
    await tester.tap(find.text('Ubah').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'HP Samsung Hitam');
    await tester.tap(find.text('Simpan Perubahan'));
    await tester.pumpAndSettle();
    expect(find.text('HP Samsung Hitam'), findsOneWidget);

    // DELETE dengan konfirmasi
    await tester.tap(find.text('Hapus').first);
    await tester.pumpAndSettle();
    expect(find.text('Konfirmasi Hapus'), findsOneWidget);
    await tester.tap(find.descendant(
        of: find.byType(AlertDialog), matching: find.text('Hapus')));
    await tester.pumpAndSettle();
    expect(find.text('HP Samsung Hitam'), findsNothing);
  });
}
