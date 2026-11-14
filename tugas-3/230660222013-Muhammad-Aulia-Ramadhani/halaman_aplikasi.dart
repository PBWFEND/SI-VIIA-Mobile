
import 'package:flutter/material.dart';

//bantuan: ChatGPT - membantu memahai struktur widget 

void main() {
  runApp(const KantinKampusApp());
}

class KantinKampusApp extends StatelessWidget {
  const KantinKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KantinKampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const HalamanAplikasi(),
    );
  }
}

class HalamanAplikasi extends StatelessWidget {
  const HalamanAplikasi({super.key});

  // Data statis menu kantin
  final List<Map<String, dynamic>> daftarMenu = const [
    {
      'nama': 'Nasi Goreng',
      'kategori': 'Makanan',
      'harga': 15000,
      'ikon': Icons.rice_bowl,
      'warna': Colors.orange,
      'tersedia': true,
    },
    {
      'nama': 'Mie Ayam',
      'kategori': 'Makanan',
      'harga': 12000,
      'ikon': Icons.ramen_dining,
      'warna': Colors.red,
      'tersedia': true,
    },
    {
      'nama': 'Es Teh Manis',
      'kategori': 'Minuman',
      'harga': 5000,
      'ikon': Icons.local_cafe,
      'warna': Colors.brown,
      'tersedia': true,
    },
    {
      'nama': 'Jus Alpukat',
      'kategori': 'Minuman',
      'harga': 10000,
      'ikon': Icons.local_drink,
      'warna': Colors.green,
      'tersedia': false,
    },
  ];

  String formatRupiah(int harga) {
    return 'Rp${harga.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KantinKampus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // COLUMN: informasi utama
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Temukan menu favoritmu di kantin kampus.',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ROW: ringkasan menu
          Row(
            children: [
              Expanded(
                child: _infoCard(
                  'Total Menu',
                  '${daftarMenu.length} menu',
                  Icons.restaurant_menu,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(
                  'Tersedia',
                  '${daftarMenu.where((m) => m['tersedia'] == true).length} menu',
                  Icons.check_circle_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Daftar Menu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // LISTVIEW: menampilkan data menu
          ...daftarMenu.map((menu) {
            final bool tersedia = menu['tersedia'] as bool;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (menu['warna'] as Color)
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        menu['ikon'] as IconData,
                        size: 32,
                        color: menu['warna'] as Color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu['nama'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(menu['kategori'] as String),
                          const SizedBox(height: 4),
                          Text(
                            formatRupiah(menu['harga'] as int),
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Icon(
                          tersedia
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: tersedia ? Colors.green : Colors.red,
                        ),
                        Text(
                          tersedia ? 'Tersedia' : 'Habis',
                          style: TextStyle(
                            fontSize: 11,
                            color: tersedia ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _infoCard(String judul, String nilai, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: Colors.green, size: 28),
          const SizedBox(height: 8),
          Text(judul),
          Text(
            nilai,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
