import 'package:flutter/material.dart';

import '../models/berkas_perpustakaan_model.dart';
import '../services/berkas_perangkat_service.dart';

class HalamanUnggahBerkasPerpustakaan extends StatefulWidget {
  const HalamanUnggahBerkasPerpustakaan({super.key});

  @override
  State<HalamanUnggahBerkasPerpustakaan> createState() =>
      _HalamanUnggahBerkasPerpustakaanState();
}

class _HalamanUnggahBerkasPerpustakaanState
    extends State<HalamanUnggahBerkasPerpustakaan> {
  final BerkasPerangkatService _berkasService = BerkasPerangkatService();

  bool _sedangMemproses = false;
  BerkasPerpustakaanModel? _berkasAktif;
  String? _pesanKesalahan;
  bool _apakahPermissionDitolak = false;
  String _jenisDokumen = 'Scan Kartu Tanda Mahasiswa (KTM)';

  Future<void> _prosesPilihBerkas({
    bool simulasiPermissionDitolak = false,
    bool simulasiErrorPerangkat = false,
  }) async {
    setState(() {
      _sedangMemproses = true;
      _pesanKesalahan = null;
      _apakahPermissionDitolak = false;
    });

    try {
      final hasil = await _berkasService.pilihBerkasPerpustakaan(
        simulasiPermissionDitolak: simulasiPermissionDitolak,
        simulasiErrorPerangkat: simulasiErrorPerangkat,
      );

      if (!mounted) return;

      if (hasil == null) {
        // Pengguna membatalkan aksi: pertahankan state _berkasAktif sebelumnya
        setState(() {
          _sedangMemproses = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pemilihan berkas dibatalkan. Data berkas sebelumnya tetap dipertahankan.',
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Berhasil memilih berkas baru
      setState(() {
        _berkasAktif = hasil;
        _sedangMemproses = false;
      });
    } on PermissionBerkasException catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMemproses = false;
        _apakahPermissionDitolak = true;
        _pesanKesalahan = e.pesan;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMemproses = false;
        _apakahPermissionDitolak = false;
        _pesanKesalahan = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Unggah Berkas Perpustakaan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Simulasi Skenario Uji',
            icon: const Icon(Icons.science_outlined),
            onSelected: (pilihan) {
              if (pilihan == 'permission') {
                _prosesPilihBerkas(simulasiPermissionDitolak: true);
              } else if (pilihan == 'error') {
                _prosesPilihBerkas(simulasiErrorPerangkat: true);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'permission',
                child: Text('Uji Skenario: Permission Ditolak'),
              ),
              PopupMenuItem(
                value: 'error',
                child: Text('Uji Skenario: Error Perangkat'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _bangunHeaderIdentitas(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _bangunKartuFormDokumen(),
                  const SizedBox(height: 16),
                  _bangunAreaStatusPerangkat(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunHeaderIdentitas() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Icon(Icons.folder_shared_rounded,
              size: 32, color: Colors.blue.shade800),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nisa Rahmawati (230660221023) — SI-VIIA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(
                  'Fitur Perangkat: File Picker (Unggah Dokumen Bebas Pustaka / KTM)',
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunKartuFormDokumen() {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Pilih Jenis Berkas Administrasi Perpustakaan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _jenisDokumen,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Scan Kartu Tanda Mahasiswa (KTM)',
                  child: Text('Scan Kartu Tanda Mahasiswa (KTM)'),
                ),
                DropdownMenuItem(
                  value: 'Surat Keterangan Bebas Pustaka',
                  child: Text('Surat Keterangan Bebas Pustaka'),
                ),
                DropdownMenuItem(
                  value: 'Bukti Pembayaran Denda Keterlambatan',
                  child: Text('Bukti Pembayaran Denda Keterlambatan'),
                ),
              ],
              onChanged: _sedangMemproses
                  ? null
                  : (nilai) {
                      if (nilai != null) {
                        setState(() => _jenisDokumen = nilai);
                      }
                    },
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed:
                    _sedangMemproses ? null : () => _prosesPilihBerkas(),
                icon: const Icon(Icons.upload_file),
                label: Text(
                  _berkasAktif == null
                      ? 'Pilih Berkas dari Perangkat (PDF / JPG / PNG)'
                      : 'Ganti Berkas dari Perangkat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunAreaStatusPerangkat() {
    // 1. STATE LOADING
    if (_sedangMemproses) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              CircularProgressIndicator(color: Colors.blue.shade800),
              const SizedBox(height: 16),
              const Text(
                'Mengakses penyimpanan perangkat & memvalidasi berkas...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    // 2. STATE PERMISSION DITOLAK / ERROR PERANGKAT + TOMBOL COBA KEMBALI
    if (_pesanKesalahan != null) {
      return Card(
        color: _apakahPermissionDitolak
            ? Colors.amber.shade50
            : Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                _apakahPermissionDitolak
                    ? Icons.lock_person_rounded
                    : Icons.error_outline_rounded,
                size: 52,
                color: _apakahPermissionDitolak
                    ? Colors.amber.shade900
                    : Colors.red.shade700,
              ),
              const SizedBox(height: 12),
              Text(
                _apakahPermissionDitolak
                    ? 'Izin Akses Perangkat Ditolak'
                    : 'Gagal Mengambil Berkas Perangkat',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _pesanKesalahan!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue.shade800),
                onPressed: () => _prosesPilihBerkas(),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. STATE BERHASIL MEMILIH BERKAS (JUGA DIPERTAHANKAN JIKA AKSI BERIKUTNYA DIBATALKAN)
    if (_berkasAktif != null) {
      final berkas = _berkasAktif!;
      return Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Berkas Siap Diunggah ke Sistem Perpustakaan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Text('Jenis Dokumen : $_jenisDokumen',
                  style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Text('Nama File     : ${berkas.namaFile}',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Format / Size : ${berkas.ekstensi} • ${berkas.ukuranTerformat}',
                  style: const TextStyle(fontSize: 13)),
              if (berkas.adalahGambar && berkas.bytes != null) ...[
                const SizedBox(height: 14),
                const Text(
                  'Pratinjau Gambar:',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    berkas.bytes!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    // 4. STATE AWAL (BELUM ADA BERKAS DIPILIH)
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.description_outlined,
                size: 48, color: Colors.grey.shade500),
            const SizedBox(height: 12),
            const Text(
              'Belum Ada Berkas Dipilih',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tekan tombol di atas untuk memilih dokumen PDF atau gambar (maks. 5 MB) dari perangkat Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}