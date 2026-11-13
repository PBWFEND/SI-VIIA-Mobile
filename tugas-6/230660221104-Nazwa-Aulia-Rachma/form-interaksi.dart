import 'package:flutter/material.dart';

void main() {
  runApp(const PerpustakaanApp());
}

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF155E75)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BerandaLayar(),
        '/detail-buku': (context) => const DetailBukuLayar(),
        '/konfirmasi-peminjaman': (context) =>
            const KonfirmasiPeminjamanLayar(),
        '/pinjaman-aktif': (context) => const PinjamanAktifLayar(),
      },
    );
  }
}

class BerandaLayar extends StatelessWidget {
  const BerandaLayar({super.key});

  static const daftarBuku = [
    {
      'judul': 'Pemrograman Aplikasi Bergerak',
      'penulis': 'R. Kurniawan',
      'kategori': 'Teknologi',
      'status': 'Tersedia',
      'rak': 'A-12',
    },
    {
      'judul': 'Analisis dan Perancangan Sistem',
      'penulis': 'S. Pratama',
      'kategori': 'Sistem Informasi',
      'status': 'Terbatas',
      'rak': 'B-04',
    },
    {
      'judul': 'Dasar-Dasar Basis Data',
      'penulis': 'N. Wijaya',
      'kategori': 'Teknologi',
      'status': 'Tersedia',
      'rak': 'A-08',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda / Cari buku'),
        actions: [
          IconButton(
            tooltip: 'Pinjaman aktif',
            onPressed: () => Navigator.pushNamed(context, '/pinjaman-aktif'),
            icon: const Icon(Icons.bookmark_outline_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
        children: [
          Text(
            'Pilih buku untuk melihat detail dan mengajukan peminjaman.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 18),
          ...daftarBuku.map(
            (buku) => _KartuBuku(
              buku: buku,
              onTap: () => Navigator.pushNamed(
                context,
                '/detail-buku',
                arguments: buku,
              ),
              warna: warna,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/pinjaman-aktif'),
        icon: const Icon(Icons.bookmark_rounded),
        label: const Text('Pinjaman aktif'),
      ),
    );
  }
}

class _KartuBuku extends StatelessWidget {
  const _KartuBuku({
    required this.buku,
    required this.onTap,
    required this.warna,
  });

  final Map<String, String> buku;
  final VoidCallback onTap;
  final ColorScheme warna;

  @override
  Widget build(BuildContext context) {
    final status = buku['status']!;
    final warnaStatus = status == 'Tersedia'
        ? warna.primary
        : status == 'Terbatas'
            ? warna.tertiary
            : warna.error;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: warna.surfaceContainerHighest,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: warna.primaryContainer,
          foregroundColor: warna.onPrimaryContainer,
          child: const Icon(Icons.menu_book_rounded),
        ),
        title: Text(
          buku['judul']!,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('${buku['penulis']} • Rak ${buku['rak']}'),
        trailing: Chip(
          label: Text(
            status,
            style: TextStyle(color: warnaStatus, fontWeight: FontWeight.w700),
          ),
          backgroundColor: warnaStatus.withValues(alpha: 0.12),
          side: BorderSide.none,
        ),
      ),
    );
  }
}

class DetailBukuLayar extends StatelessWidget {
  const DetailBukuLayar({super.key});

  Map<String, String>? _bacaBuku(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, String>) {
      return arguments;
    }
    if (arguments is Map) {
      return Map<String, String>.from(arguments);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buku = _bacaBuku(context);
    final warna = Theme.of(context).colorScheme;

    if (buku == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail buku')),
        body: _DataKosong(
          pesan: 'Data buku tidak tersedia.',
          onBack: () => Navigator.pop(context),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail buku')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: warna.primaryContainer,
            foregroundColor: warna.onPrimaryContainer,
            child: const Icon(Icons.menu_book_rounded, size: 42),
          ),
          const SizedBox(height: 18),
          Text(
            buku['judul']!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text('Penulis: ${buku['penulis']}'),
          Text('Kategori: ${buku['kategori']}'),
          Text('Lokasi rak: ${buku['rak']}'),
          const SizedBox(height: 18),
          Card(
            elevation: 0,
            color: warna.surfaceContainerHighest,
            child: ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('Status ketersediaan'),
              subtitle: Text(buku['status']!),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: buku['status'] == 'Tersedia'
                ? () => Navigator.pushNamed(
                      context,
                      '/konfirmasi-peminjaman',
                      arguments: buku,
                    )
                : null,
            icon: const Icon(Icons.bookmark_add_outlined),
            label: Text(
              buku['status'] == 'Tersedia' ? 'Lanjutkan peminjaman' : 'Belum tersedia',
            ),
          ),
        ],
      ),
    );
  }
}

class KonfirmasiPeminjamanLayar extends StatefulWidget {
  const KonfirmasiPeminjamanLayar({super.key});

  @override
  State<KonfirmasiPeminjamanLayar> createState() =>
      _KonfirmasiPeminjamanLayarState();
}

class _KonfirmasiPeminjamanLayarState
    extends State<KonfirmasiPeminjamanLayar> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _catatanController = TextEditingController();
  String? _durasi;

  Map<String, String>? _bacaBuku(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, String>) {
      return arguments;
    }
    if (arguments is Map) {
      return Map<String, String>.from(arguments);
    }
    return null;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _kirimForm(Map<String, String>? buku) {
    if (buku == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data buku tidak tersedia.')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Peminjaman "${buku['judul']}" berhasil dikirim. Jatuh tempo: $_durasi hari.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buku = _bacaBuku(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi peminjaman')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              buku == null ? 'Buku tidak dipilih' : buku['judul']!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama peminjam',
                prefixIcon: Icon(Icons.person_outline_rounded),
                border: OutlineInputBorder(),
              ),
              validator: (nilai) {
                if (nilai == null || nilai.trim().length < 3) {
                  return 'Nama minimal 3 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _durasi,
              decoration: const InputDecoration(
                labelText: 'Durasi peminjaman',
                prefixIcon: Icon(Icons.event_available_outlined),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: '7', child: Text('7 hari')),
                DropdownMenuItem(value: '14', child: Text('14 hari')),
                DropdownMenuItem(value: '30', child: Text('30 hari')),
              ],
              onChanged: (nilai) => setState(() => _durasi = nilai),
              validator: (nilai) {
                if (nilai == null) {
                  return 'Pilih durasi peminjaman.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _catatanController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (nilai) {
                if (nilai != null && nilai.length > 120) {
                  return 'Catatan maksimal 120 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _kirimForm(buku),
              icon: const Icon(Icons.send_rounded),
              label: const Text('Kirim peminjaman'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke detail buku'),
            ),
          ],
        ),
      ),
    );
  }
}

class PinjamanAktifLayar extends StatelessWidget {
  const PinjamanAktifLayar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pinjaman aktif')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.menu_book_rounded),
              title: const Text('Pemrograman Aplikasi Bergerak'),
              subtitle: const Text('Jatuh tempo: 14 Juni 2026'),
              trailing: const Chip(label: Text('Aktif')),
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Kembali ke beranda'),
          ),
        ],
      ),
    );
  }
}

class _DataKosong extends StatelessWidget {
  const _DataKosong({required this.pesan, required this.onBack});

  final String pesan;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline_rounded, size: 58),
          const SizedBox(height: 12),
          Text(pesan),
          const SizedBox(height: 12),
          FilledButton(onPressed: onBack, child: const Text('Kembali')),
        ],
      ),
    );
  }
}

