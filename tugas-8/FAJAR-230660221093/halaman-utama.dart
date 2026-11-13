// ============================================================================
// PAB — Tugas 5: Prototype UI/UX
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// Layar utama: Status Pesanan Saya — memenuhi F-02 (Must), titik masuk F-01
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka widget (tema terpusat, Card+ListTile,
// status berwarna, FAB, keadaan kosong) mengikuti pola demo-ui-flutter.dart,
// dengan data dan konteks disesuaikan ke domain Glazent.pro.
//
// Cara menjalankan:
//   Jalur 1 — DartPad: https://dartpad.dev/?template=app, salin seluruh isi
//     file ini, tekan Run.
//   Jalur 2 — Flutter SDK: salin ke lib/main.dart, lalu flutter run -d chrome
//
// Catatan cakupan: TANPA Navigator — tombol "Pesan Layanan Baru" belum
// berpindah layar (materi Pertemuan 6).
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama. Tema didefinisikan sekali di sini — seluruh komponen
/// visual mengambil warna dari colorScheme hasil benih biru.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glazent.pro — Status Pesanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HalamanStatusPesanan(),
    );
  }
}

/// Layar utama — memenuhi F-02 (Pelanggan dapat melihat status pesanan
/// terkini) dan menjadi titik masuk menuju F-01 (mengajukan pemesanan)
/// melalui FloatingActionButton.
class HalamanStatusPesanan extends StatelessWidget {
  const HalamanStatusPesanan({super.key});

  /// Ubah menjadi true untuk menguji keadaan kosong.
  static const bool daftarKosong = false;

  /// Data statis untuk prototype — pada Minggu 7 digantikan data lokal.
  static const List<Map<String, String>> daftarPesanan = [
    {
      'layanan': 'Cleaning Kaca Rumah',
      'tanggal': 'Senin, 20 Okt',
      'status': 'menunggu',
    },
    {
      'layanan': 'Nanocoating Kaca Shower',
      'tanggal': 'Rabu, 22 Okt',
      'status': 'dijadwalkan',
    },
    {
      'layanan': 'Cleaning Kanopi',
      'tanggal': 'Jumat, 10 Okt',
      'status': 'selesai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan Saya')),
      body: daftarKosong
          ? const KeadaanKosong()
          : Column(
              children: [
                const RingkasanPelanggan(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: daftarPesanan.length,
                    itemBuilder: (context, index) {
                      final pesanan = daftarPesanan[index];
                      return KartuPesanan(pesanan: pesanan);
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigasi ke halaman form pemesanan (F-01) dibangun pada
          // Pertemuan 6 — belum menggunakan Navigator di sini.
        },
        icon: const Icon(Icons.add),
        label: const Text('Pesan Layanan Baru'),
      ),
    );
  }
}

/// Area ringkasan atas — hierarki visual: judul tebal, keterangan redup.
class RingkasanPelanggan extends StatelessWidget {
  const RingkasanPelanggan({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, Rani!', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              '${HalamanStatusPesanan.daftarPesanan.length} pesanan aktif — '
              'tekan tombol di bawah untuk memesan layanan baru.',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu item daftar: Card + ListTile + status berwarna.
class KartuPesanan extends StatelessWidget {
  const KartuPesanan({super.key, required this.pesanan});

  final Map<String, String> pesanan;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.cleaning_services_outlined),
        title: Text(
          pesanan['layanan'] ?? '-',
          style: textTheme.titleMedium,
        ),
        subtitle: Text(
          pesanan['tanggal'] ?? '-',
          style: textTheme.bodySmall,
        ),
        trailing: ChipStatus(status: pesanan['status'] ?? 'menunggu'),
      ),
    );
  }
}

/// Status sebagai Chip berwarna — warna diambil dari tema, bukan ditulis
/// langsung. Pembedaan warna memakai ternary (materi P2).
class ChipStatus extends StatelessWidget {
  const ChipStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (Color latar, Color teks) = status == 'selesai'
        ? (colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer)
        : status == 'dijadwalkan'
            ? (colorScheme.primaryContainer, colorScheme.onPrimaryContainer)
            : (colorScheme.secondaryContainer, colorScheme.onSecondaryContainer);
    return Chip(
      label: Text(status),
      backgroundColor: latar,
      labelStyle: TextStyle(color: teks, fontWeight: FontWeight.w600),
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Keadaan kosong — pelanggan baru tidak boleh melihat layar putih.
class KeadaanKosong extends StatelessWidget {
  const KeadaanKosong({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 56, color: colorScheme.outline),
          const SizedBox(height: 12),
          Text('Belum ada pesanan', style: textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Tekan tombol "Pesan Layanan Baru" untuk membuat\npesanan pertama Anda.',
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
