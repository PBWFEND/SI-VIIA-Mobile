import 'package:flutter/material.dart';
import 'service-api.dart';

void main() {
  runApp(const AplikasiPerpustakaanApi());
}

class AplikasiPerpustakaanApi extends StatelessWidget {
  const AplikasiPerpustakaanApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus — REST API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        useMaterial3: true,
      ),
      home: const HalamanKatalogApi(),
    );
  }
}

class HalamanKatalogApi extends StatefulWidget {
  const HalamanKatalogApi({super.key});

  @override
  State<HalamanKatalogApi> createState() => _HalamanKatalogApiState();
}

class _HalamanKatalogApiState extends State<HalamanKatalogApi> {
  final PerpustakaanApiService _service = PerpustakaanApiService();

  // Tiga state utama antarmuka jaringan
  bool _sedangMemuat = true;
  String? _pesanError;
  List<BukuApi> _daftarBuku = [];

  // State form pengiriman POST & mode simulasi error
  bool _sedangMengirim = false;
  bool _modeSimulasiError = false;

  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  String _kategoriDipilih = 'Sistem Informasi';
  String _statusDipilih = 'Tersedia';

  @override
  void initState() {
    super.initState();
    _muatKatalogBuku();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    super.dispose();
  }

  /// Memanggil GET dari lapisan service dan memperbarui state UI
  Future<void> _muatKatalogBuku() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await _service.ambilDaftarBuku(simulasiError: _modeSimulasiError);
      if (!mounted) return;
      setState(() {
        _daftarBuku = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.toString().replaceAll('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  /// Memanggil POST dari lapisan service dengan tombol terkunci saat proses berjalan
  Future<void> _simpanBukuBaru(StateSetter setModalState) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _sedangMengirim = true);
    setModalState(() => _sedangMengirim = true);

    final bukuBaru = BukuApi(
      id: 0,
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      kategori: _kategoriDipilih,
      status: _statusDipilih,
    );

    try {
      final bukuTersimpan = await _service.kirimBukuBaru(bukuBaru);
      if (!mounted) return;

      setState(() {
        _daftarBuku.insert(0, bukuTersimpan);
        _sedangMengirim = false;
      });

      _judulController.clear();
      _penulisController.clear();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menambahkan "${bukuTersimpan.judul}" ke server.'),
          backgroundColor: Colors.green.shade700,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _sedangMengirim = false);
      setModalState(() => _sedangMengirim = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  /// Menampilkan form modal bottom sheet untuk metode POST
  void _bukaFormTambahBuku() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: !_sedangMengirim,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tambah Koleksi Buku (POST)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _sedangMengirim ? null : () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _judulController,
                    enabled: !_sedangMengirim,
                    decoration: const InputDecoration(
                      labelText: 'Judul Buku',
                      prefixIcon: Icon(Icons.book),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.trim().isEmpty ? 'Judul buku wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _penulisController,
                    enabled: !_sedangMengirim,
                    decoration: const InputDecoration(
                      labelText: 'Nama Penulis',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.trim().isEmpty ? 'Nama penulis wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _kategoriDipilih,
                    decoration: const InputDecoration(
                      labelText: 'Kategori Buku',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Sistem Informasi', child: Text('Sistem Informasi')),
                      DropdownMenuItem(value: 'Informatika', child: Text('Informatika')),
                      DropdownMenuItem(value: 'Psikologi', child: Text('Psikologi')),
                      DropdownMenuItem(value: 'Metodologi', child: Text('Metodologi')),
                    ],
                    onChanged: _sedangMengirim
                        ? null
                        : (val) => setModalState(() => _kategoriDipilih = val!),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _statusDipilih,
                    decoration: const InputDecoration(
                      labelText: 'Status Ketersediaan',
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Tersedia', child: Text('Tersedia')),
                      DropdownMenuItem(value: 'Sedang Dipinjam', child: Text('Sedang Dipinjam')),
                    ],
                    onChanged: _sedangMengirim
                        ? null
                        : (val) => setModalState(() => _statusDipilih = val!),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700),
                      // Tombol kirim dinonaktifkan selama proses pengiriman (_sedangMengirim)
                      onPressed: _sedangMengirim ? null : () => _simpanBukuBaru(setModalState),
                      child: _sedangMengirim
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text('Mengirim Data...'),
                              ],
                            )
                          : const Text(
                              'KIRIM DATA BUKU',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perpustakaan Kampus API',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _modeSimulasiError ? 'Kembalikan URL Normal' : 'Simulasikan URL Error',
            icon: Icon(_modeSimulasiError ? Icons.link_off : Icons.link),
            onPressed: () {
              setState(() => _modeSimulasiError = !_modeSimulasiError);
              _muatKatalogBuku();
            },
          ),
          IconButton(
            tooltip: 'Muat Ulang Data',
            icon: const Icon(Icons.refresh),
            onPressed: _muatKatalogBuku,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                Icon(Icons.cloud_done, size: 36, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nisa Rahmawati (230660221023) — SI-VIIA',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        _modeSimulasiError
                            ? 'Endpoint: Simulasi URL Salah (Pengujian Error)'
                            : 'Endpoint: jsonplaceholder.typicode.com/posts',
                        style: TextStyle(
                          fontSize: 12,
                          color: _modeSimulasiError ? Colors.red.shade700 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _bangunKontenUtama()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sedangMemuat ? null : _bukaFormTambahBuku,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
      ),
    );
  }

  /// Mengelola tampilan tiga state: Loading, Error, dan Sukses
  Widget _bangunKontenUtama() {
    // 1. State Loading
    if (_sedangMemuat) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue.shade700),
            const SizedBox(height: 16),
            const Text(
              'Mengambil katalog buku dari server...',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    // 2. State Error + Tombol Coba Lagi
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text(
                'Gagal Memuat Katalog Buku',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red.shade700, fontSize: 13),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700),
                onPressed: _muatKatalogBuku,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. State Data Kosong
    if (_daftarBuku.isEmpty) {
      return const Center(child: Text('Belum ada koleksi buku pada server.'));
    }

    // 4. State Sukses (ListView.builder)
    return RefreshIndicator(
      onRefresh: _muatKatalogBuku,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _daftarBuku.length,
        itemBuilder: (context, index) {
          final buku = _daftarBuku[index];
          final isTersedia = buku.status == 'Tersedia';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isTersedia ? Colors.blue.shade100 : Colors.grey.shade300,
                child: Icon(
                  Icons.book,
                  color: isTersedia ? Colors.blue.shade700 : Colors.grey.shade700,
                ),
              ),
              title: Text(
                buku.judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Penulis: ${buku.penulis}\nKategori: ${buku.kategori} | Status: ${buku.status}',
              ),
              isThreeLine: true,
              trailing: Chip(
                label: Text(
                  'ID #${buku.id}',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade800),
                ),
                backgroundColor: Colors.blue.shade50,
                side: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }
}