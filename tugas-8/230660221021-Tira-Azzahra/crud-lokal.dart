import 'package:flutter/material.dart';

void main() {
  runApp(const AppPerpustakaanKampus());
}

class AppPerpustakaanKampus extends StatelessWidget {
  const AppPerpustakaanKampus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus — UTS Tira Azzahra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HalamanUtamaPeminjaman(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. MODEL DATA (Immutable Class)
// -----------------------------------------------------------------------------
class TransaksiPinjam {
  final String id;
  final String nim;
  final String namaMahasiswa;
  final String judulBuku;
  final int durasiHari;
  final String status; // 'Dipinjam', 'Dikembalikan'

  const TransaksiPinjam({
    required this.id,
    required this.nim,
    required this.namaMahasiswa,
    required this.judulBuku,
    required this.durasiHari,
    required this.status,
  });

  TransaksiPinjam copyWith({
    String? id,
    String? nim,
    String? namaMahasiswa,
    String? judulBuku,
    int? durasiHari,
    String? status,
  }) {
    return TransaksiPinjam(
      id: id ?? this.id,
      nim: nim ?? this.nim,
      namaMahasiswa: namaMahasiswa ?? this.namaMahasiswa,
      judulBuku: judulBuku ?? this.judulBuku,
      durasiHari: durasiHari ?? this.durasiHari,
      status: status ?? this.status,
    );
  }
}

// -----------------------------------------------------------------------------
// 2. HALAMAN UTAMA (StatefulWidget untuk Pengelolaan CRUD)
// -----------------------------------------------------------------------------
class HalamanUtamaPeminjaman extends StatefulWidget {
  const HalamanUtamaPeminjaman({super.key});

  @override
  State<HalamanUtamaPeminjaman> createState() => _HalamanUtamaPeminjamanState();
}

class _HalamanUtamaPeminjamanState extends State<HalamanUtamaPeminjaman> {
  // State In-Memory List
  final List<TransaksiPinjam> _daftarPinjam = [
    const TransaksiPinjam(
      id: 'TRX-001',
      nim: '230660221021',
      namaMahasiswa: 'Tira Azzahra',
      judulBuku: 'Pemrograman Mobile dengan Flutter',
      durasiHari: 7,
      status: 'Dipinjam',
    ),
    const TransaksiPinjam(
      id: 'TRX-002',
      nim: '230660221021',
      namaMahasiswa: 'Tira Azzahra',
      judulBuku: 'Analisis dan Perancangan Sistem Informasi',
      durasiHari: 14,
      status: 'Dikembalikan',
    ),
    const TransaksiPinjam(
      id: 'TRX-003',
      nim: '230660221099',
      namaMahasiswa: 'Ahmad Rizki',
      judulBuku: 'Basis Data Lanjut',
      durasiHari: 3,
      status: 'Dipinjam',
    ),
  ];

  String _searchQuery = '';

  // --- OPERASI CRUD --- //

  // CREATE
  void _tambahTransaksi(TransaksiPinjam baru) {
    setState(() {
      _daftarPinjam.add(baru);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Peminjaman "${baru.judulBuku}" berhasil diajukan.')),
    );
  }

  // UPDATE
  void _updateTransaksi(TransaksiPinjam diperbarui) {
    setState(() {
      final index = _daftarPinjam.indexWhere((item) => item.id == diperbarui.id);
      if (index != -1) {
        _daftarPinjam[index] = diperbarui;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Peminjaman ${diperbarui.id} berhasil diperbarui.')),
    );
  }

  // DELETE
  void _hapusTransaksi(String id) {
    final deletedItem = _daftarPinjam.firstWhere((item) => item.id == id);
    setState(() {
      _daftarPinjam.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaksi ${deletedItem.id} ("${deletedItem.judulBuku}") dihapus.')),
    );
  }

  // DIALOG CONFIRM DELETE
  void _konfirmasiHapus(BuildContext context, TransaksiPinjam item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data peminjaman buku "${item.judulBuku}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              _hapusTransaksi(item.id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // DIALOG FORM (CREATE & UPDATE)
  void _bukaFormDialog(BuildContext context, {TransaksiPinjam? editItem}) {
    final isEdit = editItem != null;
    final nimCtrl = TextEditingController(text: isEdit ? editItem.nim : '230660221021');
    final namaCtrl = TextEditingController(text: isEdit ? editItem.namaMahasiswa : 'Tira Azzahra');
    final judulCtrl = TextEditingController(text: isEdit ? editItem.judulBuku : '');
    final durasiCtrl = TextEditingController(text: isEdit ? editItem.durasiHari.toString() : '7');
    String statusVal = isEdit ? editItem.status : 'Dipinjam';

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Peminjaman Buku' : 'Form Ajukan Peminjaman'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nimCtrl,
                  decoration: const InputDecoration(
                    labelText: 'NIM Mahasiswa',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final val = v?.trim() ?? '';
                    if (val.isEmpty) return 'NIM wajib diisi.';
                    if (val.length < 8) return 'NIM minimal 8 digit.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama Mahasiswa',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Nama wajib diisi.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: judulCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Judul Buku Perpustakaan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Judul buku wajib diisi.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: durasiCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Durasi Pinjam (Hari)',
                    hintText: 'Contoh: 7',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final val = v?.trim() ?? '';
                    if (val.isEmpty) return 'Durasi wajib diisi.';
                    final num = int.tryParse(val);
                    if (num == null) return 'Durasi harus berupa angka.';
                    if (num < 1 || num > 14) return 'Durasi harus 1–14 hari.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: statusVal,
                  decoration: const InputDecoration(
                    labelText: 'Status Transaksi',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Dipinjam', child: Text('Dipinjam')),
                    DropdownMenuItem(value: 'Dikembalikan', child: Text('Dikembalikan')),
                  ],
                  onChanged: (val) {
                    if (val != null) statusVal = val;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (isEdit) {
                  _updateTransaksi(editItem.copyWith(
                    nim: nimCtrl.text.trim(),
                    namaMahasiswa: namaCtrl.text.trim(),
                    judulBuku: judulCtrl.text.trim(),
                    durasiHari: int.parse(durasiCtrl.text.trim()),
                    status: statusVal,
                  ));
                } else {
                  final newId = 'TRX-00${_daftarPinjam.length + 1}';
                  _tambahTransaksi(TransaksiPinjam(
                    id: newId,
                    nim: nimCtrl.text.trim(),
                    namaMahasiswa: namaCtrl.text.trim(),
                    judulBuku: judulCtrl.text.trim(),
                    durasiHari: int.parse(durasiCtrl.text.trim()),
                    status: statusVal,
                  ));
                }
                Navigator.pop(ctx);
              }
            },
            child: Text(isEdit ? 'Simpan' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FILTER PENCARIAN (READ)
    final filteredList = _daftarPinjam.where((item) {
      final q = _searchQuery.toLowerCase();
      return item.judulBuku.toLowerCase().contains(q) ||
          item.namaMahasiswa.toLowerCase().contains(q) ||
          item.nim.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus — SI-VIIA'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaFormDialog(context),
        icon: const Icon(Icons.add_location_alt_outlined),
        label: const Text('Pinjam Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // BAR PENCARIAN
            TextField(
              decoration: const InputDecoration(
                hintText: 'Cari judul buku, nama, atau NIM...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
            const SizedBox(height: 16),

            // DAFTAR TRANSAKSI
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                      child: Text(
                        'Tidak ada data peminjaman buku.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        final isDipinjam = item.status == 'Dipinjam';

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.shade100,
                              child: Text(
                                item.id.replaceAll('TRX-00', ''),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              item.judulBuku,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Peminjam: ${item.namaMahasiswa} (${item.nim})\nDurasi: ${item.durasiHari} Hari',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Chip(
                                  label: Text(
                                    item.status,
                                    style: TextStyle(
                                      color: isDipinjam ? Colors.orange.shade900 : Colors.green.shade900,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: isDipinjam ? Colors.orange.shade100 : Colors.green.shade100,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  tooltip: 'Edit Peminjaman',
                                  onPressed: () => _bukaFormDialog(context, editItem: item),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  tooltip: 'Hapus Transaksi',
                                  onPressed: () => _konfirmasiHapus(context, item),
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
    );
  }
}