import 'package:flutter/material.dart';



class Rute {
  static const String katalog = '/katalog';
  static const String detailBuku = '/detail-buku';
  static const String masuk = '/masuk';
  static const String peminjamanSaya = '/peminjaman-saya';
  static const String riwayatPeminjaman = '/riwayat-peminjaman';
}

class DataBuku {
  const DataBuku({
    required this.judul,
    required this.penulis,
    required this.stok,
    required this.penerbit,
  });

  final String judul;
  final String penulis;
  final int stok;
  final String penerbit;
}

void main() => runApp(const SiRakusApp());

class SiRakusApp extends StatelessWidget {
  const SiRakusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI RAKUS',
      debugShowCheckedModeBanner: false,
      initialRoute: Rute.katalog,
      routes: {
        Rute.katalog: (context) => const HalamanKatalog(),
        Rute.detailBuku: (context) => const HalamanDetailBuku(),
        Rute.masuk: (context) => const HalamanMasuk(),
        Rute.peminjamanSaya: (context) => const HalamanPeminjamanSaya(),
        Rute.riwayatPeminjaman: (context) => const HalamanRiwayatPeminjaman(),
      },
    );
  }
}

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  static const List<DataBuku> daftarBuku = [
    DataBuku(
      judul: 'Dasar-Dasar Pemrograman',
      penulis: 'Andi Pratama',
      stok: 3,
      penerbit: 'Pustaka Kampus',
    ),
    DataBuku(
      judul: 'Pengantar Basis Data',
      penulis: 'Siti Rahmawati',
      stok: 0,
      penerbit: 'Pustaka Kampus',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SI RAKUS — Katalog Buku'),
        actions: [
          IconButton(
            tooltip: 'Masuk / Verifikasi Akun',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.pushNamed(context, Rute.masuk),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarBuku.length,
        itemBuilder: (context, index) {
          final buku = daftarBuku[index];
          return Card(
            child: ListTile(
              title: Text(buku.judul),
              subtitle: Text(
                '${buku.penulis}\n${buku.stok > 0 ? 'Tersedia' : 'Stok habis'} — ${buku.stok} eksemplar',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO 1: objek DataBuku yang dipilih dikirim sebagai arguments.
                Navigator.pushNamed(
                  context,
                  Rute.detailBuku,
                  arguments: buku,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HalamanDetailBuku extends StatelessWidget {
  const HalamanDetailBuku({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO 2: Jelaskan mengapa arguments harus diperiksa tipenya sebelum digunakan.
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final DataBuku? buku = args is DataBuku ? args : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: buku == null
          ? const Center(child: Text('Data buku tidak tersedia.'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(buku.judul, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text('Penulis: ${buku.penulis}'),
                  Text('Penerbit: ${buku.penerbit}'),
                  const SizedBox(height: 16),
                  Chip(
                    label: Text(
                      buku.stok > 0
                          ? 'Tersedia — ${buku.stok} eksemplar'
                          : 'Stok habis — 0 eksemplar',
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class HalamanMasuk extends StatefulWidget {
  const HalamanMasuk({super.key});

  @override
  State<HalamanMasuk> createState() => _HalamanMasukState();
}

class _HalamanMasukState extends State<HalamanMasuk> {
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _kataSandiController = TextEditingController();
  bool _inputLolosValidasi = false;

  void _kirimForm() {
    // TODO 3: Lengkapi/ubah validator sesuai ketentuan akun uji yang kamu gunakan.
    if (!_formKey.currentState!.validate()) return;

    setState(() => _inputLolosValidasi = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Input memenuhi validasi (simulasi). Verifikasi akun sebenarnya belum terhubung.',
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO 4: Jelaskan mengapa kedua controller harus dibersihkan di dispose.
    _nimController.dispose();
    _kataSandiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk / Verifikasi Akun'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                // TODO 5: Tentukan pesan jika NIM null/kosong/spasi saja.
                if (value == null || value.trim().isEmpty) {
                  return 'NIM wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kataSandiController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata sandi',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                // TODO 6: Tentukan aturan minimum kata sandi untuk akun uji.
                if (value == null || value.trim().isEmpty) {
                  return 'Kata sandi wajib diisi.';
                }
                if (value.trim().length < 6) {
                  return 'Kata sandi minimal 6 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _kirimForm,
              child: const Text('Kirim'),
            ),
            if (_inputLolosValidasi) ...[
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Rute.peminjamanSaya,
                ),
                child: const Text('Lanjut ke Peminjaman Saya (simulasi)'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HalamanPeminjamanSaya extends StatelessWidget {
  const HalamanPeminjamanSaya({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peminjaman Saya'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contoh tampilan peminjaman aktif (data belum terhubung).'),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Rute.riwayatPeminjaman,
              ),
              child: const Text('Lihat Riwayat Peminjaman'),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanRiwayatPeminjaman extends StatelessWidget {
  const HalamanRiwayatPeminjaman({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Riwayat peminjaman contoh belum terhubung dengan database.'),
      ),
    );
  }
}
