// ============================================================================
// PAB — Tugas 7: MVP Awal dengan Data Lokal
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// Melanjutkan Tugas 5-6: Status Pesanan Saya -> Form Pemesanan -> Detail,
// kini dengan model data, state (setState), dan CRUD lokal (in-memory).
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka model data, state, dan CRUD lokal
// mengikuti pola demo-data-lokal-flutter.dart, dengan data dan konteks
// disesuaikan ke domain Glazent.pro dan layar dari Tugas 5-6.
//
// Cara menjalankan (tanpa package tambahan):
//   Jalur 1 — DartPad: https://dartpad.dev/?template=app, salin seluruh isi
//     file ini, tekan Run.
//   Jalur 2 — Flutter SDK: salin ke lib/main.dart, lalu flutter run -d chrome
//
// Skenario uji (sesuai Bagian 11 materi):
//   1. Create : tekan "Pesan Layanan Baru", isi form, kirim -> daftar bertambah.
//   2. Update : ketuk kartu -> tekan "Jadwalkan" / "Tandai Selesai" -> status
//               pada daftar berubah.
//   3. Delete : ketuk kartu -> tekan ikon tempat sampah -> dialog konfirmasi
//               tampil -> "Hapus" -> daftar berkurang.
//
// Catatan: data disimpan dalam memori (in-memory) sehingga hilang saat
// aplikasi ditutup. Persistensi dengan shared_preferences tidak diterapkan
// pada tugas ini (lihat catatan-keputusan-data.md).
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama.
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
      home: const HalamanDaftarPesanan(),
    );
  }
}

/// Model data — satu pesanan layanan Glazent.pro.
/// Field bersifat final: perubahan (mis. status) menghasilkan objek baru.
class DataPesanan {
  const DataPesanan({
    required this.id,
    required this.layanan,
    required this.alamat,
    required this.tanggal,
    required this.status,
  });

  final String id;
  final String layanan;
  final String alamat;
  final String tanggal;
  final String status;

  @override
  String toString() => 'Pesanan $layanan — $tanggal ($alamat)';

  /// Membuat salinan objek dengan field baru — digunakan pada Update.
  DataPesanan salinDengan({String? status}) {
    return DataPesanan(
      id: id,
      layanan: layanan,
      alamat: alamat,
      tanggal: tanggal,
      status: status ?? this.status,
    );
  }
}

/// Layar daftar pesanan — StatefulWidget karena menyimpan data yang berubah
/// (daftar pesanan) pada state. Layar ini adalah satu-satunya pemilik state
/// `_daftar`; layar form dan detail memintanya mengubah data melalui callback
/// yang dikirim lewat konstruktor.
class HalamanDaftarPesanan extends StatefulWidget {
  const HalamanDaftarPesanan({super.key});

  @override
  State<HalamanDaftarPesanan> createState() => _HalamanDaftarPesananState();
}

class _HalamanDaftarPesananState extends State<HalamanDaftarPesanan> {
  /// State — satu sumber data yang dibaca seluruh layar.
  final List<DataPesanan> _daftar = [];

  /// Read — menampilkan daftar dari state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan Saya')),
      body: _daftar.isEmpty
          ? const KeadaanKosong()
          : Column(
              children: [
                RingkasanPelanggan(jumlah: _daftar.length),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _daftar.length,
                    itemBuilder: (context, index) {
                      final pesanan = _daftar[index];
                      return KartuPesanan(
                        pesanan: pesanan,
                        onTap: () => _bukaDetail(pesanan),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        icon: const Icon(Icons.add),
        label: const Text('Pesan Layanan Baru'),
      ),
    );
  }

  /// Membuka form — mengirim callback `tambahPesanan` yang dapat dipanggil
  /// layar form untuk menyimpan data baru.
  void _bukaForm() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => FormPemesanan(onKirim: tambahPesanan),
      ),
    );
  }

  /// Membuka detail — mengirim callback ubah status dan hapus yang dapat
  /// dipanggil layar detail untuk meminta perubahan data.
  void _bukaDetail(DataPesanan pesanan) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => DetailPesanan(
          pesanan: pesanan,
          onUbahStatus: (status) => ubahStatus(pesanan.id, status),
          onHapus: () => _konfirmasiHapus(pesanan),
        ),
      ),
    );
  }

  /// Create — menambah pesanan dari form (callback layar form).
  void tambahPesanan(DataPesanan pesanan) {
    setState(() {
      _daftar.add(pesanan);
    });
  }

  /// Update — mengubah status pesanan (callback layar detail). Objek baru
  /// menggantikan objek lama pada posisi yang sama; `id` sebagai kunci.
  void ubahStatus(String id, String statusBaru) {
    setState(() {
      final index = _daftar.indexWhere((p) => p.id == id);
      if (index != -1) {
        _daftar[index] = _daftar[index].salinDengan(status: statusBaru);
      }
    });
  }

  /// Delete — konfirmasi dahulu; data dihapus bila disetujui. Menghasilkan
  /// true bila data dihapus agar layar detail menutup dirinya.
  Future<bool> _konfirmasiHapus(DataPesanan pesanan) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus pesanan?'),
        content: Text('Pesanan ${pesanan.layanan} akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kembali'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (yakin != true) {
      return false;
    }
    setState(() {
      _daftar.removeWhere((p) => p.id == pesanan.id);
    });
    return true;
  }
}

/// Area ringkasan atas — hierarki visual: judul tebal, keterangan redup.
class RingkasanPelanggan extends StatelessWidget {
  const RingkasanPelanggan({super.key, required this.jumlah});

  final int jumlah;

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
              '$jumlah pesanan tercatat — ketuk kartu untuk melihat detail, '
              'atau tekan tombol di bawah untuk memesan.',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu item daftar sebagai kartu — mengetuk kartu membuka detail.
class KartuPesanan extends StatelessWidget {
  const KartuPesanan({super.key, required this.pesanan, required this.onTap});

  final DataPesanan pesanan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.cleaning_services_outlined),
        title: Text(pesanan.layanan, style: textTheme.titleMedium),
        subtitle: Text(
          '${pesanan.tanggal} • ${pesanan.alamat}',
          style: textTheme.bodySmall,
        ),
        trailing: ChipStatus(status: pesanan.status),
        splashColor: colorScheme.primaryContainer,
        onTap: onTap,
      ),
    );
  }
}

/// Label status berwarna — warna dari tema melalui ternary, konsisten
/// dengan materi Pertemuan 5-6.
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
            'Tekan tombol "Pesan Layanan Baru" untuk membuat pesanan pertama.',
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Form pemesanan — validasi (Pertemuan 6) dilanjutkan dengan penyimpanan ke
/// daftar melalui callback `onKirim` yang diterima dari layar daftar.
class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key, required this.onKirim});

  /// Callback yang dipanggil saat data valid — diisi layar daftar.
  final void Function(DataPesanan pesanan) onKirim;

  @override
  State<FormPemesanan> createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  final _formKey = GlobalKey<FormState>();
  final _layananController = TextEditingController();
  final _alamatController = TextEditingController();
  final _tanggalController = TextEditingController();

  @override
  void dispose() {
    _layananController.dispose();
    _alamatController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  /// Urutan aksi: validasi -> buat data -> callback (setState di daftar)
  /// -> feedback -> kembali.
  void _kirim() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final layanan = _layananController.text.trim();
    widget.onKirim(
      DataPesanan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        layanan: layanan,
        alamat: _alamatController.text.trim(),
        tanggal: _tanggalController.text.trim(),
        status: 'menunggu',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pesanan "$layanan" disimpan.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _layananController,
                decoration: const InputDecoration(
                  labelText: 'Jenis Layanan',
                  hintText: 'cth. Cleaning Kaca Rumah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jenis layanan wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'cth. Jl. Merdeka No. 10, Sumedang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Alamat wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tanggalController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Layanan',
                  hintText: 'cth. Senin, 2 Nov',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal layanan wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _kirim,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Kirim Pemesanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Detail pesanan — menampilkan data (Pertemuan 6) ditambah aksi ubah status
/// dan hapus. Perubahan data diminta melalui callback ke layar daftar;
/// konfirmasi hapus ditampilkan di layar daftar (pemilik state).
class DetailPesanan extends StatelessWidget {
  const DetailPesanan({
    super.key,
    required this.pesanan,
    required this.onUbahStatus,
    required this.onHapus,
  });

  final DataPesanan pesanan;

  /// Callback ubah status — diisi layar daftar.
  final void Function(String status) onUbahStatus;

  /// Callback hapus (menampilkan konfirmasi, menghapus bila disetujui).
  /// Menghasilkan true bila data dihapus — layar detail menutup dirinya
  /// hanya pada kondisi tersebut; bila dibatalkan, detail tetap tampil.
  final Future<bool> Function() onHapus;

  void _ubahStatus(BuildContext context, String status) {
    onUbahStatus(status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status "${pesanan.layanan}" menjadi $status.')),
    );
    Navigator.pop(context);
  }

  Future<void> _mintaHapus(BuildContext context) async {
    final dihapus = await onHapus();
    if (dihapus && context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pesanan.layanan, style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Alamat: ${pesanan.alamat}'),
            const SizedBox(height: 4),
            Text('Tanggal: ${pesanan.tanggal}'),
            const SizedBox(height: 8),
            ChipStatus(status: pesanan.status),
            const SizedBox(height: 24),
            Row(
              children: [
                if (pesanan.status == 'menunggu')
                  FilledButton(
                    onPressed: () => _ubahStatus(context, 'dijadwalkan'),
                    child: const Text('Jadwalkan'),
                  ),
                if (pesanan.status == 'dijadwalkan')
                  FilledButton(
                    onPressed: () => _ubahStatus(context, 'selesai'),
                    child: const Text('Tandai Selesai'),
                  ),
                const Spacer(),
                IconButton(
                  tooltip: 'Hapus pesanan',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _mintaHapus(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
