import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPerpustakaanKampus());
}

// 1. MODEL DATA
class Buku {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final String status;

  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
  });

  // Method copyWith untuk operasi Update (penggantian objek)
  Buku copyWith({
    String? id,
    String? judul,
    String? penulis,
    String? kategori,
    String? status,
  }) {
    return Buku(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      penulis: penulis ?? this.penulis,
      kategori: kategori ?? this.kategori,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Buku(id: $id, judul: $judul, penulis: $penulis, status: $status)';
  }
}

// 2. APLIKASI UTAMA
class AplikasiPerpustakaanKampus extends StatelessWidget {
  const AplikasiPerpustakaanKampus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HalamanKatalogBuku(),
    );
  }
}

// 3. LAYAR UTAMA (STATEFUL WIDGET MENYIMPAN STATE LIST)
class HalamanKatalogBuku extends StatefulWidget {
  const HalamanKatalogBuku({super.key});

  @override
  State<HalamanKatalogBuku> createState() => _HalamanKatalogBukuState();
}

class _HalamanKatalogBukuState extends State<HalamanKatalogBuku> {
  // State: List data in-memory (termasuk buku Jogiyanto HM)
  final List<Buku> _katalogBuku = [
    const Buku(
      id: '1700000000000',
      judul: 'Analisis dan Perancangan Sistem Informasi',
      penulis: 'Jogiyanto HM',
      kategori: 'Sistem Informasi',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000001',
      judul: 'Object-Oriented Programming in C++',
      penulis: 'Robert Lafore',
      kategori: 'Informatika',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000002',
      judul: 'Pengantar Psikologi Umum',
      penulis: 'S. S. Santoso',
      kategori: 'Psikologi',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000003',
      judul: 'Metode Penelitian Kualitatif',
      penulis: 'Lexy J. Moleong',
      kategori: 'Metodologi',
      status: 'Sedang Dipinjam',
    ),
    const Buku(
      id: '1700000000004',
      judul: 'Dasar Sistem Informasi',
      penulis: 'Andi Wijaya',
      kategori: 'Sistem Informasi',
      status: 'Tersedia',
    ),
  ];

  // Controller Form
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  String _selectedKategori = 'Sistem Informasi';
  String _selectedStatus = 'Tersedia';

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    super.dispose();
  }

  // --- OPERASI CRUD LOKAL ---

  // CREATE / ADD
  void _tambahData() {
    if (!_formKey.currentState!.validate()) return;

    final idBaru = DateTime.now().millisecondsSinceEpoch.toString();
    final dataBaru = Buku(
      id: idBaru,
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      kategori: _selectedKategori,
      status: _selectedStatus,
    );

    setState(() {
      _katalogBuku.insert(0, dataBaru);
    });

    _resetForm();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buku baru berhasil ditambahkan ke katalog!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // UPDATE / EDIT
  void _ubahData(String id) {
    if (!_formKey.currentState!.validate()) return;

    final index = _katalogBuku.indexWhere((item) => item.id == id);
    if (index != -1) {
      final dataLama = _katalogBuku[index];
      final dataDiperbarui = dataLama.copyWith(
        judul: _judulController.text.trim(),
        penulis: _penulisController.text.trim(),
        kategori: _selectedKategori,
        status: _selectedStatus,
      );

      setState(() {
        _katalogBuku[index] = dataDiperbarui;
      });

      _resetForm();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data buku berhasil diperbarui!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  // DELETE WITH CONFIRMATION
  void _konfirmasiHapus(Buku item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus buku "${item.judul}" dari katalog?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _katalogBuku.removeWhere((e) => e.id == item.id);
              });
              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Buku "${item.judul}" berhasil dihapus.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Reset Input Form
  void _resetForm() {
    _judulController.clear();
    _penulisController.clear();
    _selectedKategori = 'Sistem Informasi';
    _selectedStatus = 'Tersedia';
  }

  // Tampilkan Dialog Form (Tambah / Edit)
  void _tampilkanDialogForm({Buku? itemEdit}) {
    if (itemEdit != null) {
      _judulController.text = itemEdit.judul;
      _penulisController.text = itemEdit.penulis;
      _selectedKategori = itemEdit.kategori;
      _selectedStatus = itemEdit.status;
    } else {
      _resetForm();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemEdit == null ? 'Tambah Buku Baru' : 'Edit Data Buku',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _judulController,
                    decoration: const InputDecoration(
                      labelText: 'Judul Buku',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Judul buku wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _penulisController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Penulis',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Penulis wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedKategori,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Informatika', 'Psikologi', 'Metodologi', 'Sistem Informasi'].map((kat) {
                      return DropdownMenuItem(value: kat, child: Text(kat));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          _selectedKategori = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status Buku',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Tersedia', 'Sedang Dipinjam'].map((st) {
                      return DropdownMenuItem(value: st, child: Text(st));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          _selectedStatus = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (itemEdit == null) {
                          _tambahData();
                        } else {
                          _ubahData(itemEdit.id);
                        }
                      },
                      child: Text(itemEdit == null ? 'Simpan Buku' : 'Perbarui Buku'),
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

  // BUILD UI (READ)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: const Row(
              children: [
                Icon(Icons.menu_book, size: 36, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Mahasiswa!',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Pilih buku untuk melihat detailnya.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _katalogBuku.isEmpty
                ? const Center(child: Text('Katalog buku kosong.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _katalogBuku.length,
                    itemBuilder: (context, index) {
                      final item = _katalogBuku[index];
                      final isTersedia = item.status == 'Tersedia';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isTersedia ? Colors.blue.shade100 : Colors.grey.shade300,
                            child: Icon(
                              Icons.book,
                              color: isTersedia ? Colors.blue : Colors.grey,
                            ),
                          ),
                          title: Text(
                            item.judul,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${item.penulis}\nKategori: ${item.kategori} | Status: ${item.status}'),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _tampilkanDialogForm(itemEdit: item),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _konfirmasiHapus(item),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _tampilkanDialogForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
      ),
    );
  }
}