import 'package:flutter/material.dart';

void main() {
  runApp(const SiFaskamApp());
}

class Pengaduan {
  final String id;
  final String kategori;
  final String lokasi;
  final String deskripsi;
  final String status;

  Pengaduan({
    String? id,
    required this.kategori,
    required this.lokasi,
    required this.deskripsi,
    this.status = 'Menunggu',
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  Pengaduan copyWith({
    String? kategori,
    String? lokasi,
    String? deskripsi,
    String? status,
  }) {
    return Pengaduan(
      id: id,
      kategori: kategori ?? this.kategori,
      lokasi: lokasi ?? this.lokasi,
      deskripsi: deskripsi ?? this.deskripsi,
      status: status ?? this.status,
    );
  }
}

class SiFaskamApp extends StatelessWidget {
  const SiFaskamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI-FASKAM',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController pencarianController = TextEditingController();

  final List<Pengaduan> daftarPengaduan = [
    Pengaduan(
      kategori: 'Fasilitas Kelas',
      lokasi: 'Gedung A - Ruang 101',
      deskripsi: 'Proyektor tidak dapat digunakan.',
      status: 'Diproses',
    ),
    Pengaduan(
      kategori: 'Toilet',
      lokasi: 'Gedung B - Lantai 2',
      deskripsi: 'Keran air mengalami kerusakan.',
    ),
  ];

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  Future<void> tambahPengaduan() async {
    final hasil = await Navigator.push<Pengaduan>(
      context,
      MaterialPageRoute(builder: (_) => const FormPengaduan()),
    );

    if (!mounted || hasil == null) return;

    setState(() => daftarPengaduan.insert(0, hasil));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengaduan berhasil ditambahkan.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> editPengaduan(Pengaduan item) async {
    final hasil = await Navigator.push<Pengaduan>(
      context,
      MaterialPageRoute(
        builder: (_) => FormPengaduan(pengaduanAwal: item),
      ),
    );

    if (!mounted || hasil == null) return;

    final index = daftarPengaduan.indexWhere((e) => e.id == item.id);
    if (index == -1) return;

    setState(() => daftarPengaduan[index] = hasil);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengaduan berhasil diperbarui.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> hapusPengaduan(Pengaduan item) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Pengaduan?'),
        content: Text('Yakin ingin menghapus pengaduan "${item.kategori}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (yakin == true && mounted) {
      setState(() => daftarPengaduan.removeWhere((e) => e.id == item.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengaduan berhasil dihapus.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void ubahStatus(Pengaduan item, String status) {
    final index = daftarPengaduan.indexWhere((e) => e.id == item.id);
    if (index == -1) return;

    setState(() {
      daftarPengaduan[index] = item.copyWith(status: status);
    });
  }

  Color warnaStatus(String status) {
    switch (status) {
      case 'Menunggu':
        return Colors.orange.shade100;
      case 'Diproses':
        return Colors.blue.shade100;
      case 'Selesai':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final kataKunci = pencarianController.text.toLowerCase().trim();
    final hasil = daftarPengaduan.where((item) {
      return item.kategori.toLowerCase().contains(kataKunci) ||
          item.lokasi.toLowerCase().contains(kataKunci) ||
          item.deskripsi.toLowerCase().contains(kataKunci) ||
          item.status.toLowerCase().contains(kataKunci);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SI-FASKAM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sistem Informasi Pengaduan Fasilitas Kampus',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pantau dan sampaikan pengaduan fasilitas kampus dengan mudah.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pencarianController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari pengaduan...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    pencarianController.clear();
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Pengaduan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('${daftarPengaduan.length} Pengaduan'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: hasil.isEmpty
                  ? const Center(child: Text('Pengaduan tidak ditemukan.'))
                  : ListView.builder(
                      itemCount: hasil.length,
                      itemBuilder: (context, index) {
                        final item = hasil[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE3F2FD),
                              child: Icon(Icons.report_problem, color: Colors.blue),
                            ),
                            title: Text(
                              item.kategori,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(item.lokasi),
                                const SizedBox(height: 5),
                                Text(
                                  item.deskripsi,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Chip(
                                  label: Text(item.status),
                                  backgroundColor: warnaStatus(item.status),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              tooltip: 'Kelola Pengaduan',
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  editPengaduan(item);
                                } else if (value == 'hapus') {
                                  hapusPengaduan(item);
                                } else {
                                  ubahStatus(item, value);
                                }
                              },
                              itemBuilder: (_) => [
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Text('Edit Pengaduan'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'hapus',
                                  child: Row(
                                    children: const [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 10),
                                      Text('Hapus Pengaduan'),
                                    ],
                                  ),
                                ),
                                const PopupMenuDivider(),
                                const PopupMenuItem(
                                  value: 'Menunggu',
                                  child: Text('Ubah status: Menunggu'),
                                ),
                                const PopupMenuItem(
                                  value: 'Diproses',
                                  child: Text('Ubah status: Diproses'),
                                ),
                                const PopupMenuItem(
                                  value: 'Selesai',
                                  child: Text('Ubah status: Selesai'),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HalamanDetail(pengaduan: item),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: tambahPengaduan,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Buat Pengaduan'),
      ),
    );
  }
}

class FormPengaduan extends StatefulWidget {
  final Pengaduan? pengaduanAwal;

  const FormPengaduan({super.key, this.pengaduanAwal});

  @override
  State<FormPengaduan> createState() => _FormPengaduanState();
}

class _FormPengaduanState extends State<FormPengaduan> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController lokasiController;
  late final TextEditingController deskripsiController;
  String? kategoriTerpilih;
  bool sedangMengirim = false;

  final List<String> daftarKategori = [
    'Fasilitas Kelas',
    'Toilet',
    'Laboratorium',
    'Perpustakaan',
    'Area Parkir',
    'Fasilitas Lainnya',
  ];

  bool get modeEdit => widget.pengaduanAwal != null;

  @override
  void initState() {
    super.initState();
    lokasiController = TextEditingController(
      text: widget.pengaduanAwal?.lokasi ?? '',
    );
    deskripsiController = TextEditingController(
      text: widget.pengaduanAwal?.deskripsi ?? '',
    );
    kategoriTerpilih = widget.pengaduanAwal?.kategori;
  }

  @override
  void dispose() {
    lokasiController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> kirimPengaduan() async {
    if (sedangMengirim) return;
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi semua data pengaduan terlebih dahulu.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => sedangMengirim = true);

    final dataBaru = Pengaduan(
      id: widget.pengaduanAwal?.id,
      kategori: kategoriTerpilih!,
      lokasi: lokasiController.text.trim(),
      deskripsi: deskripsiController.text.trim(),
      status: widget.pengaduanAwal?.status ?? 'Menunggu',
    );

    try {
      if (modeEdit) {
        Navigator.pop(context, dataBaru);
        return;
      }

      final hasil = await Navigator.push<Pengaduan>(
        context,
        MaterialPageRoute(
          builder: (_) => HalamanKonfirmasi(pengaduan: dataBaru),
        ),
      );

      if (!mounted) return;
      if (hasil != null) {
        Navigator.pop(context, hasil);
      }
    } finally {
      if (mounted) setState(() => sedangMengirim = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modeEdit ? 'Edit Pengaduan' : 'Formulir Pengaduan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                modeEdit ? 'Ubah Data Pengaduan' : 'Buat Pengaduan Baru',
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lengkapi informasi pengaduan fasilitas kampus.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 25),
              const Text('Kategori Pengaduan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: kategoriTerpilih,
                isExpanded: true,
                decoration: const InputDecoration(
                  hintText: 'Pilih kategori pengaduan',
                  prefixIcon: Icon(Icons.category),
                ),
                items: daftarKategori
                    .map((kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => kategoriTerpilih = value),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Kategori wajib dipilih.' : null,
              ),
              const SizedBox(height: 20),
              const Text('Lokasi Fasilitas',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: lokasiController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Contoh: Gedung A - Ruang 101',
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Lokasi fasilitas wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 20),
              const Text('Deskripsi Pengaduan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Jelaskan masalah fasilitas kampus...',
                  alignLabelWithHint: true,
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
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: sedangMengirim ? null : kirimPengaduan,
                  icon: sedangMengirim
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(modeEdit ? Icons.save : Icons.send),
                  label: Text(
                    sedangMengirim
                        ? 'Memproses...'
                        : modeEdit
                            ? 'Simpan Perubahan'
                            : 'Kirim Pengaduan',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HalamanKonfirmasi extends StatelessWidget {
  final Pengaduan pengaduan;

  const HalamanKonfirmasi({super.key, required this.pengaduan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pengaduan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Icon(Icons.check_circle, color: Colors.green, size: 85),
            const SizedBox(height: 18),
            const Text(
              'Periksa Pengaduan Anda',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kategori Pengaduan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(pengaduan.kategori),
                    const Divider(height: 25),
                    const Text('Lokasi Fasilitas',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(pengaduan.lokasi),
                    const Divider(height: 25),
                    const Text('Deskripsi Pengaduan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(pengaduan.deskripsi),
                    const Divider(height: 25),
                    const Text('Status',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Chip(
                      label: Text('Menunggu'),
                      backgroundColor: Color(0xFFFFE0B2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop<Pengaduan>(context, pengaduan),
                icon: const Icon(Icons.check),
                label: const Text('Selesai dan Simpan Pengaduan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali ke Formulir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanDetail extends StatelessWidget {
  final Pengaduan pengaduan;

  const HalamanDetail({super.key, required this.pengaduan});

  Color warnaStatus(String status) {
    switch (status) {
      case 'Menunggu':
        return Colors.orange.shade100;
      case 'Diproses':
        return Colors.blue.shade100;
      case 'Selesai':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengaduan')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pengaduan',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kategori Pengaduan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(pengaduan.kategori),
                    const Divider(height: 28),
                    const Text('Lokasi Fasilitas',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(pengaduan.lokasi),
                    const Divider(height: 28),
                    const Text('Deskripsi Pengaduan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(pengaduan.deskripsi),
                    const Divider(height: 28),
                    const Text('Status Pengaduan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(pengaduan.status),
                      backgroundColor: warnaStatus(pengaduan.status),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
