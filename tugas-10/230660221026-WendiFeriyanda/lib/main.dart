import 'package:flutter/material.dart';

import 'halaman_integrasi.dart';

void main() {
  runApp(const SiRakusIntegrasiApp());
}

class SiRakusIntegrasiApp extends StatelessWidget {
  const SiRakusIntegrasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI RAKUS — Tugas 10',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HalamanIntegrasi(),
    );
  }
}
