import 'package:flutter/material.dart';

void main() {
  runApp(const SiRakusApp());
}

class SiRakusApp extends StatelessWidget {
  const SiRakusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI RAKUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // TODO: Pilih warna benih yang menurutmu sesuai, lalu jelaskan alasannya
        // pada catatan-keputusan-ui.md.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class Buku {
  const Buku({
    required this.judul,
    required this.penulis,
    required this.stok,
  });

  final String judul;
  final String penulis;
  final int stok;

  bool get tersedia => stok > 0;
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController _pencarianController = TextEditingController();
  final FocusNode _fokusPencarian = FocusNode();

  // Data contoh untuk wireframe SI RAKUS. Sesuaikan bila perlu.
  final List<Buku> _daftarBuku = const [
    Buku(
      judul: 'Dasar-Dasar Pemrograman',
      penulis: 'Andi Pratama',
      stok: 3,
    ),
    Buku(
      judul: 'Pengantar Basis Data',
      penulis: 'Siti Rahmawati',
      stok: 0,
    ),
  ];

  String _kataKunci = '';

  List<Buku> get _hasilPencarian {
    final kataKunci = _kataKunci.trim().toLowerCase();
    if (kataKunci.isEmpty) return _daftarBuku;

    return _daftarBuku.where((buku) {
      return buku.judul.toLowerCase().contains(kataKunci) ||
          buku.penulis.toLowerCase().contains(kataKunci);
    }).toList();
  }

  @override
  void dispose() {
    _pencarianController.dispose();
    _fokusPencarian.dispose();
    super.dispose();
  }

  void _beriTahuDetail(Buku buku) {
    // Navigator sengaja belum digunakan karena navigasi dibahas pada Pertemuan 6.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buku "${buku.judul}" dipilih. Detail dihubungkan pada pertemuan berikutnya.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skemaWarna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SI RAKUS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Katalog Buku',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Temukan buku untuk kebutuhan kuliahmu.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: skemaWarna.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pencarianController,
              focusNode: _fokusPencarian,
              onChanged: (nilai) {
                setState(() => _kataKunci = nilai);
              },
              decoration: const InputDecoration(
                labelText: 'Cari judul buku atau penulis',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Daftar buku',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  '${_hasilPencarian.length} buku',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: skemaWarna.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _daftarBuku.isEmpty
                  ? _KeadaanKosong(
                      ikon: Icons.menu_book_outlined,
                      judul: 'Katalog belum tersedia',
                      pesan: 'Belum ada data buku untuk ditampilkan.',
                    )
                  : _hasilPencarian.isEmpty
                      ? const _KeadaanKosong(
                          ikon: Icons.search_off,
                          judul: 'Buku tidak ditemukan',
                          pesan: 'Coba gunakan kata kunci lain.',
                        )
                      : ListView.builder(
                          itemCount: _hasilPencarian.length,
                          itemBuilder: (context, index) {
                            final buku = _hasilPencarian[index];

                            // Status dibedakan dengan ternary; warnanya diambil dari tema.
                            final warnaLatarStatus = buku.tersedia
                                ? skemaWarna.primaryContainer
                                : skemaWarna.errorContainer;
                            final warnaTeksStatus = buku.tersedia
                                ? skemaWarna.onPrimaryContainer
                                : skemaWarna.onErrorContainer;
                            final teksStatus = buku.tersedia
                                ? 'Tersedia'
                                : 'Stok habis';

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        width: 58,
                                        height: 72,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: skemaWarna.surfaceContainerHighest,
                                          border: Border.all(
                                            color: skemaWarna.outlineVariant,
                                          ),
                                        ),
                                        child: Text(
                                          'Sampul',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ),
                                      title: Text(
                                        buku.judul,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(buku.penulis),
                                            const SizedBox(height: 7),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: warnaLatarStatus,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                '$teksStatus — ${buku.stok} eksemplar',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(color: warnaTeksStatus),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () => _beriTahuDetail(buku),
                                        child: const Text('Lihat detail'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      // Aksi utama: membawa fokus kembali ke kolom pencarian, tanpa Navigator.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => FocusScope.of(context).requestFocus(_fokusPencarian),
        icon: const Icon(Icons.search),
        label: const Text('Cari buku'),
      ),
    );
  }
}

class _KeadaanKosong extends StatelessWidget {
  const _KeadaanKosong({
    required this.ikon,
    required this.judul,
    required this.pesan,
  });

  final IconData ikon;
  final String judul;
  final String pesan;

  @override
  Widget build(BuildContext context) {
    final skemaWarna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, size: 48, color: skemaWarna.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              judul,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: skemaWarna.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
