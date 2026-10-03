import 'package:flutter/material.dart';

// Bantuan: ChatGPT — membantu memahami struktur widget
// MaterialApp, Scaffold, Column, Row, Padding, dan ListView.builder.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan Kampus',
      home: const HalamanPerpustakaan(),
    );
  }
}

class HalamanPerpustakaan extends StatelessWidget {
  const HalamanPerpustakaan({super.key});

  final List<Map<String, String>> daftarBuku = const [
    {
      'judul': 'Pemrograman Dart',
      'penulis': 'Budi Santoso',
      'kategori': 'Teknologi',
      'status': 'Tersedia',
    },
    {
      'judul': 'Dasar Sistem Informasi',
      'penulis': 'Andi Wijaya',
      'kategori': 'Sistem Informasi',
      'status': 'Tersedia',
    },
    {
      'judul': 'UI/UX Design',
      'penulis': 'Siti Rahma',
      'kategori': 'Desain',
      'status': 'Tersedia',
    },
    {
      'judul': 'Basis Data',
      'penulis': 'Dewi Lestari',
      'kategori': 'Teknologi',
      'status': 'Habis',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.library_books,
                  size: 40,
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Koleksi Buku',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${daftarBuku.length} buku tersedia',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = daftarBuku[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.book),
                      ),

                      title: Text(
                        buku['judul']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        '${buku['penulis']} • ${buku['kategori']}',
                      ),

                      trailing: Text(
                        buku['status']!,
                        style: TextStyle(
                          color: buku['status'] == 'Tersedia'
                              ? Colors.blue
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}