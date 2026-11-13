import 'package:flutter/material.dart';

void main() => runApp(const SiLaporApp());

class SiLaporApp extends StatelessWidget {
  const SiLaporApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiLapor Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class Laporan {
  final String judul;
  final String lokasi;
  final String tanggal;
  final String status; // Menunggu, Diproses, Selesai, Ditolak

  const Laporan(this.judul, this.lokasi, this.tanggal, this.status);
}

// Kosongkan daftar ini (const []) untuk menguji keadaan kosong.
const List<Laporan> daftarLaporan = [
  Laporan('AC ruang kelas bocor', 'Gedung B, R. 204', '15 Okt 2026', 'Menunggu'),
  Laporan('Proyektor tidak menyala', 'Lab Komputer 2', '12 Okt 2026', 'Diproses'),
  Laporan('Keran wastafel patah', 'Toilet Lt. 1 Gedung A', '8 Okt 2026', 'Selesai'),
  Laporan('Kursi kuliah rusak', 'Gedung C, R. 101', '3 Okt 2026', 'Ditolak'),
];

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  String _kataKunci = '';

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;
    final menunggu = daftarLaporan.where((l) => l.status == 'Menunggu').length;

    // F-07: saring daftar menurut lokasi atau kata kunci.
    final hasil = daftarLaporan.where((l) {
      final k = _kataKunci.toLowerCase();
      return l.judul.toLowerCase().contains(k) ||
          l.lokasi.toLowerCase().contains(k);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('SiLapor Kampus')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ringkasan atas (F-03)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Laporan Saya',
                  style: teks.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '$menunggu laporan menunggu ditinjau',
                  style: teks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
                ),
              ],
            ),
          ),
          // Kolom pencarian (F-07)
          if (daftarLaporan.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                onChanged: (v) => setState(() => _kataKunci = v),
                decoration: const InputDecoration(
                  hintText: 'Cari lokasi atau kata kunci',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                ),
              ),
            ),
          // Daftar laporan (F-03) atau keadaan kosong
          Expanded(
            child: daftarLaporan.isEmpty
                ? const _KeadaanKosong(
                    judul: 'Belum ada laporan',
                    petunjuk:
                        'Ketuk Buat Laporan bila menemukan fasilitas yang rusak.',
                  )
                : hasil.isEmpty
                    ? const _KeadaanKosong(
                        judul: 'Tidak ada laporan yang cocok',
                        petunjuk: 'Coba kata kunci atau lokasi lain.',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
                        itemCount: hasil.length,
                        itemBuilder: (context, i) => _KartuLaporan(hasil[i]),
                      ),
          ),
        ],
      ),
      // Aksi utama (F-01)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigasi ke Halaman form laporan baru dibuat di Pertemuan 6.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form laporan dibuat di Pertemuan 6')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Buat Laporan'),
      ),
    );
  }
}

class _KartuLaporan extends StatelessWidget {
  final Laporan laporan;
  const _KartuLaporan(this.laporan);

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;
    final s = laporan.status;

    // Status: warna dan ikon dari tema, dipilih dengan ternary.
    final latar = s == 'Menunggu'
        ? warna.tertiaryContainer
        : s == 'Diproses'
            ? warna.secondaryContainer
            : s == 'Selesai'
                ? warna.primaryContainer
                : warna.errorContainer;
    final isi = s == 'Menunggu'
        ? warna.onTertiaryContainer
        : s == 'Diproses'
            ? warna.onSecondaryContainer
            : s == 'Selesai'
                ? warna.onPrimaryContainer
                : warna.onErrorContainer;
    final ikon = s == 'Menunggu'
        ? Icons.hourglass_top
        : s == 'Diproses'
            ? Icons.build
            : s == 'Selesai'
                ? Icons.check_circle
                : Icons.cancel;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(Icons.report_problem_outlined, color: warna.primary),
        title: Text(
          laporan.judul,
          style: teks.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${laporan.lokasi}\n${laporan.tanggal}',
          style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
        ),
        isThreeLine: true,
        trailing: Chip(
          avatar: Icon(ikon, size: 16, color: isi),
          label: Text(s, style: TextStyle(color: isi)),
          backgroundColor: latar,
          side: BorderSide.none,
        ),
      ),
    );
  }
}

class _KeadaanKosong extends StatelessWidget {
  final String judul;
  final String petunjuk;
  const _KeadaanKosong({required this.judul, required this.petunjuk});

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: warna.outline),
            const SizedBox(height: 12),
            Text(judul, style: teks.titleMedium),
            const SizedBox(height: 4),
            Text(
              petunjuk,
              textAlign: TextAlign.center,
              style: teks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}