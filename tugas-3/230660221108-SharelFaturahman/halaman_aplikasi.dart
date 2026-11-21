import 'package:flutter/material.dart';

// Tugas 3 — Sharel Faturahman | NPM 230660221108
// Bantuan: ChatGPT/Codex untuk menyusun halaman dan memeriksa implementasi.
void main() => runApp(const TaskCampusApp());

class TaskCampusApp extends StatelessWidget {
  const TaskCampusApp({super.key});

  static const daftarTugas = <Map<String, String>>[
    {
      'nama': 'Halaman Aplikasi Sederhana',
      'mataKuliah': 'Pemrograman Aplikasi Bergerak',
      'tenggat': 'Sebelum Pertemuan 4',
      'status': 'Dikerjakan',
    },
    {
      'nama': 'Diagram Proses Bisnis',
      'mataKuliah': 'Analisis Proses Bisnis',
      'tenggat': 'Pertemuan berikutnya',
      'status': 'Belum dimulai',
    },
    {
      'nama': 'Rancangan Antarmuka Sistem',
      'mataKuliah': 'Interaksi Manusia dan Komputer',
      'tenggat': 'Pertemuan berikutnya',
      'status': 'Belum dimulai',
    },
    {
      'nama': 'Modul Hitung Nilai',
      'mataKuliah': 'Pemrograman Aplikasi Bergerak',
      'tenggat': 'Sebelum Pertemuan 3',
      'status': 'Selesai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF087F78);
    return MaterialApp(
      title: 'TaskCampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: teal),
        scaffoldBackgroundColor: const Color(0xFFF4F7FA),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Row(
            children: [
              Icon(Icons.school_rounded, color: teal),
              SizedBox(width: 10),
              Text('TaskCampus', style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Halo, Sharel 👋',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172C43),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Satu tempat untuk memantau tugas kuliahmu.',
                    style: TextStyle(color: Color(0xFF63758B)),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F3F1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.auto_stories_rounded, size: 34, color: teal),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Langkah kecil, tugas makin tertata.',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: teal,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Sharel Faturahman • 230660221108 • SI-VIIA',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF426B68),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _ringkasan(
                        'Total tugas',
                        daftarTugas.length,
                        const Color(0xFF253F65),
                      ),
                      const SizedBox(width: 10),
                      _ringkasan(
                        'Aktif',
                        daftarTugas
                            .where((t) => t['status'] != 'Selesai')
                            .length,
                        teal,
                      ),
                      const SizedBox(width: 10),
                      _ringkasan(
                        'Selesai',
                        daftarTugas
                            .where((t) => t['status'] == 'Selesai')
                            .length,
                        const Color(0xFF6961B3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Daftar tugas',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF172C43),
                          ),
                        ),
                      ),
                      Text(
                        'Semester 7',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF63758B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: daftarTugas.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          _kartuTugas(daftarTugas[index], index + 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'TaskCampus • Tugas kuliah lebih tertata',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Color(0xFF7B8999)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ringkasan(String label, int jumlah, Color warna) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$jumlah',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: warna,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF63758B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kartuTugas(Map<String, String> tugas, int nomor) {
    final selesai = tugas['status'] == 'Selesai';
    final aktif = tugas['status'] == 'Dikerjakan';
    final warna = selesai
        ? const Color(0xFF168461)
        : aktif
        ? const Color(0xFF087F78)
        : const Color(0xFF9C6A21);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4EAF0)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFEEF3FA),
            child: Text(
              '$nomor',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF253F65),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tugas['nama']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172C43),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tugas['mataKuliah']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF63758B),
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      tugas['tenggat']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF63758B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: warna.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tugas['status']!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: warna,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
