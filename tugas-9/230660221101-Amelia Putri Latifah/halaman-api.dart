import 'package:flutter/material.dart';
import 'service-api.dart';

class HalamanUtamaApi extends StatefulWidget {
  const HalamanUtamaApi({super.key});

  @override
  State<HalamanUtamaApi> createState() => _HalamanUtamaApiState();
}

class _HalamanUtamaApiState extends State<HalamanUtamaApi> {
  bool _sedangMemuat = false;
  String? _pesanError;
  List<DataKegiatan> _daftarKegiatan = [];

  @override
  void initState() {
    super.initState();
    _muatDataKegiatan();
  }

  /// HTTP GET: Mengambil data awal dari API dan mengelola 3 state UI
  Future<void> _muatDataKegiatan() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await KegiatanApiService.ambilDaftarKegiatan();
      if (!mounted) return;
      setState(() {
        _daftarKegiatan = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.toString().replaceFirst('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  /// Update status lokal pada tampilan daftar
  void _ubahStatus(String id) {
    setState(() {
      final index = _daftarKegiatan.indexWhere((k) => k.id == id);
      if (index != -1) {
        final lama = _daftarKegiatan[index];
        _daftarKegiatan[index] = lama.copyWith(
          status: lama.status == 'Segera' ? 'Selesai' : 'Segera',
        );
      }
    });
  }

  /// Menghapus jadwal dari daftar tampilan setelah konfirmasi
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
        _daftarKegiatan.removeWhere((k) => k.id == kegiatan.id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kegiatan "${kegiatan.nama}" dibatalkan.')),
        );
      }
    }
  }

  /// Navigasi ke halaman form untuk mengirim data via HTTP POST
  Future<void> _bukaHalamanForm() async {
    final DataKegiatan? kegiatanBaru = await Navigator.push<DataKegiatan>(
      context,
      MaterialPageRoute(builder: (context) => const HalamanFormJadwalApi()),
    );

    if (kegiatanBaru != null && mounted) {
      setState(() {
        _daftarKegiatan.insert(0, kegiatanBaru);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Jadwal "${kegiatanBaru.nama}" berhasil dikirim ke API (ID: ${kegiatanBaru.id}).'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: tema.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang Data API',
            onPressed: _sedangMemuat ? null : _muatDataKegiatan,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Buat Jadwal Baru',
            onPressed: _bukaHalamanForm,
          ),
        ],
      ),
      body: _bangunKonten(tema),
    );
  }

  Widget _bangunKonten(ColorScheme tema) {
    // 1. State Loading
    if (_sedangMemuat) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat jadwal kegiatan dari server...'),
          ],
        ),
      );
    }

    // 2. State Error + Tombol Retry
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 54, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _muatDataKegiatan,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. State Data Kosong
    if (_daftarKegiatan.isEmpty) {
      return const Center(child: Text('Belum ada jadwal kegiatan.'));
    }

    // 4. State Sukses
    return RefreshIndicator(
      onRefresh: _muatDataKegiatan,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _daftarKegiatan.length,
        itemBuilder: (context, index) {
          final kegiatan = _daftarKegiatan[index];
          final isSelesai = kegiatan.status == 'Selesai';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    isSelesai ? Colors.green[100] : tema.primaryContainer,
                child: Icon(
                  Icons.event,
                  color: isSelesai ? Colors.green : tema.primary,
                ),
              ),
              title: Text(
                kegiatan.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${kegiatan.waktu} • ${kegiatan.lokasi}\nStatus: ${kegiatan.status}',
              ),
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

/// Halaman Form — Mengirim Data Jadwal Baru lewat HTTP POST
class HalamanFormJadwalApi extends StatefulWidget {
  const HalamanFormJadwalApi({super.key});

  @override
  State<HalamanFormJadwalApi> createState() => _HalamanFormJadwalApiState();
}

class _HalamanFormJadwalApiState extends State<HalamanFormJadwalApi> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _waktuController = TextEditingController();
  final _lokasiController = TextEditingController();
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _namaController.dispose();
    _waktuController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  Future<void> _simpanKegiatan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _sedangMengirim = true;
    });

    try {
      final kegiatanBaru = await KegiatanApiService.tambahKegiatanBaru(
        nama: _namaController.text.trim(),
        waktu: _waktuController.text.trim(),
        lokasi: _lokasiController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context, kegiatanBaru);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMengirim = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              decoration: const InputDecoration(
                labelText: 'Nama Kegiatan',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _waktuController,
              decoration: const InputDecoration(
                labelText: 'Waktu (Mis. 10:00 WIB)',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _sedangMengirim ? null : _simpanKegiatan,
              child: Text(
                _sedangMengirim ? 'Mengirim ke Server...' : 'Simpan Jadwal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}