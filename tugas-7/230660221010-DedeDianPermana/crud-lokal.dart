
import 'package:flutter/material.dart';

class Peminjaman {
  final String id;
  final String namaRuangan;
  final String kategori;
  final String tanggal;
  final String waktu;
  final String tujuan;
  final String status;

  const Peminjaman({
    required this.id,
    required this.namaRuangan,
    required this.kategori,
    required this.tanggal,
    required this.waktu,
    required this.tujuan,
    required this.status,
  });

  @override
  String toString() {
    return 'Peminjaman(id: $id, ruangan: $namaRuangan, '
        'tanggal: $tanggal, status: $status)';
  }
}

void main() {
  runApp(const SiRuangKampusApp());
}

class SiRuangKampusApp extends StatelessWidget {
  const SiRuangKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRuang Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DaftarPeminjamanPage(),
    );
  }
}

class DaftarPeminjamanPage extends StatefulWidget {
  const DaftarPeminjamanPage({super.key});

  @override
  State<DaftarPeminjamanPage> createState() =>
      _DaftarPeminjamanPageState();
}

class _DaftarPeminjamanPageState extends State<DaftarPeminjamanPage> {
  final List<Peminjaman> daftarPeminjaman = [
    const Peminjaman(
      id: 'PMJ001',
      namaRuangan: 'Ruang 1',
      kategori: 'Ruang Kelas',
      tanggal: '10 November 2026',
      waktu: '09.00 - 11.00',
      tujuan: 'Diskusi tugas kelompok',
      status: 'Menunggu',
    ),
    const Peminjaman(
      id: 'PMJ002',
      namaRuangan: 'Ruang 2',
      kategori: 'Laboratorium',
      tanggal: '12 November 2026',
      waktu: '13.00 - 15.00',
      tujuan: 'Praktikum mahasiswa',
      status: 'Disetujui',
    ),
  ];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController waktuController = TextEditingController();
  final TextEditingController tujuanController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    kategoriController.dispose();
    tanggalController.dispose();
    waktuController.dispose();
    tujuanController.dispose();
    super.dispose();
  }

  void bersihkanForm() {
    namaController.clear();
    kategoriController.clear();
    tanggalController.clear();
    waktuController.clear();
    tujuanController.clear();
  }

  void tampilkanForm({Peminjaman? data}) {
    bersihkanForm();

    if (data != null) {
      namaController.text = data.namaRuangan;
      kategoriController.text = data.kategori;
      tanggalController.text = data.tanggal;
      waktuController.text = data.waktu;
      tujuanController.text = data.tujuan;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(data == null
              ? 'Tambah Peminjaman'
              : 'Edit Peminjaman'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration:
                      const InputDecoration(labelText: 'Nama Ruangan'),
                ),
                TextField(
                  controller: kategoriController,
                  decoration:
                      const InputDecoration(labelText: 'Kategori'),
                ),
                TextField(
                  controller: tanggalController,
                  decoration:
                      const InputDecoration(labelText: 'Tanggal'),
                ),
                TextField(
                  controller: waktuController,
                  decoration:
                      const InputDecoration(labelText: 'Waktu'),
                ),
                TextField(
                  controller: tujuanController,
                  decoration:
                      const InputDecoration(labelText: 'Tujuan'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (namaController.text.trim().isEmpty ||
                    kategoriController.text.trim().isEmpty ||
                    tanggalController.text.trim().isEmpty ||
                    waktuController.text.trim().isEmpty ||
                    tujuanController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Semua data harus diisi.'),
                    ),
                  );
                  return;
                }

                if (data == null) {
                  final peminjamanBaru = Peminjaman(
                    id: DateTime.now()
                        .microsecondsSinceEpoch
                        .toString(),
                    namaRuangan: namaController.text.trim(),
                    kategori: kategoriController.text.trim(),
                    tanggal: tanggalController.text.trim(),
                    waktu: waktuController.text.trim(),
                    tujuan: tujuanController.text.trim(),
                    status: 'Menunggu',
                  );

                  setState(() {
                    daftarPeminjaman.add(peminjamanBaru);
                  });
                } else {
                  final dataDiperbarui = Peminjaman(
                    id: data.id,
                    namaRuangan: namaController.text.trim(),
                    kategori: kategoriController.text.trim(),
                    tanggal: tanggalController.text.trim(),
                    waktu: waktuController.text.trim(),
                    tujuan: tujuanController.text.trim(),
                    status: data.status,
                  );

                  setState(() {
                    final index = daftarPeminjaman.indexWhere(
                      (item) => item.id == data.id,
                    );

                    if (index != -1) {
                      daftarPeminjaman[index] = dataDiperbarui;
                    }
                  });
                }

                Navigator.pop(dialogContext);
                bersihkanForm();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void konfirmasiHapus(String id) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus data peminjaman ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  daftarPeminjaman.removeWhere(
                    (item) => item.id == id,
                  );
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiRuang Kampus'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: daftarPeminjaman.isEmpty
          ? const Center(
              child: Text('Belum ada data peminjaman.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: daftarPeminjaman.length,
              itemBuilder: (context, index) {
                final data = daftarPeminjaman[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    key: ValueKey(data.id),
                    title: Text(
                      data.namaRuangan,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kategori: ${data.kategori}'),
                        Text('Tanggal: ${data.tanggal}'),
                        Text('Waktu: ${data.waktu}'),
                        Text('Tujuan: ${data.tujuan}'),
                        Text('Status: ${data.status}'),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (pilihan) {
                        if (pilihan == 'edit') {
                          tampilkanForm(data: data);
                        } else if (pilihan == 'hapus') {
                          konfirmasiHapus(data.id);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => tampilkanForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Peminjaman'),
      ),
    );
  }
}
