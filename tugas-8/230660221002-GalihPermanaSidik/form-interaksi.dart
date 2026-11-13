import 'package:flutter/material.dart';

void main() => runApp(const SiLaporApp());

/// Satu sumber nama route. Harus sama dengan navigation-flow.md.
class Rute {
  static const String utama = '/';
  static const String form = '/form';
  static const String serupa = '/serupa';
  static const String detail = '/detail';
}

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
      initialRoute: Rute.utama,
      routes: {
        Rute.utama: (context) => const HalamanUtama(),
        Rute.form: (context) => const HalamanForm(),
        Rute.serupa: (context) => const HalamanSerupa(),
        Rute.detail: (context) => const HalamanDetail(),
      },
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

// ---------------------------------------------------------------------------
// Halaman utama mahasiswa (route '/'): daftar laporan saya, F-03 dan F-07.
// Layar pertama, jadi tidak ada tombol kembali.
// ---------------------------------------------------------------------------
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
      // Aksi utama F-01: maju ke form.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Rute.form),
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
        trailing: ChipStatus(laporan.status),
        // Kirim objek Laporan ke halaman detail lewat arguments.
        onTap: () => Navigator.pushNamed(
          context,
          Rute.detail,
          arguments: laporan,
        ),
      ),
    );
  }
}

/// Chip status: warna dan ikon dari tema, dipakai di daftar, serupa, dan detail.
class ChipStatus extends StatelessWidget {
  final String status;
  const ChipStatus(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final s = status;

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

    return Chip(
      avatar: Icon(ikon, size: 16, color: isi),
      label: Text(s, style: TextStyle(color: isi)),
      backgroundColor: latar,
      side: BorderSide.none,
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

// ---------------------------------------------------------------------------
// Halaman form laporan (route '/form'): F-01 dan F-02.
// StatefulWidget agar controller bisa dibersihkan pada dispose.
// ---------------------------------------------------------------------------
class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});

  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  static const List<String> _daftarKategori = [
    'Proyektor',
    'AC',
    'Keran',
    'Kursi',
  ];

  final _formKey = GlobalKey<FormState>();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _kategori;
  bool _fotoTerlampir = false; // F-02 opsional, simulasi tanpa package.

  @override
  void dispose() {
    _lokasiController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  // Urutan: validasi -> cek laporan serupa (F-04) -> feedback -> kembali.
  void _kirim() {
    if (!_formKey.currentState!.validate()) {
      return; // Pesan validator tampil otomatis di bawah field.
    }
    final lokasi = _lokasiController.text.trim();

    // F-04: laporan aktif (Menunggu atau Diproses) pada lokasi yang sama.
    final serupa = daftarLaporan
        .where((l) =>
            (l.status == 'Menunggu' || l.status == 'Diproses') &&
            l.lokasi.toLowerCase() == lokasi.toLowerCase())
        .toList();

    if (serupa.isNotEmpty) {
      Navigator.pushNamed(context, Rute.serupa, arguments: serupa);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Laporan "$_kategori di $lokasi" dikirim (simulasi).'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                hintText: 'Contoh: Gedung B, R. 204',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lokasi wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih kategori'),
              items: _daftarKategori
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => _kategori = v,
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan kerusakan singkat',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Deskripsi wajib diisi.';
                }
                if (value.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // F-02: foto opsional, sehingga tanpa validator.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      color: warna.surfaceContainerHighest,
                      child: Icon(
                        _fotoTerlampir ? Icons.image : Icons.image_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Foto kerusakan', style: teks.titleSmall),
                          Text(
                            _fotoTerlampir
                                ? 'Foto terlampir (simulasi)'
                                : 'Opsional',
                            style: teks.bodySmall
                                ?.copyWith(color: warna.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          setState(() => _fotoTerlampir = !_fotoTerlampir),
                      child: Text(_fotoTerlampir ? 'Hapus' : 'Lampirkan foto'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _kirim,
              child: const Text('Kirim laporan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Halaman laporan serupa (route '/serupa'): F-04.
// Menerima List<Laporan> lewat arguments. Nama pelapor tidak ditampilkan (NF-03).
// ---------------------------------------------------------------------------
class HalamanSerupa extends StatelessWidget {
  const HalamanSerupa({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final serupa = args is List<Laporan> ? args : null;
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Serupa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: serupa == null || serupa.isEmpty
            ? const Center(child: Text('Tidak ada laporan serupa.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sudah ada laporan aktif di lokasi ini',
                    style: teks.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Laporan Anda belum dikirim agar tidak ganda. Pantau status laporan di bawah.',
                    style:
                        teks.bodyMedium?.copyWith(color: warna.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: serupa.length,
                      itemBuilder: (context, i) {
                        final l = serupa[i];
                        return Card(
                          child: ListTile(
                            title: Text(l.judul),
                            subtitle: Text('${l.lokasi}\n${l.tanggal}'),
                            isThreeLine: true,
                            trailing: ChipStatus(l.status),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      // Kembali sampai halaman utama (F-04: lanjut memantau).
                      onPressed: () => Navigator.popUntil(
                        context,
                        ModalRoute.withName(Rute.utama),
                      ),
                      child: const Text('Kembali ke Laporan Saya'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Halaman detail laporan, mahasiswa (route '/detail'): F-08.
// Read-only: hanya menampilkan data dari arguments. Pembatalan laporan
// (F-08) mengubah data, jadi ditunda ke Pertemuan 7.
// ---------------------------------------------------------------------------
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final laporan = args is Laporan ? args : null;
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: laporan == null
            ? const Center(child: Text('Data laporan tidak tersedia.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(laporan.judul, style: teks.headlineSmall),
                  const SizedBox(height: 8),
                  ChipStatus(laporan.status),
                  const SizedBox(height: 16),
                  Text('Lokasi: ${laporan.lokasi}'),
                  const SizedBox(height: 4),
                  Text('Tanggal: ${laporan.tanggal}'),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
