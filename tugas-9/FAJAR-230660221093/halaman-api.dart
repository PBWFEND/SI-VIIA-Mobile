// ============================================================================
// PAB — Tugas 9: Implementasi Konsumsi REST API
// Berkas: halaman-api.dart — antarmuka yang memakai PesananService
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Bantuan: Claude — menyusun ulang tata letak (header ringkasan, kartu pesanan,
// tiga kondisi antarmuka yang jelas, dan form POST yang ramah pengguna)
// mengikuti pola demo-rest-api-flutter.dart, dengan tampilan melanjutkan
// Tugas 5-7 (Status Pesanan Saya).
//
// Berkas ini tidak berisi kode HTTP; seluruh pemanggilan jaringan ada pada
// service-api.dart.
//
// Cara menjalankan:
//   flutter run -d chrome
//
// Skenario uji / screenshot:
//   - Loading : tampil otomatis sekitar 1 detik saat halaman dibuka (lihat
//               jedaUji pada service-api.dart; perbesar bila perlu).
//   - Sukses  : daftar 8 pesanan dari server tampil setelah loading selesai.
//   - Error   : ubah _baseUrl pada service-api.dart menjadi alamat yang salah,
//               jalankan ulang; pesan error + tombol "Coba Lagi" tampil.
//   - POST    : tekan "Pesan Layanan Baru", isi form, kirim; tombol nonaktif
//               selama pengiriman, lalu SnackBar menampilkan id dari server.
// ============================================================================

import 'package:flutter/material.dart';

import 'service-api.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama — tema terpusat, konsisten dengan Tugas 5-7.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glazent.pro — Status Pesanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          surface: const Color(0xFFF6F8FB),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF14213D),
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      home: const HalamanDaftarPesanan(),
    );
  }
}

/// Layar daftar pesanan yang mengambil data dari REST API. Menangani tiga
/// kondisi antarmuka: loading, sukses, dan error (dengan tombol coba lagi).
class HalamanDaftarPesanan extends StatefulWidget {
  const HalamanDaftarPesanan({super.key});

  @override
  State<HalamanDaftarPesanan> createState() => _HalamanDaftarPesananState();
}

class _HalamanDaftarPesananState extends State<HalamanDaftarPesanan> {
  // State untuk tiga kondisi antarmuka.
  bool _sedangMemuat = true;
  String? _pesanError;
  List<DataPesanan> _daftar = [];

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  /// Memuat daftar dari API — dipanggil saat halaman dibuka, saat tombol
  /// muat ulang ditekan, saat "Coba Lagi" ditekan, saat pull-to-refresh, dan
  /// setelah pesanan baru berhasil dikirim.
  Future<void> _muatData() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await PesananService.ambilDaftar();
      if (!mounted) return;
      setState(() {
        _daftar = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e is ApiException ? e.pesan : 'Terjadi kesalahan: $e';
        _sedangMemuat = false;
      });
    }
  }

  /// Membuka form; bila pesanan berhasil dikirim (pop bernilai true), daftar
  /// dimuat ulang dari server.
  Future<void> _bukaForm() async {
    final berhasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(builder: (context) => const FormPemesanan()),
    );
    if (berhasil == true) {
      if (!mounted) return;
      await _muatData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Pesanan Saya',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              'Glazent.pro',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _sedangMemuat ? null : _muatData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: _bangunKonten(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        icon: const Icon(Icons.add),
        label: const Text('Pesan Layanan Baru'),
      ),
    );
  }

  /// Menentukan tampilan berdasarkan kondisi state saat ini.
  Widget _bangunKonten() {
    // Kondisi 1 — loading.
    if (_sedangMemuat) {
      return const TampilanLoading();
    }

    // Kondisi 2 — error, dengan tombol coba lagi.
    if (_pesanError != null) {
      return TampilanError(pesan: _pesanError!, onCobaLagi: _muatData);
    }

    // Kondisi 3 — data kosong.
    if (_daftar.isEmpty) {
      return TampilanKosong(onBuatPesanan: _bukaForm);
    }

    // Kondisi 4 — sukses: daftar pesanan dari server.
    return RefreshIndicator(
      onRefresh: _muatData,
      child: Center(
        child: ConstrainedBox(
          // Lebar dibatasi agar tetap nyaman dibaca pada layar desktop/web.
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: _daftar.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return KepalaDaftar(jumlah: _daftar.length);
              }
              return KartuPesanan(pesanan: _daftar[index - 1]);
            },
          ),
        ),
      ),
    );
  }
}

/// Header ringkasan di atas daftar — memberi konteks siapa pemilik pesanan
/// dan berapa banyak data yang berhasil dimuat dari server.
class KepalaDaftar extends StatelessWidget {
  const KepalaDaftar({super.key, required this.jumlah});

  final int jumlah;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, const Color(0xFF0D47A1)],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.cleaning_services,
              color: colorScheme.onPrimary,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Rani!',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$jumlah pesanan aktif tersimpan di server',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Satu item daftar: ikon layanan, nama layanan, keterangan, status berwarna,
/// dan id data dari server.
class KartuPesanan extends StatelessWidget {
  const KartuPesanan({super.key, required this.pesanan});

  final DataPesanan pesanan;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.cleaning_services_outlined,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pesanan.layanan,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pesanan.keterangan,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ChipStatus(status: pesanan.status),
                      const Spacer(),
                      Text(
                        'ID ${pesanan.id}',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Label status berwarna — warna dari tema melalui ternary (Pertemuan 5).
class ChipStatus extends StatelessWidget {
  const ChipStatus({super.key, required this.status});

  final String status;

  /// Tampilan awal huruf kapital agar rapi, tanpa mengubah nilai asli data.
  String get _label {
    if (status.isEmpty) return '-';
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (Color latar, Color teks) = status == 'selesai'
        ? (colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer)
        : status == 'dijadwalkan'
        ? (colorScheme.primaryContainer, colorScheme.onPrimaryContainer)
        : (colorScheme.secondaryContainer, colorScheme.onSecondaryContainer);
    return Chip(
      label: Text(_label),
      backgroundColor: latar,
      labelStyle: TextStyle(
        color: teks,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide.none,
    );
  }
}

/// Kondisi loading — indikator berputar disertai teks agar jelas bahwa
/// aplikasi sedang menghubungi server.
class TampilanLoading extends StatelessWidget {
  const TampilanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(strokeWidth: 5),
          ),
          const SizedBox(height: 24),
          Text(
            'Memuat pesanan...',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Menghubungi server, mohon tunggu sebentar.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Kondisi error — pesan informatif dan tombol "Coba Lagi".
class TampilanError extends StatelessWidget {
  const TampilanError({
    super.key,
    required this.pesan,
    required this.onCobaLagi,
  });

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cloud_off,
                  size: 34,
                  color: colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Gagal Memuat Pesanan',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                pesan,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onCobaLagi,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
              const SizedBox(height: 12),
              Text(
                'Periksa koneksi internet Anda, lalu coba lagi.',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kondisi kosong — layar tidak pernah putih tanpa penjelasan.
class TampilanKosong extends StatelessWidget {
  const TampilanKosong({super.key, required this.onBuatPesanan});

  final VoidCallback onBuatPesanan;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'Belum ada pesanan',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pesanan yang Anda kirim akan muncul di halaman ini.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onBuatPesanan,
              icon: const Icon(Icons.add),
              label: const Text('Buat Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Form pemesanan — mengirim pesanan baru melalui POST (F-01). Mengembalikan
/// `true` melalui Navigator.pop bila pengiriman berhasil.
class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key});

  @override
  State<FormPemesanan> createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  /// Pilihan layanan Glazent.pro — mengurangi salah ketik dibanding input
  /// bebas, sehingga payload POST selalu konsisten.
  static const List<String> _pilihanLayanan = [
    'Cleaning Kaca Rumah',
    'Cleaning Kaca Facade Gedung',
    'Nanocoating Kaca Shower',
    'Cleaning Kanopi',
    'Nanocoating Kaca Mobil',
  ];

  final _formKey = GlobalKey<FormState>();
  final _alamatController = TextEditingController();
  final _tanggalController = TextEditingController();

  String? _layanan;
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _alamatController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  /// Memilih tanggal lewat date picker, lalu menuliskannya dalam format
  /// Indonesia agar mudah dibaca pada daftar pesanan.
  Future<void> _pilihTanggal() async {
    final sekarang = DateTime.now();
    final pilihan = await showDatePicker(
      context: context,
      initialDate: sekarang,
      firstDate: sekarang,
      lastDate: sekarang.add(const Duration(days: 365)),
      helpText: 'Pilih tanggal layanan',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (pilihan == null) return;
    _tanggalController.text = _formatTanggal(pilihan);
  }

  String _formatTanggal(DateTime tanggal) {
    const namaHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const namaBulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${namaHari[tanggal.weekday - 1]}, ${tanggal.day} '
        '${namaBulan[tanggal.month - 1]} ${tanggal.year}';
  }

  /// Urutan aksi: validasi -> nonaktifkan tombol -> POST -> feedback.
  Future<void> _kirim() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    try {
      final hasil = await PesananService.kirimPesanan(
        layanan: _layanan!,
        alamat: _alamatController.text.trim(),
        tanggal: _tanggalController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pesanan "${hasil.layanan}" diterima server (ID ${hasil.id}).',
                ),
              ),
            ],
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMengirim = false;
      });
      final colorScheme = Theme.of(context).colorScheme;
      final pesan = e is ApiException ? e.pesan : 'Terjadi kesalahan: $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(pesan, style: TextStyle(color: colorScheme.onError)),
          backgroundColor: colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Layanan Baru')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              children: [
                Text(
                  'Detail Layanan',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lengkapi data di bawah. Status awal pesanan adalah '
                  '"menunggu".',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Layanan',
                    prefixIcon: Icon(Icons.home_repair_service_outlined),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Pilih layanan'),
                  items: _pilihanLayanan
                      .map(
                        (layanan) => DropdownMenuItem<String>(
                          value: layanan,
                          child: Text(layanan),
                        ),
                      )
                      .toList(),
                  onChanged: _sedangMengirim
                      ? null
                      : (nilai) => setState(() => _layanan = nilai),
                  validator: (nilai) =>
                      nilai == null ? 'Jenis layanan wajib dipilih.' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _alamatController,
                  enabled: !_sedangMengirim,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    hintText: 'cth. Jl. Merdeka No. 10, Sumedang',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Alamat wajib diisi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _tanggalController,
                  enabled: !_sedangMengirim,
                  readOnly: true,
                  onTap: _pilihTanggal,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Layanan',
                    hintText: 'Pilih tanggal',
                    prefixIcon: Icon(Icons.event_outlined),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Tanggal layanan wajib diisi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    // Tombol dinonaktifkan selama pengiriman agar penekanan
                    // ganda tidak membuat pesanan duplikat.
                    onPressed: _sedangMengirim ? null : _kirim,
                    icon: _sedangMengirim
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_outlined),
                    label: Text(
                      _sedangMengirim ? 'Mengirim...' : 'Kirim Pesanan',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Server yang dipakai adalah API tiruan '
                          '(jsonplaceholder), sehingga pesanan baru tidak '
                          'tersimpan permanen.',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
