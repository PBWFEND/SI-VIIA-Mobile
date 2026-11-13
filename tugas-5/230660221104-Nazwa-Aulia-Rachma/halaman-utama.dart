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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8BBF88)),
        useMaterial3: true,
      ),
      home: const LayarUtama(),
    );
  }
}

class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

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

  Color _warnaStatus(String status, ColorScheme warna) {
    return status == 'Tersedia'
        ? warna.primary
        : status == 'Terbatas'
            ? warna.tertiary
            : warna.error;
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              child: SizedBox(
                width: 300,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buku tersedia',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '${daftarBuku.length} buku',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 34),
            Text(
              'Daftar Buku',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: daftarBuku.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.menu_book_outlined, size: 64, color: warna.outline),
                          const SizedBox(height: 12),
                          const Text('Belum ada buku yang tersedia.'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarBuku.length,
                      itemBuilder: (context, index) {
                        final buku = daftarBuku[index];
                        final status = buku['status']!;
                        final warnaStatus = _warnaStatus(status, warna);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 10,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: warna.primaryContainer,
                              foregroundColor: warna.onPrimaryContainer,
                              child: const Icon(Icons.menu_book_rounded),
                            ),
                            title: Text(
                              buku['judul']!,
                              style: const TextStyle(fontSize: 22),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '${buku['penulis']} • ${buku['kategori']} • Rak ${buku['rak']}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            trailing: Text(
                              status,
                              style: TextStyle(
                                color: warnaStatus,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kolom pencarian siap digunakan.')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Cari buku'),
      ),
    );
  }
}
