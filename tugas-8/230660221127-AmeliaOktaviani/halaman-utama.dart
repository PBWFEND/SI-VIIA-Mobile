
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiWarungApp());
}

class AplikasiWarungApp extends StatelessWidget {
  const AplikasiWarungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penjualan Warung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const DashboardWarungPage(),
    );
  }
}

// Model data barang.
class Barang {
  final String nama;
  final String kategori;
  final int harga;
  final int stok;

  const Barang({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.stok,
  });
}

class DashboardWarungPage extends StatelessWidget {
  const DashboardWarungPage({super.key});

  // Data contoh untuk prototipe.
  static const List<Barang> daftarBarang = [
    Barang(
      nama: 'Minyak Goreng 1L',
      kategori: 'Sembako',
      harga: 16000,
      stok: 12,
    ),
    Barang(
      nama: 'Beras Premium 5kg',
      kategori: 'Sembako',
      harga: 68000,
      stok: 3,
    ),
    Barang(
      nama: 'Mie Instan Goreng',
      kategori: 'Makanan',
      harga: 3100,
      stok: 0,
    ),
    Barang(
      nama: 'Kopi Instant Sachet',
      kategori: 'Minuman',
      harga: 1500,
      stok: 25,
    ),
  ];

  // Format angka menjadi Rupiah.
  String formatRupiah(int angka) {
    final teks = angka.toString();
    final hasil = StringBuffer();

    for (int i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) {
        hasil.write('.');
      }
      hasil.write(teks[i]);
    }

    return 'Rp ${hasil.toString()}';
  }

  // Status stok berdasarkan jumlah barang.
  String statusStok(int stok) {
    if (stok == 0) {
      return 'Habis';
    } else if (stok <= 3) {
      return 'Stok Menipis';
    }
    return 'Tersedia';
  }

  // Warna status mengikuti ColorScheme aplikasi.
  Color warnaStatus(BuildContext context, int stok) {
    final warna = Theme.of(context).colorScheme;

    if (stok == 0) {
      return warna.errorContainer;
    } else if (stok <= 3) {
      return warna.tertiaryContainer;
    }
    return warna.secondaryContainer;
  }

  Color warnaTeksStatus(BuildContext context, int stok) {
    final warna = Theme.of(context).colorScheme;

    if (stok == 0) {
      return warna.onErrorContainer;
    } else if (stok <= 3) {
      return warna.onTertiaryContainer;
    }
    return warna.onSecondaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Warung'),
        backgroundColor: warna.surface,
      ),

      body: Center(
        // Membatasi lebar di layar besar, tetap responsif di layar kecil.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stok Barang Warung',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Pantau jumlah dan kondisi stok barang.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),

                // Daftar barang atau empty state.
                Expanded(
                  child: daftarBarang.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 56,
                                color: warna.onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Belum ada data barang',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Barang yang ditambahkan akan tampil di sini.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: daftarBarang.length,
                          itemBuilder: (context, index) {
                            final barang = daftarBarang[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: warna.primaryContainer,
                                  child: Icon(
                                    Icons.inventory_2_outlined,
                                    color: warna.onPrimaryContainer,
                                  ),
                                ),
                                title: Text(
                                  barang.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(barang.kategori),
                                      Text(formatRupiah(barang.harga)),
                                      Text('Stok: ${barang.stok}'),
                                      const SizedBox(height: 6),

                                      // Label status stok.
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warnaStatus(
                                            context,
                                            barang.stok,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          statusStok(barang.stok),
                                          style: TextStyle(
                                            color: warnaTeksStatus(
                                              context,
                                              barang.stok,
                                            ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
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
        ),
      ),

      // Aksi utama dengan umpan balik saat ditekan.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Prototipe: halaman transaksi belum dihubungkan.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Tambah Transaksi'),
      ),
    );
  }
}
