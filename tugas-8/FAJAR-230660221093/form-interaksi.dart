// ============================================================================
// PAB — Tugas 6: Navigation Flow dan Interaksi
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// Alur: Status Pesanan Saya (/) -> Form Pemesanan (/form) -> kembali
//       Status Pesanan Saya (/) -> Detail Pesanan (/detail) -> kembali
// ============================================================================
//
//
// Cara menjalankan:
//   Jalur 1 — DartPad: https://dartpad.dev/?template=app, salin seluruh isi
//     file ini, tekan Run.
//   Jalur 2 — Flutter SDK: salin ke lib/main.dart, lalu flutter run -d chrome
//
// Skenario uji (sesuai Bagian 11 materi):
//   1. Kirim form pemesanan kosong -> pesan validator tampil di tiap field.
//   2. Isi form lengkap, kirim -> SnackBar tampil, kembali ke daftar.
//   3. Ketuk salah satu kartu pesanan -> detail terbuka dengan data yang
//      sama; tombol Kembali mengembalikan ke daftar tanpa menutup aplikasi.
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama. Peta route didefinisikan sekali di sini — setiap layar
/// dirujuk melalui namanya, bukan melalui konstruktor tersebar.
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
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanStatusPesanan(),
        '/form': (context) => const FormPemesanan(),
        '/detail': (context) => const DetailPesanan(),
      },
    );
  }
}

/// Satu data pesanan — struktur sederhana; model formal menjadi materi
/// Pertemuan 7 (state dan data lokal).
class DataPesanan {
  const DataPesanan({
    required this.layanan,
    required this.tanggal,
    required this.status,
  });

  final String layanan;
  final String tanggal;
  final String status;
}

/// Data statis untuk prototype — pada Minggu 7 digantikan data lokal.
const List<DataPesanan> daftarPesanan = [
  DataPesanan(
    layanan: 'Cleaning Kaca Rumah',
    tanggal: 'Senin, 20 Okt',
    status: 'menunggu',
  ),
  DataPesanan(
    layanan: 'Nanocoating Kaca Shower',
    tanggal: 'Rabu, 22 Okt',
    status: 'dijadwalkan',
  ),
  DataPesanan(
    layanan: 'Cleaning Kanopi',
    tanggal: 'Jumat, 10 Okt',
    status: 'selesai',
  ),
];

/// Layar utama — memenuhi F-02 (melihat status pesanan terkini) dan
/// menjadi titik masuk menuju F-01 (mengajukan pemesanan).
class HalamanStatusPesanan extends StatelessWidget {
  const HalamanStatusPesanan({super.key});

  /// Ubah menjadi true untuk mengamati keadaan kosong.
  static const bool daftarKosong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan Saya')),
      body: daftarKosong || daftarPesanan.isEmpty
          ? const KeadaanKosong()
          : Column(
              children: [
                const RingkasanPelanggan(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: daftarPesanan.length,
                    itemBuilder: (context, index) {
                      return KartuPesanan(pesanan: daftarPesanan[index]);
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Berpindah ke form melalui route bernama — nama route berasal
          // dari peta `routes` pada MyApp.
          Navigator.pushNamed(context, '/form');
        },
        icon: const Icon(Icons.add),
        label: const Text('Pesan Layanan Baru'),
      ),
    );
  }
}

/// Area ringkasan atas — hierarki visual: judul tebal, keterangan redup.
class RingkasanPelanggan extends StatelessWidget {
  const RingkasanPelanggan({super.key});

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
              '${daftarPesanan.length} pesanan aktif — ketuk kartu untuk '
              'melihat detail, atau tekan tombol di bawah untuk memesan.',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu item daftar sebagai kartu — mengetuk kartu membuka detail dengan
/// data pesanan sebagai arguments.
class KartuPesanan extends StatelessWidget {
  const KartuPesanan({super.key, required this.pesanan});

  final DataPesanan pesanan;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.cleaning_services_outlined),
        title: Text(pesanan.layanan, style: textTheme.titleMedium),
        subtitle: Text(pesanan.tanggal, style: textTheme.bodySmall),
        trailing: ChipStatus(status: pesanan.status),
        // Mengetuk kartu = navigasi dengan data; warna tertekan mengikuti
        // tema tanpa penulisan warna manual (feedback sentuhan).
        splashColor: colorScheme.primaryContainer,
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: pesanan);
        },
      ),
    );
  }
}

/// Label status berwarna — warna dari tema melalui ternary, konsisten
/// dengan materi Pertemuan 5.
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
            : (
                colorScheme.secondaryContainer,
                colorScheme.onSecondaryContainer
              );
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

/// Form pemesanan — memenuhi F-01 (mengajukan pemesanan layanan).
/// Validasi berjalan sebelum aksi kirim; feedback tampil via SnackBar.
class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key});

  @override
  State<FormPemesanan> createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  /// Kunci form — memegang status validasi seluruh field.
  final _formKey = GlobalKey<FormState>();

  /// Controller mengelola teks tiap field; dibersihkan pada dispose agar
  /// tidak terjadi kebocoran memori.
  final _jenisLayananController = TextEditingController();
  final _alamatController = TextEditingController();
  final _tanggalController = TextEditingController();

  @override
  void dispose() {
    _jenisLayananController.dispose();
    _alamatController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  /// Aksi kirim — validasi dahulu, baca input, tampilkan feedback, lalu
  /// kembali ke daftar. Penyimpanan permanen menjadi materi Pertemuan 7.
  void _kirim(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final jenisLayanan = _jenisLayananController.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pemesanan "$jenisLayanan" dikirim (simulasi).')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _jenisLayananController,
              decoration: const InputDecoration(
                labelText: 'Jenis Layanan',
                hintText: 'cth. Cleaning Kaca Rumah',
                border: OutlineInputBorder(),
              ),
              // Feedback validasi tampil otomatis di bawah field ketika
              // validator mengembalikan pesan error.
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
                hintText: 'cth. Senin, 26 Okt',
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
              onPressed: () => _kirim(context),
              icon: const Icon(Icons.send_outlined),
              label: const Text('Kirim Pemesanan'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Detail pesanan — menerima data melalui arguments route. Layar ini
/// read-only: menampilkan data yang dikirim dari daftar.
class DetailPesanan extends StatelessWidget {
  const DetailPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final pesanan = args is DataPesanan ? args : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: pesanan == null
          ? const Center(child: Text('Data pesanan tidak tersedia.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.cleaning_services_outlined),
                    title: Text(pesanan.layanan),
                    subtitle: Text(pesanan.tanggal),
                    trailing: ChipStatus(status: pesanan.status),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  onPressed: () {
                    // Kembali ke daftar — pop menghapus layar teratas dari
                    // stack Navigator.
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali ke Daftar'),
                ),
              ],
            ),
    );
  }
}
