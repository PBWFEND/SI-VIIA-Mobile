import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Data Lokal',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HalamanDaftarItem(),
    );
  }
}

// 1. Model Data
class DataBuku {
  final String id;
  final String judul;
  final String penulis;
  final String status;

  const DataBuku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.status,
  });

  @override
  String toString() => '$judul — $penulis ($status)';
}

// 2. StatefulWidget
class HalamanDaftarItem extends StatefulWidget {
  const HalamanDaftarItem({super.key});

  @override
  State<HalamanDaftarItem> createState() => _HalamanDaftarItemState();
}

class _HalamanDaftarItemState extends State<HalamanDaftarItem> {
  final List<DataBuku> _daftar = [];
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();

  // Create
  void _tambahData() {
    if (_judulController.text.trim().isEmpty || _penulisController.text.trim().isEmpty) return;
    
    setState(() {
      _daftar.add(DataBuku(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: _judulController.text.trim(),
        penulis: _penulisController.text.trim(),
        status: 'Tersedia',
      ));
    });

    _judulController.clear();
    _penulisController.clear();
    Navigator.pop(context);
  }

  // Update
  void _ubahStatus(String id) {
    setState(() {
      final index = _daftar.indexWhere((item) => item.id == id);
      if (index != -1) {
        final lama = _daftar[index];
        _daftar[index] = DataBuku(
          id: lama.id,
          judul: lama.judul,
          penulis: lama.penulis,
          status: lama.status == 'Tersedia' ? 'Dipinjam' : 'Tersedia',
        );
      }
    });
  }

  // Delete
  void _hapusData(String id) {
    setState(() {
      _daftar.removeWhere((item) => item.id == id);
    });
  }

  // Dialog Konfirmasi Hapus
  void _konfirmasiHapus(DataBuku item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus "${item.judul}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _hapusData(item.id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // Dialog Form Tambah
  void _bukaFormTambah() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16, left: 16, right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _judulController, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: _penulisController, decoration: const InputDecoration(labelText: 'Penulis')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _tambahData, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Data Lokal')),
      body: _daftar.isEmpty
          ? const Center(child: Text('Belum ada data'))
          : ListView.builder(
              itemCount: _daftar.length,
              itemBuilder: (context, index) {
                final item = _daftar[index];
                return ListTile(
                  title: Text(item.judul),
                  subtitle: Text('${item.penulis} • ${item.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => _ubahStatus(item.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _konfirmasiHapus(item),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}