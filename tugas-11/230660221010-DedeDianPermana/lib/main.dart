import 'package:flutter/material.dart';
import 'services/file_service.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HalamanFilePicker(),
    );
  }
}

class HalamanFilePicker extends StatefulWidget {
  const HalamanFilePicker({super.key});

  @override
  State<HalamanFilePicker> createState() =>
      _HalamanFilePickerState();
}

class _HalamanFilePickerState extends State<HalamanFilePicker> {
  final FileService _fileService = FileService();

  FileTerpilih? _fileTerpilih;
  bool _isLoading = false;
  String? _pesanError;
  String _status = 'Belum ada dokumen yang dipilih.';

  Future<void> _pilihDokumen() async {
    setState(() {
      _isLoading = true;
      _pesanError = null;
    });

    try {
      final file = await _fileService.pilihFile();

      if (!mounted) return;

      if (file != null) {
        setState(() {
          _fileTerpilih = file;
          _status = 'Dokumen berhasil dipilih.';
        });
      } else {
        setState(() {
          _status = 'Pemilihan dokumen dibatalkan.';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _pesanError = e.toString();
        _status = 'Terjadi kesalahan saat memilih dokumen.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _formatUkuran(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiRuang Kampus'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_file,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Dokumen Pendukung Peminjaman Ruangan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih dokumen pendukung seperti surat izin '
                'atau proposal kegiatan.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton.icon(
                  onPressed: _pilihDokumen,
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Pilih Dokumen'),
                ),
              const SizedBox(height: 20),
              Text(
                _status,
                textAlign: TextAlign.center,
              ),
              if (_fileTerpilih != null) ...[
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.insert_drive_file,
                      color: Colors.blue,
                    ),
                    title: Text(
                      _fileTerpilih!.nama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Ukuran: ${_formatUkuran(_fileTerpilih!.ukuran)}',
                    ),
                  ),
                ),
              ],
              if (_pesanError != null) ...[
                const SizedBox(height: 16),
                Text(
                  _pesanError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _pilihDokumen,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
