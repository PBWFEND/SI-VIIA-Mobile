
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/foto_service.dart';

class HalamanFoto extends StatefulWidget {
  const HalamanFoto({super.key});

  @override
  State<HalamanFoto> createState() => _HalamanFotoState();
}

class _HalamanFotoState extends State<HalamanFoto> {
  final FotoService _fotoService = FotoService();

  XFile? _foto;
  Uint8List? _dataFoto;

  bool _loading = false;
  String _pesan = 'Belum ada foto yang dipilih.';

  Future<void> _ambilFoto(bool dariKamera) async {
    setState(() {
      _loading = true;
      _pesan = 'Sedang memproses foto...';
    });

    try {
      XFile? hasil;

      if (dariKamera) {
        hasil = await _fotoService.ambilFotoDariKamera();
      } else {
        hasil = await _fotoService.pilihFotoDariGaleri();
      }

      if (!mounted) return;

      if (hasil == null) {
        setState(() {
          _pesan =
              'Pemilihan foto dibatalkan. Foto sebelumnya tetap disimpan.';
        });
        return;
      }

      final Uint8List bytes = await hasil.readAsBytes();

      if (!mounted) return;

      setState(() {
        _foto = hasil;
        _dataFoto = bytes;
        _pesan = 'Foto berhasil dipilih.';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _pesan = 'Terjadi kesalahan saat mengambil foto: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Foto'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.photo_camera,
              size: 65,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            const Text(
              'Dokumentasi Foto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ambil foto menggunakan kamera atau pilih gambar dari galeri sebagai bukti dokumentasi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: _dataFoto != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _dataFoto!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text('Pratinjau foto akan tampil di sini'),
                      ],
                    ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _loading ? null : () => _ambilFoto(true),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Ambil Foto dengan Kamera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: _loading ? null : () => _ambilFoto(false),
              icon: const Icon(Icons.photo_library),
              label: const Text('Pilih dari Galeri'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 20),

            if (_loading)
              const Center(
                child: CircularProgressIndicator(),
              ),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _pesan,
                textAlign: TextAlign.center,
              ),
            ),

            if (_foto != null) ...[
              const SizedBox(height: 12),
              Text(
                'Nama file: ${_foto!.name}',
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
