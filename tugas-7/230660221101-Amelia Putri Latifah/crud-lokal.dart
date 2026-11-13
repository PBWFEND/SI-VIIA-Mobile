import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAbsensi());
}

class AplikasiAbsensi extends StatelessWidget {
  const AplikasiAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PresenGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
        '/form': (context) => const HalamanFormJadwal(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// MODEL DATA (Mendefinisikan Entitas)
// ==========================================
class DataKegiatan {
  const DataKegiatan({
    required this.id,
    required this.nama,
    required this.waktu,
    required this.lokasi,
    required this.status,
  });

  final String id;
  final String nama;
  final String waktu;
  final String lokasi;
  final String status;

  @override
  String toString() => 'Kegiatan: $nama ($waktu di $lokasi)';
}

// ==========================================
// STATE & CRUD (Menyimpan dan Mengelola Data)
// ==========================================
// Karena kita belum menggunakan state management kompleks, 
// list statis global dipakai untuk mempermudah akses antar route di Tugas 7 ini.
final List<DataKegiatan> _databaseLokal = [
  DataKegiatan(
      id: '1',
      nama: 'Rapat BPH Mingguan',
      waktu: '10:00 WIB',
      lokasi: 'Ruang Sekre',
      status: 'Segera'),
];

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // Update Data (Mengubah Status)
  void _ubahStatus(String id) {
    setState(() {
      final index = _databaseLokal.indexWhere((k) => k.id == id);
      if (index != -1) {
        final lama = _databaseLokal[index];
        _databaseLokal[index] = DataKegiatan(
          id: lama.id,
          nama: lama.nama,
          waktu: lama.waktu,
          lokasi: lama.lokasi,
          status: lama.status == 'Segera' ? 'Selesai' : 'Segera',
        );
      }
    });
  }

  // Delete Data (Menghapus Kegiatan dengan Konfirmasi)
  Future<void> _hapusKegiatan(DataKegiatan kegiatan) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan Kegiatan?'),
        content: Text('Jadwal "${kegiatan.nama}" akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (yakin == true) {
      setState(() {
        _databaseLokal.removeWhere((k) => k.id == kegiatan.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kegiatan "${kegiatan.nama}" dibatalkan.')),
        );
      }
    }
  }

  // Read Data (Menampilkan ListView)
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kegiatan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: tema.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Menunggu hasil kembali dari form lalu trigger setState
              await Navigator.pushNamed(context, '/form');
              setState(() {});
            },
          )
        ],
      ),
      body: _databaseLokal.isEmpty
          ? const Center(child: Text('Belum ada jadwal kegiatan.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _databaseLokal.length,
              itemBuilder: (context, index) {
                final kegiatan = _databaseLokal[index];
                final isSelesai = kegiatan.status == 'Selesai';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelesai ? Colors.green[100] : tema.primaryContainer,
                      child: Icon(Icons.event, color: isSelesai ? Colors.green : tema.primary),
                    ),
                    title: Text(kegiatan.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${kegiatan.waktu} • ${kegiatan.lokasi}\nStatus: ${kegiatan.status}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle_outline),
                          tooltip: 'Ubah Status',
                          onPressed: () => _ubahStatus(kegiatan.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          tooltip: 'Hapus Kegiatan',
                          onPressed: () => _hapusKegiatan(kegiatan),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ==========================================
// HALAMAN FORM (Create Data)
// ==========================================
class HalamanFormJadwal extends StatefulWidget {
  const HalamanFormJadwal({super.key});

  @override
  State<HalamanFormJadwal> createState() => _HalamanFormJadwalState();
}

class _HalamanFormJadwalState extends State<HalamanFormJadwal> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _waktuController = TextEditingController();
  final _lokasiController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _waktuController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  void _simpanKegiatan() {
    if (!_formKey.currentState!.validate()) return;

    // Create Data (Menambah objek baru)
    final kegiatanBaru = DataKegiatan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: _namaController.text.trim(),
      waktu: _waktuController.text.trim(),
      lokasi: _lokasiController.text.trim(),
      status: 'Segera',
    );

    _databaseLokal.add(kegiatanBaru);
    Navigator.pop(context); // Kembali ke beranda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Jadwal Baru')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Kegiatan', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _waktuController,
              decoration: const InputDecoration(labelText: 'Waktu (Mis. 10:00 WIB)', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(labelText: 'Lokasi', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _simpanKegiatan,
              child: const Text('Simpan Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}