import 'package:flutter/material.dart';

import 'service-api.dart';

void main() => runApp(const SiLaporApiApp());

class Rute {
  static const String daftar = '/';
  static const String form = '/form';
}

class SiLaporApiApp extends StatelessWidget {
  const SiLaporApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiLapor Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: Rute.daftar,
      routes: {
        Rute.daftar: (context) => const HalamanDaftarApi(),
        Rute.form: (context) => const HalamanFormApi(),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Halaman daftar: GET. Tiga kondisi dikelola dengan flag pada State.
// ---------------------------------------------------------------------------
class HalamanDaftarApi extends StatefulWidget {
  const HalamanDaftarApi({super.key});

  @override
  State<HalamanDaftarApi> createState() => _HalamanDaftarApiState();
}

class _HalamanDaftarApiState extends State<HalamanDaftarApi> {
  bool _memuat = true;
  String? _pesanError;
  List<Laporan> _daftar = [];

  @override
  void initState() {
    super.initState();
    _muat();
  }

  Future<void> _muat() async {
    setState(() {
      _memuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await LaporanService.ambilDaftar();
      if (!mounted) return;
      setState(() {
        _daftar = hasil;
        _memuat = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.pesan;
        _memuat = false;
      });
    }
  }

  Future<void> _bukaForm() async {
    final hasil = await Navigator.pushNamed(context, Rute.form);
    if (!mounted) return;
    if (hasil is Laporan) {
      // Server contoh (JSONPlaceholder) tidak menyimpan data, jadi daftar tidak
      // dimuat ulang. Laporan balasan server ditambahkan ke daftar. Dengan
      // backend sungguhan, cukup panggil _muat().
      setState(() {
        _daftar.insert(0, hasil);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan "${hasil.judul}" terkirim ke server.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SiLapor Kampus')),
      body: _bangunKonten(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        icon: const Icon(Icons.add),
        label: const Text('Buat Laporan'),
      ),
    );
  }

  Widget _bangunKonten() {
    // Kondisi 1: loading
    if (_memuat) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat laporan...'),
          ],
        ),
      );
    }

    // Kondisi 2: error, dengan tombol Coba Lagi
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off,
                size: 56,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                'Laporan gagal dimuat',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(_pesanError!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _muat,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // Data kosong
    if (_daftar.isEmpty) {
      return const Center(child: Text('Belum ada laporan di server.'));
    }

    // Kondisi 3: sukses
    return RefreshIndicator(
      onRefresh: _muat,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
        itemCount: _daftar.length,
        itemBuilder: (context, index) => _KartuLaporan(_daftar[index]),
      ),
    );
  }
}

class _KartuLaporan extends StatelessWidget {
  const _KartuLaporan(this.laporan);

  final Laporan laporan;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.report_problem_outlined, color: warna.primary),
        title: Text(
          laporan.judul,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: teks.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          laporan.deskripsi,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
        ),
        trailing: Chip(
          label: Text(laporan.status),
          backgroundColor: warna.tertiaryContainer,
          side: BorderSide.none,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Halaman form: POST. StatefulWidget agar controller bisa di-dispose dan
// status pengiriman (_mengirim) bisa disimpan.
// ---------------------------------------------------------------------------
class HalamanFormApi extends StatefulWidget {
  const HalamanFormApi({super.key});

  @override
  State<HalamanFormApi> createState() => _HalamanFormApiState();
}

class _HalamanFormApiState extends State<HalamanFormApi> {
  static const List<String> _daftarKategori = [
    'Proyektor',
    'AC',
    'Keran',
    'Kursi',
  ];

  final _formKey = GlobalKey<FormState>();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _kategori;
  bool _mengirim = false;

  @override
  void dispose() {
    _lokasiController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  // Urutan: validasi -> tombol nonaktif -> POST -> kembali (sukses) atau
  // pesan error dan tombol aktif lagi (gagal).
  Future<void> _kirim() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _mengirim = true);

    try {
      final hasil = await LaporanService.kirim(
        LaporanBaru(
          kategori: _kategori!,
          lokasi: _lokasiController.text.trim(),
          deskripsi: _deskripsiController.text.trim(),
        ),
      );
      if (!mounted) return;
      Navigator.pop(context, hasil);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _mengirim = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan gagal dikirim. ${e.pesan}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _lokasiController,
              enabled: !_mengirim,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                hintText: 'Contoh: Gedung B, R. 204',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lokasi wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih kategori'),
              items: _daftarKategori
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: _mengirim ? null : (v) => _kategori = v,
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              enabled: !_mengirim,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan kerusakan singkat',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Deskripsi wajib diisi.';
                }
                if (value.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            // Tombol nonaktif (onPressed null) selama request berjalan, agar
            // laporan tidak terkirim ganda karena penekanan berulang.
            FilledButton(
              onPressed: _mengirim ? null : _kirim,
              child: _mengirim
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 12),
                        Text('Mengirim...'),
                      ],
                    )
                  : const Text('Kirim laporan'),
            ),
          ],
        ),
      ),
    );
  }
}
