//   Create : Buat Laporan (form) -> _tambah          (F-01, F-02)
//   Read   : daftar + pencarian + detail             (F-03, F-07)
//   Update : ubah status + catatan (simulasi petugas) (F-06)
//   Delete : batalkan laporan Menunggu + konfirmasi  (F-08)
//

import 'package:flutter/material.dart';

void main() => runApp(const SiLaporApp());

/// Satu sumber nama route. Sama dengan navigation-flow.md (Tugas 6).
class Rute {
  static const String utama = '/';
  static const String form = '/form';
  static const String serupa = '/serupa';
  static const String detail = '/detail';
}

const List<String> daftarStatus = ['Menunggu', 'Diproses', 'Selesai', 'Ditolak'];

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

// ---------------------------------------------------------------------------
// Model data. Field final: perubahan menghasilkan objek baru (salinDengan).
// ---------------------------------------------------------------------------
class Laporan {
  const Laporan({
    required this.id,
    required this.kategori,
    required this.lokasi,
    required this.deskripsi,
    required this.tanggal,
    required this.status,
    required this.fotoTerlampir,
    required this.catatanPenanganan,
  });

  final String id; // kunci unik untuk update dan delete
  final String kategori; // form (F-01)
  final String lokasi; // form (F-01)
  final String deskripsi; // form (F-01)
  final String tanggal; // sistem, saat laporan dibuat
  final String status; // sistem: Menunggu; berubah lewat Update (F-03, F-06)
  final bool fotoTerlampir; // form (F-02), simulasi tanpa package
  final String catatanPenanganan; // petugas (F-06), awalnya kosong

  /// Judul ringkas untuk daftar, dihitung dari field lain (bukan disimpan).
  String get judul => '$kategori di $lokasi';

  /// Salinan dengan field tertentu diganti. Dipakai oleh Update.
  Laporan salinDengan({String? status, String? catatanPenanganan}) {
    return Laporan(
      id: id,
      kategori: kategori,
      lokasi: lokasi,
      deskripsi: deskripsi,
      tanggal: tanggal,
      status: status ?? this.status,
      fotoTerlampir: fotoTerlampir,
      catatanPenanganan: catatanPenanganan ?? this.catatanPenanganan,
    );
  }

  @override
  String toString() => 'Laporan $kategori di $lokasi ($tanggal, $status)';
}

/// Data awal (contoh). Dilanjutkan dari data halaman-utama.dart Tugas 5.
const List<Laporan> contohLaporan = [
  Laporan(
    id: 'L-001',
    kategori: 'AC',
    lokasi: 'Gedung B, R. 204',
    deskripsi: 'AC ruang kelas bocor dan meneteskan air ke kursi.',
    tanggal: '15 Okt 2026',
    status: 'Menunggu',
    fotoTerlampir: false,
    catatanPenanganan: '',
  ),
  Laporan(
    id: 'L-002',
    kategori: 'Proyektor',
    lokasi: 'Lab Komputer 2',
    deskripsi: 'Proyektor tidak menyala sejak awal minggu.',
    tanggal: '12 Okt 2026',
    status: 'Diproses',
    fotoTerlampir: true,
    catatanPenanganan: 'Lampu proyektor sedang diganti.',
  ),
  Laporan(
    id: 'L-003',
    kategori: 'Keran',
    lokasi: 'Toilet Lt. 1 Gedung A',
    deskripsi: 'Keran wastafel patah dan air terus menetes.',
    tanggal: '8 Okt 2026',
    status: 'Selesai',
    fotoTerlampir: false,
    catatanPenanganan: 'Keran sudah diganti.',
  ),
  Laporan(
    id: 'L-004',
    kategori: 'Kursi',
    lokasi: 'Gedung C, R. 101',
    deskripsi: 'Kaki kursi kuliah patah di baris kedua.',
    tanggal: '3 Okt 2026',
    status: 'Ditolak',
    fotoTerlampir: false,
    catatanPenanganan: 'Sudah masuk jadwal penggantian bulanan.',
  ),
];

/// Hasil dari layar detail yang dikembalikan ke daftar lewat Navigator.pop.
enum AksiDetail { ubah, hapus }

class HasilDetail {
  const HasilDetail(this.aksi, this.laporan);
  final AksiDetail aksi;
  final Laporan laporan;
}

String _tanggalHariIni() {
  const bulan = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  final n = DateTime.now();
  return '${n.day} ${bulan[n.month - 1]} ${n.year}';
}

// ---------------------------------------------------------------------------
// Halaman utama mahasiswa (route '/'). Pemilik data: List<Laporan> pada State.
// Semua perubahan data terjadi di sini, dibungkus setState.
// ---------------------------------------------------------------------------
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // State: satu-satunya sumber data. Ganti dengan [] untuk menguji keadaan kosong.
  final List<Laporan> _daftar = [...contohLaporan];
  String _kataKunci = '';

  // Create
  void _tambah(Laporan baru) {
    setState(() {
      _daftar.insert(0, baru);
    });
  }

  // Update: ganti objek lama dengan objek baru pada posisi yang sama.
  void _ubah(Laporan baru) {
    setState(() {
      final index = _daftar.indexWhere((l) => l.id == baru.id);
      if (index != -1) {
        _daftar[index] = baru;
      }
    });
  }

  // Delete: berdasarkan id, bukan index.
  void _hapus(String id) {
    setState(() {
      _daftar.removeWhere((l) => l.id == id);
    });
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  Future<void> _bukaForm() async {
    // Daftar dikirim read-only agar form bisa mengecek laporan serupa (F-04).
    final hasil = await Navigator.pushNamed(
      context,
      Rute.form,
      arguments: List<Laporan>.unmodifiable(_daftar),
    );
    if (!mounted) return;
    if (hasil is Laporan) {
      _tambah(hasil);
      _tampilkanPesan('Laporan "${hasil.judul}" ditambahkan ke daftar.');
    }
  }

  Future<void> _bukaDetail(Laporan laporan) async {
    final hasil = await Navigator.pushNamed(
      context,
      Rute.detail,
      arguments: laporan,
    );
    if (!mounted) return;
    if (hasil is HasilDetail) {
      if (hasil.aksi == AksiDetail.ubah) {
        _ubah(hasil.laporan);
        _tampilkanPesan(
          'Status laporan diperbarui menjadi ${hasil.laporan.status}.',
        );
      } else {
        _hapus(hasil.laporan.id);
        _tampilkanPesan('Laporan "${hasil.laporan.judul}" dibatalkan.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;
    final menunggu = _daftar.where((l) => l.status == 'Menunggu').length;

    // F-07: saring daftar menurut lokasi atau kata kunci.
    final hasil = _daftar.where((l) {
      final k = _kataKunci.toLowerCase();
      return l.judul.toLowerCase().contains(k) ||
          l.deskripsi.toLowerCase().contains(k);
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
          if (_daftar.isNotEmpty)
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
          // Read: ListView.builder membaca state pada setiap build.
          Expanded(
            child: _daftar.isEmpty
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
                        itemBuilder: (context, i) => _KartuLaporan(
                          laporan: hasil[i],
                          onTap: () => _bukaDetail(hasil[i]),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        icon: const Icon(Icons.add),
        label: const Text('Buat Laporan'),
      ),
    );
  }
}

class _KartuLaporan extends StatelessWidget {
  const _KartuLaporan({required this.laporan, required this.onTap});

  final Laporan laporan;
  final VoidCallback onTap;

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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              laporan.deskripsi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
            Text(
              laporan.tanggal,
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: ChipStatus(laporan.status),
        onTap: onTap,
      ),
    );
  }
}

/// Chip status: warna dan ikon dari tema, dipakai di daftar, serupa, dan detail.
class ChipStatus extends StatelessWidget {
  const ChipStatus(this.status, {super.key});

  final String status;

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
  const _KeadaanKosong({required this.judul, required this.petunjuk});

  final String judul;
  final String petunjuk;

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
// Tidak mengubah daftar sendiri. Laporan valid dikembalikan lewat Navigator.pop
// supaya hanya satu tempat (HalamanUtama) yang memegang dan mengubah data.
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

  // Urutan: validasi -> buat objek -> cek laporan serupa (F-04) -> pop.
  void _kirim(List<Laporan> daftarAda) {
    if (!_formKey.currentState!.validate()) {
      return; // Pesan validator tampil otomatis di bawah field.
    }
    final lokasi = _lokasiController.text.trim();

    final baru = Laporan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      kategori: _kategori!,
      lokasi: lokasi,
      deskripsi: _deskripsiController.text.trim(),
      tanggal: _tanggalHariIni(),
      status: 'Menunggu',
      fotoTerlampir: _fotoTerlampir,
      catatanPenanganan: '',
    );

    // F-04: laporan aktif (Menunggu atau Diproses) pada lokasi yang sama.
    final serupa = daftarAda
        .where((l) =>
            (l.status == 'Menunggu' || l.status == 'Diproses') &&
            l.lokasi.toLowerCase() == lokasi.toLowerCase())
        .toList();

    if (serupa.isNotEmpty) {
      Navigator.pushNamed(context, Rute.serupa, arguments: serupa);
      return;
    }

    Navigator.pop(context, baru);
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    final args = ModalRoute.of(context)?.settings.arguments;
    final daftarAda = args is List<Laporan> ? args : <Laporan>[];

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
              onPressed: () => _kirim(daftarAda),
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
// Nama pelapor tidak ada pada model dan tidak ditampilkan (NF-03).
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
                            subtitle: Text('${l.deskripsi}\n${l.tanggal}'),
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
// Halaman detail laporan (route '/detail'): F-03, F-06 (simulasi), F-08.
// Layar ini tidak mengubah daftar. Ia hanya mengembalikan HasilDetail lewat pop.
// ---------------------------------------------------------------------------
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  Future<void> _ubahStatus(BuildContext context, Laporan laporan) async {
    final hasil = await showDialog<Laporan>(
      context: context,
      builder: (_) => _DialogUbahStatus(laporan: laporan),
    );
    if (hasil != null && context.mounted) {
      Navigator.pop(context, HasilDetail(AksiDetail.ubah, hasil));
    }
  }

  // Konfirmasi dahulu, baru kembalikan permintaan hapus ke daftar.
  Future<void> _konfirmasiBatal(BuildContext context, Laporan laporan) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Batalkan laporan?'),
        content: Text(
          'Laporan "${laporan.judul}" akan dihapus dari daftar dan tidak lagi terlihat petugas.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Tidak'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, batalkan'),
          ),
        ],
      ),
    );
    if (yakin == true && context.mounted) {
      Navigator.pop(context, HasilDetail(AksiDetail.hapus, laporan));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final laporan = args is Laporan ? args : null;
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Laporan')),
      body: laporan == null
          ? const Center(child: Text('Data laporan tidak tersedia.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(laporan.judul, style: teks.headlineSmall),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChipStatus(laporan.status),
                ),
                const SizedBox(height: 16),
                Text('Kategori: ${laporan.kategori}'),
                const SizedBox(height: 4),
                Text('Lokasi: ${laporan.lokasi}'),
                const SizedBox(height: 4),
                Text('Tanggal: ${laporan.tanggal}'),
                const SizedBox(height: 12),
                Text(laporan.deskripsi),
                if (laporan.fotoTerlampir) ...[
                  const SizedBox(height: 12),
                  Container(
                    height: 96,
                    alignment: Alignment.center,
                    color: warna.surfaceContainerHighest,
                    child: const Text('Foto terlampir (simulasi)'),
                  ),
                ],
                if (laporan.catatanPenanganan.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text('Catatan penanganan', style: teks.titleSmall),
                  Text(laporan.catatanPenanganan),
                ],
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () => _ubahStatus(context, laporan),
                  child: const Text('Ubah status (simulasi petugas)'),
                ),
                // F-08: hanya laporan yang masih Menunggu yang boleh dibatalkan.
                if (laporan.status == 'Menunggu') ...[
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => _konfirmasiBatal(context, laporan),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: warna.error,
                    ),
                    child: const Text('Batalkan laporan'),
                  ),
                ],
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ],
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dialog ubah status (F-06). StatefulWidget sendiri agar controller catatan
// bisa dibersihkan pada dispose. Mengembalikan Laporan baru atau null (batal).
// ---------------------------------------------------------------------------
class _DialogUbahStatus extends StatefulWidget {
  const _DialogUbahStatus({required this.laporan});

  final Laporan laporan;

  @override
  State<_DialogUbahStatus> createState() => _DialogUbahStatusState();
}

class _DialogUbahStatusState extends State<_DialogUbahStatus> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _catatanController =
      TextEditingController(text: widget.laporan.catatanPenanganan);
  late String _status = widget.laporan.status;

  @override
  void dispose() {
    _catatanController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.pop(
      context,
      widget.laporan.salinDengan(
        status: _status,
        catatanPenanganan: _catatanController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah status'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: daftarStatus
                  .map(
                    (s) => ChoiceChip(
                      label: Text(s),
                      selected: _status == s,
                      onSelected: (_) => setState(() => _status = s),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _catatanController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Catatan penanganan',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                // Status selain Menunggu wajib disertai catatan (F-06).
                if (_status != 'Menunggu' &&
                    (value == null || value.trim().isEmpty)) {
                  return 'Catatan wajib diisi untuk status $_status.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(onPressed: _simpan, child: const Text('Simpan')),
      ],
    );
  }
}
