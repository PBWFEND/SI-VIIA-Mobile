import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/foto_presensi_service.dart';

void main() {
  runApp(const AplikasiPresenGoPerangkat());
}

class AplikasiPresenGoPerangkat extends StatelessWidget {
  const AplikasiPresenGoPerangkat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PresenGo — Lampiran Bukti Kehadiran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanLampiranFotoPresenGo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanLampiranFotoPresenGo extends StatefulWidget {
  const HalamanLampiranFotoPresenGo({super.key});

  @override
  State<HalamanLampiranFotoPresenGo> createState() =>
      _HalamanLampiranFotoPresenGoState();
}

class _HalamanLampiranFotoPresenGoState
    extends State<HalamanLampiranFotoPresenGo> {
  final FotoPresensiService _fotoService = FotoPresensiService();

  bool _sedangMemproses = false;
  XFile? _fotoLampiran;
  double? _ukuranKb;
  String? _pesanInfo;
  String? _pesanError;
  bool _isPermissionDitolak = false;
  ImageSource _sumberTerakhir = ImageSource.gallery;

  Future<void> _prosesAmbilFoto(ImageSource sumber) async {
    setState(() {
      _sedangMemproses = true;
      _sumberTerakhir = sumber;
      _pesanError = null;
      _isPermissionDitolak = false;
    });

    final HasilLampiranFoto hasil =
        await _fotoService.ambilLampiran(sumber: sumber);
    if (!mounted) return;

    setState(() {
      _sedangMemproses = false;
      switch (hasil.status) {
        case StatusHasilFoto.berhasil:
          _fotoLampiran = hasil.file;
          _ukuranKb = hasil.ukuranKb;
          _pesanInfo = hasil.pesan;
          _pesanError = null;
          _isPermissionDitolak = false;
        case StatusHasilFoto.dibatalkan:
          // Pertahankan _fotoLampiran dan _ukuranKb sebelumnya
          _pesanInfo = hasil.pesan;
          _pesanError = null;
          _isPermissionDitolak = false;
        case StatusHasilFoto.permissionDitolak:
          _pesanError = hasil.pesan;
          _isPermissionDitolak = true;
        case StatusHasilFoto.error:
          _pesanError = hasil.pesan;
          _isPermissionDitolak = false;
      }
    });
  }

  void _bersihkanLampiran() {
    setState(() {
      _fotoLampiran = null;
      _ukuranKb = null;
      _pesanError = null;
      _isPermissionDitolak = false;
      _pesanInfo = 'Lampiran foto dikosongkan.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bukti Kehadiran Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rapat Koordinasi Program Kerja HIMSIF',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Aktor: Anggota / Pengurus Organisasi • Sekre HIMSIF',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _sedangMemproses
                                ? null
                                : () => _prosesAmbilFoto(ImageSource.camera),
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Kamera'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _sedangMemproses
                                ? null
                                : () => _prosesAmbilFoto(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Galeri / File'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_sedangMemproses)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Memproses akses perangkat dan lampiran foto...'),
                    ],
                  ),
                ),
              ),
            if (!_sedangMemproses && _pesanError != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isPermissionDitolak
                                ? Icons.lock_outline
                                : Icons.error_outline,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isPermissionDitolak
                                ? 'Izin Perangkat Ditolak'
                                : 'Gagal Memuat Lampiran',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _pesanError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      if (_isPermissionDitolak) ...[
                        const SizedBox(height: 6),
                        const Text(
                          'Panduan: Buka pengaturan izin situs/aplikasi di browser atau pengaturan perangkat, izinkan akses kamera/foto, lalu tekan Coba Lagi.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () => _prosesAmbilFoto(_sumberTerakhir),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              ),
            if (!_sedangMemproses && _pesanError == null && _pesanInfo != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _pesanInfo!,
                  style: TextStyle(color: scheme.primary),
                ),
              ),
            if (_fotoLampiran != null)
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: Image.network(
                        _fotoLampiran!.path,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Pratinjau gambar tidak dapat dirender pada sesi ini.',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _fotoLampiran!.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_ukuranKb != null)
                                  Text(
                                    'Ukuran: ${_ukuranKb!.toStringAsFixed(1)} KB',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _bersihkanLampiran,
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            tooltip: 'Hapus Lampiran',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else if (!_sedangMemproses && _pesanError == null)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      'Belum ada foto bukti kehadiran yang dilampirkan.',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}