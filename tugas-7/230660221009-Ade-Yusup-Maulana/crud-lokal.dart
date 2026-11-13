import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPenjualanWarung());
}

class AplikasiPenjualanWarung extends StatelessWidget {
  const AplikasiPenjualanWarung({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penjualan Warung',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const DaftarProdukPage(),
    );
  }
}

// ============================================================
// MODEL DATA
// ============================================================

class Produk {
  final String id;
  final String nama;
  final int harga;
  final int stok;
  final String status;

  const Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.status,
  });

  @override
  String toString() {
    return '$nama - Rp$harga - Stok: $stok - $status';
  }
}

// ============================================================
// HALAMAN DAFTAR / READ
// ============================================================

class DaftarProdukPage extends StatefulWidget {
  const DaftarProdukPage({super.key});

  @override
  State<DaftarProdukPage> createState() => _DaftarProdukPageState();
}

class _DaftarProdukPageState extends State<DaftarProdukPage> {
  // Data lokal disimpan di State
  final List<Produk> _produk = [];

  // Membuat ID unik untuk setiap produk
  String _buatId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  // Menentukan status berdasarkan stok
  String _tentukanStatus(int stok) {
    return stok > 0 ? 'Tersedia' : 'Habis';
  }

  // ============================================================
  // CREATE
  // ============================================================

  Future<void> _tambahProduk() async {
    final hasil = await _formProduk();

    if (hasil == null) {
      return;
    }

    setState(() {
      _produk.add(
        Produk(
          id: _buatId(),
          nama: hasil['nama'] as String,
          harga: hasil['harga'] as int,
          stok: hasil['stok'] as int,
          status: _tentukanStatus(hasil['stok'] as int),
        ),
      );
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil ditambahkan'),
      ),
    );
  }

  // ============================================================
  // UPDATE
  // ============================================================

  Future<void> _ubahProduk(Produk produk) async {
    final hasil = await _formProduk(
      produk: produk,
    );

    if (hasil == null) {
      return;
    }

    // Mencari data berdasarkan ID
    final index = _produk.indexWhere(
      (item) => item.id == produk.id,
    );

    if (index == -1) {
      return;
    }

    // Mengganti data lama dengan data baru
    setState(() {
      _produk[index] = Produk(
        id: produk.id,
        nama: hasil['nama'] as String,
        harga: hasil['harga'] as int,
        stok: hasil['stok'] as int,
        status: _tentukanStatus(hasil['stok'] as int),
      );
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil diperbarui'),
      ),
    );
  }

  // ============================================================
  // DELETE
  // ============================================================

  Future<void> _hapusProduk(Produk produk) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Produk'),
          content: Text(
            'Apakah Anda yakin ingin menghapus produk '
            '"${produk.nama}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (konfirmasi != true) {
      return;
    }

    setState(() {
      _produk.removeWhere(
        (item) => item.id == produk.id,
      );
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil dihapus'),
      ),
    );
  }

  // ============================================================
  // FORM TAMBAH / EDIT
  // ============================================================

  Future<Map<String, dynamic>?> _formProduk({
    Produk? produk,
  }) async {
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return FormProdukDialog(
          produk: produk,
        );
      },
    );
  }

  // ============================================================
  // FORMAT RUPIAH
  // ============================================================

  String _formatRupiah(int angka) {
    final teks = angka.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) {
        buffer.write('.');
      }

      buffer.write(teks[i]);
    }

    return 'Rp$buffer';
  }

  // ============================================================
  // TAMPILAN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Produk Warung'),
      ),

      body: _produk.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data produk.\n'
                'Tekan tombol + untuk menambahkan produk.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _produk.length,
              itemBuilder: (context, index) {
                final produk = _produk[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: ListTile(
                    title: Text(
                      produk.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${_formatRupiah(produk.harga)}\n'
                      'Stok: ${produk.stok} • ${produk.status}',
                    ),

                    isThreeLine: true,

                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _ubahProduk(produk);
                        } else if (value == 'hapus') {
                          _hapusProduk(produk);
                        }
                      },

                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'hapus',
                          child: Text('Hapus'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _tambahProduk,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================
// FORM PRODUK
// ============================================================

class FormProdukDialog extends StatefulWidget {
  final Produk? produk;

  const FormProdukDialog({
    super.key,
    this.produk,
  });

  @override
  State<FormProdukDialog> createState() =>
      _FormProdukDialogState();
}

class _FormProdukDialogState
    extends State<FormProdukDialog> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController _namaController;
  late final TextEditingController _hargaController;
  late final TextEditingController _stokController;

  @override
  void initState() {
    super.initState();

    _namaController = TextEditingController(
      text: widget.produk?.nama ?? '',
    );

    _hargaController = TextEditingController(
      text: widget.produk?.harga.toString() ?? '',
    );

    _stokController = TextEditingController(
      text: widget.produk?.stok.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool modeEdit = widget.produk != null;

    return AlertDialog(
      title: Text(
        modeEdit ? 'Edit Produk' : 'Tambah Produk',
      ),

      content: Form(
        key: _formKey,

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NAMA PRODUK
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama produk wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              // HARGA
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Harga',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Harga wajib diisi';
                  }

                  final harga = int.tryParse(
                    value
                        .replaceAll('.', '')
                        .replaceAll(',', ''),
                  );

                  if (harga == null || harga <= 0) {
                    return 'Harga harus lebih dari 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              // STOK
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Stok wajib diisi';
                  }

                  final stok = int.tryParse(value);

                  if (stok == null || stok < 0) {
                    return 'Stok harus 0 atau lebih';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),

      // TOMBOL
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),

        FilledButton(
          onPressed: () {
            // Validasi form
            if (!_formKey.currentState!.validate()) {
              return;
            }

            final harga = int.parse(
              _hargaController.text
                  .replaceAll('.', '')
                  .replaceAll(',', ''),
            );

            final stok = int.parse(
              _stokController.text,
            );

            // Mengembalikan data ke halaman utama
            Navigator.of(context).pop(
              {
                'nama': _namaController.text.trim(),
                'harga': harga,
                'stok': stok,
              },
            );
          },

          child: Text(
            modeEdit ? 'Update' : 'Simpan',
          ),
        ),
      ],
    );
  }
}