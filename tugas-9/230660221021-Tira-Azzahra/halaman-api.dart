import 'package:flutter/material.dart';
import 'service-api.dart';

/// Halaman UI — hanya mengurus tampilan.
/// Logika HTTP ada di service-api.dart (service layer).
class HalamanPengajuanAPI extends StatefulWidget {
  const HalamanPengajuanAPI({super.key});

  @override
  State<HalamanPengajuanAPI> createState() => _HalamanPengajuanAPIState();
}

class _HalamanPengajuanAPIState extends State<HalamanPengajuanAPI> {
  bool _sedangMemuat = false;
  String? _pesanError;
  List<PengajuanPinjam> _daftar = [];

  final _judulController = TextEditingController();
  final _catatanController = TextEditingController();
  bool _sedangMengirim = false;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  /// Memanggil GET dari service — menangani loading / sukses / error
  Future<void> _muatData() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    // Jeda 2 detik supaya loading terlihat & bisa di-screenshot
    await Future.delayed(const Duration(seconds: 2));

    try {
      final hasil = await PerpustakaanApiService.ambilDaftarPengajuan();
      if (!mounted) return;
      setState(() {
        _daftar = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.toString().replaceAll('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  /// Memanggil POST dari service
  Future<void> _kirimData() async {
    if (_judulController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul buku wajib diisi!')),
      );
      return;
    }

    setState(() => _sedangMengirim = true);

    try {
      final baru = PengajuanBaru(
        idPemohon: 21,
        judulBuku: _judulController.text.trim(),
        catatan: _catatanController.text.trim(),
      );

      final hasil = await PerpustakaanApiService.kirimPengajuan(baru);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pengajuan berhasil dikirim! ID: #${hasil.id}'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _judulController.clear();
      _catatanController.clear();
      _muatData();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _sedangMengirim = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'SI Perpustakaan — Pengajuan Buku',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
            onPressed: _sedangMemuat ? null : _muatData,
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560), // rapi di tengah
          child: Column(
            children: [
              _kartuForm(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Pengajuan (GET)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${_daftar.length} data',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(child: _bagianDaftar()),
            ],
          ),
        ),
      ),
    );
  }

  /// Kartu form input (POST)
  Widget _kartuForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_note, color: Colors.indigo.shade600),
              const SizedBox(width: 6),
              const Text(
                'Form Usulan Peminjaman',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _judulController,
            decoration: InputDecoration(
              labelText: 'Judul Buku',
              hintText: 'contoh: Analisis Sistem Informasi',
              prefixIcon: const Icon(Icons.menu_book, size: 20),
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _catatanController,
            decoration: InputDecoration(
              labelText: 'Catatan Keperluan',
              hintText: 'contoh: referensi skripsi bab 2',
              prefixIcon: const Icon(Icons.notes, size: 20),
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Tombol nonaktif saat sedang mengirim (anti double-click)
              onPressed: _sedangMengirim ? null : _kirimData,
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send, size: 18),
              label: Text(
                _sedangMengirim ? 'Mengirim...' : 'Kirim Pengajuan (POST)',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian daftar — 3 kondisi: loading / error / sukses
  Widget _bagianDaftar() {
    // 1) LOADING
    if (_sedangMemuat) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 14),
            Text(
              'Menghubungkan ke API server...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // 2) ERROR + tombol Coba Lagi
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cloud_off, size: 46, color: Colors.red.shade400),
              ),
              const SizedBox(height: 14),
              const Text(
                'Koneksi Gagal',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                ),
                onPressed: _muatData,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // Data kosong
    if (_daftar.isEmpty) {
      return const Center(
        child: Text('Belum ada data pengajuan.', style: TextStyle(color: Colors.grey)),
      );
    }

    // 3) SUKSES — daftar data
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      itemCount: _daftar.length,
      itemBuilder: (context, index) {
        final item = _daftar[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade50,
              child: Text(
                '#${item.id}',
                style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            title: Text(
              item.judulBuku,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                item.catatan,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Menunggu',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}