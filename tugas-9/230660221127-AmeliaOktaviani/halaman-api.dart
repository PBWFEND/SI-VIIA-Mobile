
import 'package:flutter/material.dart';

import 'service-api.dart';

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final ProdukApiService service = ProdukApiService();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController hargaController =
      TextEditingController();

  final TextEditingController stokController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<ProdukApi> daftarProduk = [];

  bool loading = true;
  bool sedangMengirim = false;

  String pesanError = '';

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  // GET: Mengambil data produk dari API
  Future<void> ambilData() async {
    if (!mounted) return;

    setState(() {
      loading = true;
      pesanError = '';
    });

    try {
      final data = await service.getProduk();

      if (!mounted) return;

      setState(() {
        daftarProduk = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString().replaceFirst('Exception: ', '');
        loading = false;
      });
    }
  }

  // POST: Mengirim produk ke API
  Future<void> kirimData() async {
    if (sedangMengirim) return;

    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      sedangMengirim = true;
    });

    try {
      final produkBaru = ProdukApi(
        id: 0,
        nama: namaController.text.trim(),
        harga: double.parse(hargaController.text.trim()),
        stok: int.parse(stokController.text.trim()),
        kategori: 'Kebutuhan Warung',
      );

      final hasil = await service.tambahProduk(produkBaru);

      if (!mounted) return;

      setState(() {
        daftarProduk.insert(0, hasil);
      });

      namaController.clear();
      hargaController.clear();
      stokController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil dikirim ke API'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengirim data: '
            '${e.toString().replaceFirst('Exception: ', '')}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          sedangMengirim = false;
        });
      }
    }
  }

  // Tampilan loading
  Widget tampilLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Tampilan error
  Widget tampilError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            const Text(
              'Gagal mengambil data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pesanError,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: ambilData,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan daftar produk
  Widget tampilDaftarProduk() {
    if (daftarProduk.isEmpty) {
      return const Center(
        child: Text('Belum ada data produk.'),
      );
    }

    return RefreshIndicator(
      onRefresh: ambilData,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          final produk = daftarProduk[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(produk.nama),
              subtitle: Text(
                'Kategori: ${produk.kategori}\n'
                'Stok: ${produk.stok}',
              ),
              trailing: Text(
                'Rp ${produk.harga.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Form tambah produk
  Widget tampilForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: namaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                prefixIcon: Icon(Icons.shopping_bag_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama produk harus diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: hargaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Harga Produk',
                prefixIcon: Icon(Icons.payments_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Harga harus diisi';
                }

                final harga = double.tryParse(value.trim());

                if (harga == null || !harga.isFinite) {
                  return 'Harga harus berupa angka';
                }

                if (harga <= 0) {
                  return 'Harga harus lebih dari 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok Produk',
                prefixIcon: Icon(Icons.inventory_2_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Stok harus diisi';
                }

                final stok = int.tryParse(value.trim());

                if (stok == null) {
                  return 'Stok harus berupa bilangan bulat';
                }

                if (stok < 0) {
                  return 'Stok tidak boleh negatif';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sedangMengirim ? null : kirimData,
                child: sedangMengirim
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Kirim Produk'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrasi REST API'),
        actions: [
          IconButton(
            onPressed: loading ? null : ambilData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang data',
          ),
        ],
      ),
      body: loading
          ? tampilLoading()
          : pesanError.isNotEmpty
              ? tampilError()
              : Column(
                  children: [
                    Expanded(
                      child: tampilDaftarProduk(),
                    ),
                    const Divider(height: 1),
                    tampilForm(),
                  ],
                ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.dispose();
  }
}
