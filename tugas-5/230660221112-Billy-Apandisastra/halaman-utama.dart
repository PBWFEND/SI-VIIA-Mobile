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
      // Implementasi ThemeData Material 3 dengan warna benih (seed color)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, // Warna dasar aplikasi
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HalamanKatalog(),
    );
  }
}

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final warnaTema = Theme.of(context).colorScheme;
    
    // Ubah menjadi [] (list kosong) untuk menguji tampilan empty state
    final daftarBuku = [
      {'judul': 'Pemrograman Flutter Dasar', 'kategori': 'Teknologi', 'status': 'Tersedia'},
      {'judul': 'Algoritma dan Struktur Data', 'kategori': 'Teknologi', 'status': 'Dipinjam'},
      {'judul': 'Pengantar Sistem Informasi', 'kategori': 'Teknologi', 'status': 'Tersedia'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku'),
        backgroundColor: warnaTema.primaryContainer,
        foregroundColor: warnaTema.onPrimaryContainer,
      ),
      // Logika Keadaan Kosong (Empty State)
      body: daftarBuku.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.library_books_outlined, size: 80, color: warnaTema.outline),
                  const SizedBox(height: 16),
                  Text(
                    'Katalog belum tersedia',
                    style: TextStyle(fontSize: 18, color: warnaTema.onSurfaceVariant),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = daftarBuku[index];
                final ketersediaan = buku['status'] == 'Tersedia';

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: warnaTema.secondaryContainer,
                      child: Icon(Icons.book, color: warnaTema.onSecondaryContainer),
                    ),
                    title: Text(
                      buku['judul']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(buku['kategori']!),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        // Logika Ternary untuk warna status
                        color: ketersediaan ? warnaTema.primary : warnaTema.error,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        buku['status']!,
                        style: TextStyle(
                          color: ketersediaan ? warnaTema.onPrimary : warnaTema.onError,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      // Aksi utama menggunakan FAB Extended
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aksi kosong (navigasi di tugas selanjutnya)
        },
        icon: const Icon(Icons.search),
        label: const Text('Cari Spesifik'),
      ),
    );
  }
}