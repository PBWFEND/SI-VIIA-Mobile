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
      // 1. Pendaftaran Peta Route
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
        '/detail': (context) => const HalamanDetail(),
        '/form': (context) => const HalamanFormJadwal(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// LAYAR 1: HALAMAN UTAMA (Daftar Jadwal)
// ==========================================
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    
    // Kode sudah diakali dengan spasi agar tidak terpotong saat dicopy
    final List< Map<String, String> > daftarKegiatan = [
      {'nama': 'Rapat BPH Mingguan', 'waktu': '10:00 WIB', 'lokasi': 'Ruang Sekre', 'status': 'Segera'},
      {'nama': 'Kunjungan Studi', 'waktu': '09:00 WIB', 'lokasi': 'Luar Kota', 'status': 'Selesai'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kegiatan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: tema.primaryContainer,
        foregroundColor: tema.onPrimaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/form'),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: daftarKegiatan.length,
        itemBuilder: (context, index) {
          final kegiatan = daftarKegiatan[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.event)),
              title: Text(kegiatan['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${kegiatan['waktu']} • ${kegiatan['lokasi']}'),
              onTap: () => Navigator.pushNamed(context, '/detail', arguments: kegiatan),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kamera scan belum diimplementasikan (Pertemuan 6)')),
          );
        },
        backgroundColor: tema.primary,
        foregroundColor: tema.onPrimary,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Scan Absen'),
      ),
    );
  }
}

// ==========================================
// LAYAR 2: HALAMAN DETAIL (Menerima Arguments)
// ==========================================
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    // Kode sudah diakali dengan spasi agar tidak terpotong
    final kegiatan = args is Map< String, String > ? args : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kegiatan'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: kegiatan == null
          ? const Center(child: Text('Data kegiatan tidak tersedia.')) 
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(kegiatan['nama']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Waktu'),
                    subtitle: Text(kegiatan['waktu']!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Lokasi'),
                    subtitle: Text(kegiatan['lokasi']!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Status'),
                    subtitle: Text(kegiatan['status']!),
                  ),
                ],
              ),
            ),
    );
  }
}

// ==========================================
// LAYAR 3: HALAMAN FORM (StatefulWidget & Validasi)
// ==========================================
class HalamanFormJadwal extends StatefulWidget {
  const HalamanFormJadwal({super.key});

  @override
  State<HalamanFormJadwal> createState() => _HalamanFormJadwalState();
}

class _HalamanFormJadwalState extends State<HalamanFormJadwal> {
  // Kode sudah diakali dengan spasi agar tidak terpotong
  final _formKey = GlobalKey< FormState >();
  final _namaController = TextEditingController();
  final _lokasiController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  void _kirim() {
    if (!_formKey.currentState!.validate()) {
      return; 
    }
    
    final nama = _namaController.text.trim();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Jadwal "$nama" berhasil ditambahkan (simulasi).')),
    );
    Navigator.pop(context);
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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama kegiatan wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(labelText: 'Lokasi', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lokasi wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _kirim,
              child: const Text('Kirim Pengajuan'),
            ),
          ],
        ),
      ),
    );
  }
}