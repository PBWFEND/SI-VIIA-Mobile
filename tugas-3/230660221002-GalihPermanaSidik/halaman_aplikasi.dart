import 'package:flutter/material.dart';

// Bantuan: Claude, menjelaskan penggunaan Expanded agar ListView di dalam Column tidak menghasilkan RenderFlex overflow.

void main() {
  runApp(const SiLaporApp());
}

class SiLaporApp extends StatelessWidget {
  const SiLaporApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiLapor Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HalamanLaporan(),
    );
  }
}

class HalamanLaporan extends StatefulWidget {
  const HalamanLaporan({super.key});

  @override
  State<HalamanLaporan> createState() => _HalamanLaporanState();
}

class _HalamanLaporanState extends State<HalamanLaporan> {
  // Data awal statis: 5 entri dengan kunci yang konsisten
  final List<Map<String, String>> daftarLaporan = [
    {'judul': 'Lampu mati', 'lokasi': 'Ruang 5B', 'status': 'Diproses'},
    {'judul': 'AC ruang kelas tidak dingin', 'lokasi': 'Ruang 6A', 'status': 'Menunggu'},
    {'judul': 'WiFi sering terputus', 'lokasi': 'Perpustakaan', 'status': 'Selesai'},
    {'judul': 'Keran wastafel bocor', 'lokasi': 'Toilet Putri', 'status': 'Diproses'},
    {'judul': 'Proyektor tidak menyala', 'lokasi': 'Ruang Lab 3', 'status': 'Menunggu'},
  ];

  int _hitung(String status) {
    return daftarLaporan.where((l) => l['status'] == status).length;
  }

  Widget _kartuRingkasan(String label, int jumlah) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text('$jumlah', style: const TextStyle(fontSize: 24)),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  IconData _ikon(String status) {
    switch (status) {
      case 'Selesai':
        return Icons.check_circle;
      case 'Diproses':
        return Icons.build_circle;
      default:
        return Icons.hourglass_top;
    }
  }

  void _tambahLaporan() {
    final judulCtrl = TextEditingController();
    final lokasiCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Laporan Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judulCtrl,
              decoration: const InputDecoration(labelText: 'Judul kerusakan'),
            ),
            TextField(
              controller: lokasiCtrl,
              decoration: const InputDecoration(labelText: 'Lokasi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              // Validasi sederhana: kedua kolom wajib diisi
              if (judulCtrl.text.trim().isEmpty ||
                  lokasiCtrl.text.trim().isEmpty) {
                return;
              }
              setState(() {
                daftarLaporan.insert(0, {
                  'judul': judulCtrl.text.trim(),
                  'lokasi': lokasiCtrl.text.trim(),
                  'status': 'Menunggu',
                });
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SiLapor Kampus'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Halo, ada kerusakan yang ingin dilaporkan?'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _kartuRingkasan('Menunggu', _hitung('Menunggu')),
                _kartuRingkasan('Diproses', _hitung('Diproses')),
                _kartuRingkasan('Selesai', _hitung('Selesai')),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text('Laporan terbaru'),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: daftarLaporan.length,
              itemBuilder: (context, index) {
                final laporan = daftarLaporan[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(_ikon(laporan['status']!)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(laporan['judul']!),
                              Text(laporan['lokasi']!),
                            ],
                          ),
                        ),
                        Text(laporan['status']!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahLaporan,
        tooltip: 'Tambah Laporan',
        child: const Icon(Icons.add),
      ),
    );
  }
}