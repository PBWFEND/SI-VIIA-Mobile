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
      title: 'Aplikasi Perpustakaan',
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Data Statis: 5 entri data (Memenuhi syarat minimal 4 entri)
    final List> daftarBuku = [
      {'judul': 'Pemrograman Flutter Dasar', 'kategori': 'Teknologi', 'status': 'Tersedia'},
      {'judul': 'Algoritma dan Struktur Data', 'kategori': 'Teknologi', 'status': 'Dipinjam'},
      {'judul': 'Pengantar Sistem Informasi', 'kategori': 'Teknologi', 'status': 'Tersedia'},
      {'judul': 'Manajemen Proyek TI', 'kategori': 'Bisnis', 'status': 'Tersedia'},
      {'judul': 'Sejarah Perkembangan AI', 'kategori': 'Pengetahuan Umum', 'status': 'Dipinjam'},
    ];

    // 2. Struktur Dasar: Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Perpustakaan'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // Layout 1: Column (Menyusun elemen secara vertikal)
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layout 2: Padding (Memberikan jarak di sekeliling teks)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Buku Terkini',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Expanded mencegah error RenderFlex overflow pada ListView di dalam Column
          Expanded(
            // Layout 3: ListView.builder (Menampilkan daftar data yang bisa di-scroll)
            child: ListView.builder(
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = daftarBuku[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    // Layout 4: Row (Menyusun teks dan label status secara horizontal)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded di dalam Row mencegah judul panjang bertabrakan dengan label status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buku['judul'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                buku['kategori'] ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Label Status
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: buku['status'] == 'Tersedia' ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            buku['status'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}