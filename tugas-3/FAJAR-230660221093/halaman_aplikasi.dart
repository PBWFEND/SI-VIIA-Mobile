// ============================================================================
// PAB — Tugas 3: Halaman Aplikasi Sederhana
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// Halaman: Katalog Layanan
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka widget (Scaffold, Column, Row,
// ListView.builder) mengikuti pola latihan-widget-flutter.dart, dengan data
// disesuaikan ke domain Glazent.pro.
//
// Cara menjalankan:
//   Jalur 1 — DartPad (tanpa instalasi):
//     Buka https://dartpad.dev/?template=app, salin seluruh file ini, Run.
//   Jalur 2 — Flutter SDK:
//     Salin ke lib/main.dart pada project Flutter, lalu:
//       flutter run -d chrome
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama. MaterialApp mengatur tema dan halaman awal.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glazent.pro — Katalog Layanan',
      debugShowCheckedModeBanner: false,
      home: const HalamanLayanan(),
    );
  }
}

/// Halaman utama: katalog layanan Glazent.pro.
///
/// Widget tree halaman ini:
///   MaterialApp
///   └── HalamanLayanan (Scaffold)
///       ├── AppBar: "Glazent.pro — Katalog Layanan"
///       ├── body: Column
///       │   ├── Padding: Text sapaan
///       │   └── Expanded
///       │       └── ListView.builder
///       │           └── LayananRow × N
///       │               └── Row (ikon + Column(nama, kategori) + status)
///       └── floatingActionButton: "+"
class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    // ---------- Data: minimal 4 entri, kunci konsisten ----------
    final daftarLayanan = [
      {'nama': 'Cleaning Kaca Rumah', 'kategori': 'Rumah Tangga', 'status': 'Tersedia'},
      {'nama': 'Cleaning Kaca Facade Gedung', 'kategori': 'Korporat', 'status': 'Tersedia'},
      {'nama': 'Nanocoating Kaca Shower', 'kategori': 'Rumah Tangga', 'status': 'Tersedia'},
      {'nama': 'Cleaning Kanopi', 'kategori': 'Rumah Tangga', 'status': 'Penuh'},
      {'nama': 'Nanocoating Kaca Mobil', 'kategori': 'Kendaraan', 'status': 'Tersedia'},
    ];

    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(
        title: const Text('Glazent.pro — Katalog Layanan'),
        centerTitle: true,
      ),

      // ---------- Body: Column sebagai layout utama ----------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Layout ke-1: Padding, untuk spasi di sekeliling teks sapaan.
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Pilih layanan glass cleaning & nanocoating Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Layout ke-2: ListView.builder, dibungkus Expanded agar tidak
          // menyebabkan error RenderFlex overflow di dalam Column.
          Expanded(
            child: ListView.builder(
              itemCount: daftarLayanan.length,
              itemBuilder: (context, index) {
                final layanan = daftarLayanan[index];
                return LayananRow(
                  nama: layanan['nama']!,
                  kategori: layanan['kategori']!,
                  status: layanan['status']!,
                );
              },
            ),
          ),
        ],
      ),

      // ---------- FloatingActionButton ----------
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Tambah layanan',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Satu baris layanan: Row berisi ikon, Column (nama + kategori), dan
/// status ketersediaan di sisi kanan.
class LayananRow extends StatelessWidget {
  const LayananRow({
    super.key,
    required this.nama,
    required this.kategori,
    required this.status,
  });

  final String nama;
  final String kategori;
  final String status;

  @override
  Widget build(BuildContext context) {
    final tersedia = status == 'Tersedia';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Layout ke-3: Row, menyusun ikon dan teks secara horizontal.
      child: Row(
        children: [
          Icon(
            Icons.cleaning_services,
            color: tersedia ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontSize: 15)),
                Text(
                  kategori,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Ekspresi ternary (mengulang materi P2): warna status berbeda
          // tergantung ketersediaan.
          Text(
            status,
            style: TextStyle(
              color: tersedia ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
