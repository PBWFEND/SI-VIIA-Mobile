import 'package:flutter/material.dart';
import 'models/model-integrasi.dart';
import 'services/integrasi-service.dart';

void main() {
  runApp(const AplikasiPresenGoIntegrasi());
}

class AplikasiPresenGoIntegrasi extends StatelessWidget {
  const AplikasiPresenGoIntegrasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PresenGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanIntegrasiJadwal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanIntegrasiJadwal extends StatefulWidget {
  const HalamanIntegrasiJadwal({super.key});

  @override
  State<HalamanIntegrasiJadwal> createState() => _HalamanIntegrasiJadwalState();
}

class _HalamanIntegrasiJadwalState extends State<HalamanIntegrasiJadwal> {
  bool _sedangMemuat = true;
  String? _pesanError;
  List<DataJadwalTerintegrasi> _daftar = [];

  @override
  void initState() {
    super.initState();
    _muatDataTerintegrasi();
  }

  Future<void> _muatDataTerintegrasi() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await IntegrasiPresenGoService.ambilJadwalTerintegrasi();
      if (!mounted) return;
      setState(() {
        _daftar = hasil;
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

  void _toggleStatus(int id) {
    setState(() {
      final idx = _daftar.indexWhere((item) => item.id == id);
      if (idx == -1) return;
      final statusBaru = _daftar[idx].status == StatusJadwal.selesai
          ? StatusJadwal.segera
          : StatusJadwal.selesai;
      _daftar[idx] = _daftar[idx].copyWith(status: statusBaru);
    });
  }

  void _hapusItem(int id) {
    setState(() {
      _daftar.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang',
            onPressed: _sedangMemuat ? null : _muatDataTerintegrasi,
          ),
        ],
      ),
      body: _bangunKonten(scheme),
    );
  }

  Widget _bangunKonten(ColorScheme scheme) {
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

    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 52, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _muatDataTerintegrasi,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_daftar.isEmpty) {
      return const Center(
        child: Text('Belum ada jadwal kegiatan untuk ditampilkan.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _daftar.length,
      itemBuilder: (context, index) {
        final item = _daftar[index];
        final bool isSelesai = item.status == StatusJadwal.selesai;
        final Color warnaUtama = isSelesai ? Colors.green : scheme.primary;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: warnaUtama.withValues(alpha: 0.14),
              child: Icon(Icons.calendar_today, color: warnaUtama),
            ),
            title: Text(
              item.namaKegiatan,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${item.waktu} • ${item.lokasiRuang} • ${item.namaPemohon}\n'
              'Status: ${labelStatusJadwal(item.status)}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isSelesai
                        ? Icons.check_circle_outline
                        : Icons.radio_button_unchecked,
                    color: isSelesai ? Colors.green : Colors.grey[600],
                  ),
                  tooltip: 'Ubah Status',
                  onPressed: () => _toggleStatus(item.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'Hapus',
                  onPressed: () => _hapusItem(item.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}