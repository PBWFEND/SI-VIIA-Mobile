import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// --- 1. MODEL DATA ---
class Reservasi {
  final String id;
  final String namaPeminjam;
  final String nim;
  final String judulBuku;
  final String status;

  Reservasi({
    required this.id,
    required this.namaPeminjam,
    required this.nim,
    required this.judulBuku,
    required this.status,
  });

  @override
  String toString() {
    return 'Reservasi(id: $id, nama: $namaPeminjam, buku: $judulBuku, status: $status)';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Reservasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanDaftarReservasi(),
    );
  }
}

// --- 2. LAYAR UTAMA (STATEFUL WIDGET) ---
class HalamanDaftarReservasi extends StatefulWidget {
  const HalamanDaftarReservasi({super.key});

  @override
  State<HalamanDaftarReservasi> createState() => _HalamanDaftarReservasiState();
}

class _HalamanDaftarReservasiState extends State<HalamanDaftarReservasi> {
  // State data lokal
  final List<Reservasi> _daftarReservasi = [];

  // Controller untuk form
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _bukuController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _bukuController.dispose();
    super.dispose();
  }

  // --- OPERASI CREATE & UPDATE (FORM DIALOG) ---
  void _tampilkanFormDialog({Reservasi? reservasiLama}) {
    final isUpdate = reservasiLama != null;
    final formKey = GlobalKey<FormState>();

    if (isUpdate) {
      _namaController.text = reservasiLama.namaPeminjam;
      _nimController.text = reservasiLama.nim;
      _bukuController.text = reservasiLama.judulBuku;
    } else {
      _namaController.clear();
      _nimController.clear();
      _bukuController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isUpdate ? 'Edit Reservasi' : 'Tambah Reservasi'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama Peminjam'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: _nimController,
                    decoration: const InputDecoration(labelText: 'NIM'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: _bukuController,
                    decoration: const InputDecoration(labelText: 'Judul Buku'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    if (isUpdate) {
                      // UPDATE berdasarkan ID
                      final index = _daftarReservasi.indexWhere((r) => r.id == reservasiLama.id);
                      if (index != -1) {
                        _daftarReservasi[index] = Reservasi(
                          id: reservasiLama.id,
                          namaPeminjam: _namaController.text,
                          nim: _nimController.text,
                          judulBuku: _bukuController.text,
                          status: reservasiLama.status, // Status dipertahankan
                        );
                      }
                    } else {
                      // CREATE dengan ID unik
                      _daftarReservasi.add(Reservasi(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        namaPeminjam: _namaController.text,
                        nim: _nimController.text,
                        judulBuku: _bukuController.text,
                        status: 'Menunggu',
                      ));
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            )
          ],
        );
      },
    );
  }

  // --- OPERASI DELETE (KONFIRMASI DIALOG) ---
  void _konfirmasiHapus(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Apakah Anda yakin ingin menghapus reservasi ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  // DELETE berdasarkan ID
                  _daftarReservasi.removeWhere((r) => r.id == id);
                });
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            )
          ],
        );
      },
    );
  }

  // --- OPERASI UPDATE CEPAT (STATUS) ---
  void _ubahStatus(String id) {
    setState(() {
      final index = _daftarReservasi.indexWhere((r) => r.id == id);
      if (index != -1) {
        final dataLama = _daftarReservasi[index];
        _daftarReservasi[index] = Reservasi(
          id: dataLama.id,
          namaPeminjam: dataLama.namaPeminjam,
          nim: dataLama.nim,
          judulBuku: dataLama.judulBuku,
          status: dataLama.status == 'Menunggu' ? 'Dipinjam' : 'Dikembalikan',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Reservasi (CRUD)'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      // --- OPERASI READ ---
      body: _daftarReservasi.isEmpty
          ? const Center(child: Text('Belum ada data reservasi.'))
          : ListView.builder(
              itemCount: _daftarReservasi.length,
              itemBuilder: (context, index) {
                final data = _daftarReservasi[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(data.judulBuku, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${data.namaPeminjam} (${data.nim})\nStatus: ${data.status}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                          onPressed: () => _ubahStatus(data.id),
                          tooltip: 'Ubah Status',
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _tampilkanFormDialog(reservasiLama: data),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _konfirmasiHapus(data.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _tampilkanFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}