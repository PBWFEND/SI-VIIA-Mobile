import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Perpustakaan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Definisi initial route dan peta routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanKatalog(),
        '/detail': (context) => const HalamanDetail(),
        '/reservasi': (context) => const HalamanReservasi(),
      },
    );
  }
}

// --- LAYAR 1: KATALOG (Route: '/') ---
class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final daftarBuku = [
      {'judul': 'Pemrograman Flutter Dasar', 'kategori': 'Teknologi', 'status': 'Tersedia'},
      {'judul': 'Algoritma dan Struktur Data', 'kategori': 'Teknologi', 'status': 'Tersedia'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Buku')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: daftarBuku.length,
        itemBuilder: (context, index) {
          final buku = daftarBuku[index];
          return Card(
            child: ListTile(
              title: Text(buku['judul']!),
              subtitle: Text(buku['kategori']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Maju ke halaman detail dengan membawa arguments
                Navigator.pushNamed(context, '/detail', arguments: buku);
              },
            ),
          );
        },
      ),
    );
  }
}

// --- LAYAR 2: DETAIL BUKU (Route: '/detail') ---
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data dan memeriksa tipe (is) serta cabang null
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Data buku tidak valid atau kosong.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args['judul']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Kategori: ${args['kategori']}'),
            const SizedBox(height: 8),
            Text('Status: ${args['status']}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reservasi', arguments: args['judul']);
                },
                child: const Text('Buat Reservasi'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- LAYAR 3: FORM RESERVASI (Route: '/reservasi') ---
class HalamanReservasi extends StatefulWidget {
  const HalamanReservasi({super.key});

  @override
  State<HalamanReservasi> createState() => _HalamanReservasiState();
}

class _HalamanReservasiState extends State<HalamanReservasi> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();

  @override
  void dispose() {
    // Membersihkan controller untuk menghindari memory leak
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final judulBuku = ModalRoute.of(context)?.settings.arguments as String? ?? 'Buku';

    return Scaffold(
      appBar: AppBar(title: const Text('Form Reservasi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Reservasi: $judulBuku', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(labelText: 'Nomor Induk Mahasiswa', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'NIM tidak boleh kosong';
                if (value.length < 5) return 'NIM terlalu pendek';
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Tampilkan SnackBar sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reservasi atas nama ${_namaController.text} berhasil!')),
                  );
                  // Kembali ke halaman sebelumnya
                  Navigator.pop(context);
                }
              },
              child: const Text('Kirim Reservasi'),
            )
          ],
        ),
      ),
    );
  }
}