
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiWarungApp());
}

// ===============================
// MODEL DATA BARANG
// ===============================
class Barang {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final int stok;
  final int batasStokMinimum;

  const Barang({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.stok,
    this.batasStokMinimum = 3,
  });

  @override
  String toString() {
    return 'Barang(id: $id, nama: $nama, kategori: $kategori, '
        'harga: $harga, stok: $stok)';
  }
}

// ===============================
// APLIKASI UTAMA
// ===============================
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

// ===============================
// HALAMAN DASHBOARD
// ===============================
class DashboardWarungPage extends StatefulWidget {
  const DashboardWarungPage({super.key});

  @override
  State<DashboardWarungPage> createState() =>
      _DashboardWarungPageState();
}

class _DashboardWarungPageState
    extends State<DashboardWarungPage> {

  // DATA BARANG SEMENTARA DI DALAM LIST
  final List<Barang> daftarBarang = [
    Barang(
      id: '1',
      nama: 'Minyak Goreng 1L',
      kategori: 'Sembako',
      harga: 16000,
      stok: 12,
    ),
    Barang(
      id: '2',
      nama: 'Beras Premium 5kg',
      kategori: 'Sembako',
      harga: 68000,
      stok: 3,
    ),
    Barang(
      id: '3',
      nama: 'Mie Instan Goreng',
      kategori: 'Makanan',
      harga: 3100,
      stok: 0,
    ),
    Barang(
      id: '4',
      nama: 'Kopi Instant Sachet',
      kategori: 'Minuman',
      harga: 1500,
      stok: 25,
    ),
  ];

  // FORMAT HARGA RUPIAH
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

  // STATUS STOK BARANG
  String statusStok(Barang barang) {
    if (barang.stok == 0) {
      return 'Habis';
    } else if (barang.stok <= barang.batasStokMinimum) {
      return 'Stok Menipis';
    }
    return 'Tersedia';
  }

  // TAMBAH DAN EDIT BARANG
  Future<void> tampilkanFormBarang({Barang? barang}) async {
    final hasil = await showDialog<Barang>(
      context: context,
      builder: (dialogContext) {
        return FormBarangDialog(barang: barang);
      },
    );

    if (!mounted || hasil == null) return;

    setState(() {
      if (barang == null) {
        // CREATE
        daftarBarang.add(hasil);
      } else {
        // UPDATE
        final index = daftarBarang.indexWhere(
          (item) => item.id == barang.id,
        );

        if (index != -1) {
          daftarBarang[index] = hasil;
        }
      }
    });
  }

  // DELETE BARANG
  Future<void> hapusBarang(Barang barang) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Barang?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus ${barang.nama}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (konfirmasi == true && mounted) {
      setState(() {
        daftarBarang.removeWhere(
          (item) => item.id == barang.id,
        );
      });
    }
  }

  // TAMPILAN DASHBOARD
  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Warung'),
        backgroundColor: warna.surface,
      ),
      body: Center(
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
                const Text(
                  'Kelola data dan pantau kondisi stok barang.',
                ),
                const SizedBox(height: 16),

                // READ: MENAMPILKAN DAFTAR BARANG
                Expanded(
                  child: daftarBarang.isEmpty
                      ? const Center(
                          child: Text('Belum ada data barang'),
                        )
                      : ListView.builder(
                          itemCount: daftarBarang.length,
                          itemBuilder: (context, index) {
                            final barang = daftarBarang[index];

                            final Color warnaStok =
                                barang.stok == 0
                                    ? warna.error
                                    : barang.stok <=
                                            barang.batasStokMinimum
                                        ? Colors.orange
                                        : Colors.green;

                            return Card(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      warna.primaryContainer,
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
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(barang.kategori),
                                      Text(
                                        formatRupiah(barang.harga),
                                      ),
                                      Text('Stok: ${barang.stok}'),
                                      const SizedBox(height: 5),
                                      Text(
                                        statusStok(barang),
                                        style: TextStyle(
                                          color: warnaStok,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // MENU EDIT DAN HAPUS
                                trailing: PopupMenuButton<String>(
                                  onSelected: (pilihan) {
                                    if (pilihan == 'edit') {
                                      tampilkanFormBarang(
                                        barang: barang,
                                      );
                                    } else if (pilihan == 'hapus') {
                                      hapusBarang(barang);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'hapus',
                                      child: Text('Hapus'),
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
          ),
        ),
      ),

      // TOMBOL TAMBAH BARANG
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          tampilkanFormBarang();
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}

// ===============================
// FORM TAMBAH DAN EDIT BARANG
// ===============================
class FormBarangDialog extends StatefulWidget {
  final Barang? barang;

  const FormBarangDialog({
    super.key,
    this.barang,
  });

  @override
  State<FormBarangDialog> createState() =>
      _FormBarangDialogState();
}

class _FormBarangDialogState extends State<FormBarangDialog> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController namaController;
  late final TextEditingController kategoriController;
  late final TextEditingController hargaController;
  late final TextEditingController stokController;

  @override
  void initState() {
    super.initState();

    final barang = widget.barang;

    namaController = TextEditingController(
      text: barang?.nama ?? '',
    );

    kategoriController = TextEditingController(
      text: barang?.kategori ?? '',
    );

    hargaController = TextEditingController(
      text: barang?.harga.toString() ?? '',
    );

    stokController = TextEditingController(
      text: barang?.stok.toString() ?? '',
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    kategoriController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  // MENYIMPAN DATA BARANG
  void simpanBarang() {
    if (!formKey.currentState!.validate()) return;

    final barangLama = widget.barang;

    final dataBaru = Barang(
      id: barangLama?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      nama: namaController.text.trim(),
      kategori: kategoriController.text.trim(),
      harga: int.parse(hargaController.text),
      stok: int.parse(stokController.text),
      batasStokMinimum:
          barangLama?.batasStokMinimum ?? 3,
    );

    Navigator.pop(context, dataBaru);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.barang == null ? 'Tambah Barang' : 'Edit Barang',
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama barang wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kategori wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                ),
                validator: (value) {
                  final angka = int.tryParse(value ?? '');
                  if (angka == null || angka <= 0) {
                    return 'Masukkan harga yang valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                ),
                validator: (value) {
                  final angka = int.tryParse(value ?? '');
                  if (angka == null || angka < 0) {
                    return 'Masukkan stok yang valid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: simpanBarang,
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
