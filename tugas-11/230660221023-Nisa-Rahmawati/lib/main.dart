import 'package:flutter/material.dart';
import 'pages/halaman_unggah_berkas_perpustakaan.dart';

void main() {
  runApp(const AplikasiFiturPerangkatPerpustakaan());
}

class AplikasiFiturPerangkatPerpustakaan extends StatelessWidget {
  const AplikasiFiturPerangkatPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Informasi Perpustakaan — Tugas 11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      home: const HalamanUnggahBerkasPerpustakaan(),
    );
  }
}