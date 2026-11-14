import 'package:flutter/material.dart';

void main() {
  runApp(const KantinKampusApp());
}

class KantinKampusApp extends StatelessWidget {
  const KantinKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus Mobile',
      theme: ThemeData(
        // Tema Material 3 dengan seed color Orange
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HalamanKatalogUtama(),
    );
  }
}

class HalamanKatalogUtama extends StatefulWidget {
  const HalamanKatalogUtama({super.key});

  @override
  State<HalamanKatalogUtama> createState() => _HalamanKatalogUtamaState();
}

class _HalamanKatalogUtamaState extends State<HalamanKatalogUtama> {
  // Data statis katalog menu (Ubah daftar ini menjadi [] untuk menguji Keadaan Kosong)
  final List<Map<String, dynamic>> daftarMenu = [
    {
      'id': 'M-01',
      'nama': 'Nasi Goreng Spesial',
      'kategori': 'Makanan Utama',
      'harga': 'Rp 15.000',
      'isTersedia': true,
    },
    {
      'id': 'M-02',
      'nama': 'Ayam Geprek Sambal Matah',
      'kategori': 'Makanan Utama',
      'harga': 'Rp 18.000',
      'isTersedia': true,
    },
    {
      'id': 'M-03',
      'nama': 'Es Teh Manis Jumbo',
      'kategori': 'Minuman',
      'harga': 'Rp 5.000',
      'isTersedia': true,
    },
    {
      'id': 'M-04',
      'nama': 'Jus Alpukat Kocok',
      'kategori': 'Minuman',
      'harga': 'Rp 10.000',
      'isTersedia': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kantin Teknik — Katalog Menu'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Menyimulasikan reload / reset keadaan
            },
          ),
        ],
      ),
      body: daftarMenu.isEmpty
          // Keadaan Kosong (Empty State)
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 72,
                      color: colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum Ada Menu Tersedia',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Stand kantin sedang tutup atau menu hari ini belum diunggah.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Daftar Menu Utama (ListView.builder)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              itemCount: daftarMenu.length,
              itemBuilder: (context, index) {
                final item = daftarMenu[index];
                final bool isTersedia = item['isTersedia'] as bool;

                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: isTersedia
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceContainerHighest,
                      child: Icon(
                        item['kategori'] == 'Minuman'
                            ? Icons.local_drink
                            : Icons.fastfood,
                        color: isTersedia
                            ? colorScheme.primary
                            : colorScheme.outline,
                      ),
                    ),
                    title: Text(
                      item['nama'].toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item['kategori']} • ${item['harga']}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        // Ternary untuk warna background status berdasarkan tema
                        color: isTersedia
                            ? colorScheme.tertiaryContainer
                            : colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        isTersedia ? 'Tersedia' : 'Habis',
                        style: theme.textTheme.labelSmall?.copyWith(
                          // Ternary untuk warna teks status berdasarkan tema
                          color: isTersedia
                              ? colorScheme.onTertiaryContainer
                              : colorScheme.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      // Aksi Utama: FloatingActionButton.extended
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aksi Pemesanan Cepat Dipilih (Navigasi P6)'),
            ),
          );
        },
        icon: const Icon(Icons.shopping_bag),
        label: const Text('Buat Pesanan'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }
}