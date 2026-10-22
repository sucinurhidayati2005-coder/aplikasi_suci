import 'package:flutter/material.dart';

void main() {
  runApp(const FindSearchApp());
}

// MODEL DATA BARANG
class Barang {
  final String nama;
  final String keterangan;
  final IconData icon;

  Barang({
    required this.nama,
    required this.keterangan,
    this.icon = Icons.inventory_2,
  });
}

// Daftar barang (disimpan di memori selama aplikasi berjalan)
final List<Barang> daftarBarang = [
  Barang(
    nama: 'Kartu Mahasiswa',
    keterangan: 'Ditemukan di area perpustakaan',
    icon: Icons.credit_card,
  ),
  Barang(
    nama: 'Botol Minum',
    keterangan: 'Hilang di area kelas',
    icon: Icons.water_drop,
  ),
  Barang(
    nama: 'Headphone',
    keterangan: 'Ditemukan di kantin kampus',
    icon: Icons.headphones,
  ),
];

class FindSearchApp extends StatelessWidget {
  const FindSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Search',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// SCREEN 1: HOME
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Search',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Temukan Barangmu!',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Platform pencarian barang hilang dan ditemukan di kampus.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.travel_explore, color: Colors.white, size: 45),
                  SizedBox(height: 12),
                  Text(
                    'Cari Barang Hilang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Jangan khawatir, cari barangmu di sini.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.inventory_2),
                label: const Text('Daftar Barang'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeatureScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_box),
                label: const Text('Tambah Barang Temuan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahBarangScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Profil Pengguna'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SCREEN 2: DAFTAR BARANG
class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  Future<void> _bukaTambahBarang() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahBarangScreen()),
    );
    // Refresh daftar setelah kembali dari halaman tambah
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaTambahBarang,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Barang Hilang dan Ditemukan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...daftarBarang.map(
            (barang) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(barang.icon),
                ),
                title: Text(barang.nama),
                subtitle: Text(barang.keterangan),
                trailing: const Icon(Icons.search, color: Colors.indigo),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Catatan: Data barang disimpan sementara selama aplikasi berjalan.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

// SCREEN 3: TAMBAH BARANG TEMUAN
class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void dispose() {
    namaBarangController.dispose();
    lokasiController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final deskripsi = deskripsiController.text.trim();
    final keterangan = deskripsi.isEmpty
        ? 'Ditemukan di ${lokasiController.text.trim()}'
        : 'Ditemukan di ${lokasiController.text.trim()} - $deskripsi';

    daftarBarang.insert(
      0,
      Barang(
        nama: namaBarangController.text.trim(),
        keterangan: keterangan,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barang temuan berhasil ditambahkan!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang Temuan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menemukan barang?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Isi data barang agar pemiliknya bisa menemukannya.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  hintText: 'Contoh: Dompet hitam',
                  prefixIcon: Icon(Icons.inventory_2),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Nama barang harus diisi'
                    : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi Ditemukan',
                  hintText: 'Contoh: Kantin kampus',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Lokasi harus diisi'
                    : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: deskripsiController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (opsional)',
                  hintText: 'Ciri-ciri barang',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Barang'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: _simpan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SCREEN 4: PROFIL PENGGUNA
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Profil Find Search',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi identitas untuk menggunakan aplikasi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama kamu',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                hintText: 'Masukkan NIM kamu',
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan Profil'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  if (namaController.text.trim().isEmpty ||
                      nimController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nama dan NIM harus diisi!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Halo ${namaController.text}, profil berhasil diisi!',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
