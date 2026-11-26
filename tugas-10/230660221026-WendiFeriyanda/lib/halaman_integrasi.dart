import 'package:flutter/material.dart';

import 'models/riwayat_simulasi_ringkas.dart';
import 'services/integrasi_service.dart';

/// Halaman untuk menampilkan hasil integrasi GET /users dan GET /posts.
///
/// PERHATIAN: JSONPlaceholder hanya menyediakan data simulasi.
/// Data yang tampil bukan riwayat peminjaman buku asli dari Libsys.
class HalamanIntegrasi extends StatefulWidget {
  const HalamanIntegrasi({super.key});

  @override
  State<HalamanIntegrasi> createState() => _HalamanIntegrasiState();
}

class _HalamanIntegrasiState extends State<HalamanIntegrasi> {
  final IntegrasiService _service = IntegrasiService();

  bool _sedangMemuat = true;
  String? _pesanError;
  List<RiwayatSimulasiRingkas> _daftar = [];

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await _service.ambilDataTerintegrasi();

      if (!mounted) return;
      setState(() {
        _daftar = hasil;
        _sedangMemuat = false;
        _pesanError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sedangMemuat = false;
        _pesanError = _pesanUntukPengguna(error);
      });
    }
  }

  String _pesanUntukPengguna(Object error) {
    return error
        .toString()
        .replaceFirst('Exception: ', '')
        .replaceFirst('FormatException: ', 'Format data tidak sesuai: ');
  }

  Widget _tampilanLoading() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 14),
          Text('Sedang mengambil dan menggabungkan data...'),
        ],
      ),
    );
  }

  Widget _tampilanError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              'Data tidak dapat dimuat',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _pesanError ?? 'Terjadi kesalahan yang tidak diketahui.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _muatData,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tampilanKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Belum ada data aktivitas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Request berhasil, tetapi server tidak mengirimkan data untuk ditampilkan.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _muatData,
              icon: const Icon(Icons.refresh),
              label: const Text('Muat Ulang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuAktivitas(RiwayatSimulasiRingkas item) {
    final warna = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 5, 12, 7),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: warna.primaryContainer,
                  foregroundColor: warna.onPrimaryContainer,
                  child: Text(item.namaPengguna.isNotEmpty
                      ? item.namaPengguna[0].toUpperCase()
                      : '?'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.namaPengguna,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.emailPengguna,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Chip(label: Text('ID ${item.id}')),
              ],
            ),
            const Divider(height: 22),
            Text(
              item.judulAktivitas,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 6),
            Text(item.deskripsiAktivitas),
            const SizedBox(height: 10),
            Text(
              'Terhubung melalui userId: ${item.userId}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: warna.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tampilanData() {
    if (_daftar.isEmpty) return _tampilanKosong();

    return RefreshIndicator(
      onRefresh: _muatData,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 6, bottom: 24),
        itemCount: _daftar.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Text(
                '${_daftar.length} aktivitas simulasi berhasil digabungkan.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return _kartuAktivitas(_daftar[index - 1]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SI RAKUS — Integrasi Data'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang data',
            onPressed: _sedangMemuat ? null : _muatData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Data ini berasal dari API simulasi JSONPlaceholder, '
                    'bukan riwayat peminjaman asli atau data Libsys.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiaryContainer,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _sedangMemuat
                ? _tampilanLoading()
                : _pesanError != null
                    ? _tampilanError()
                    : _tampilanData(),
          ),
        ],
      ),
    );
  }
}
