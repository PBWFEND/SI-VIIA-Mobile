import 'package:flutter/material.dart';

void main() {
  runApp(const SiRakusApp());
}

/// Model buku sesuai dengan field pada model-data.md.
class DataBuku {
  const DataBuku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahunTerbit,
    required this.kategori,
    required this.ringkasan,
    required this.stok,
  });

  final String id;
  final String judul;
  final String penulis;
  final String penerbit;
  final int tahunTerbit;
  final String kategori;
  final String ringkasan;
  final int stok;

  /// Status diturunkan dari jumlah stok agar tidak bertentangan.
  String get status => stok > 0 ? 'Tersedia' : 'Stok habis';

  @override
  String toString() => '$judul — $penulis ($tahunTerbit), stok: $stok';
}

class SiRakusApp extends StatelessWidget {
  const SiRakusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI RAKUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HalamanCrudBuku(),
    );
  }
}

/// Layar ini mengelola DATA CONTOH secara lokal untuk latihan CRUD.
/// Operasi ini bukan pengelolaan katalog resmi perpustakaan (F-07).
class HalamanCrudBuku extends StatefulWidget {
  const HalamanCrudBuku({super.key});

  @override
  State<HalamanCrudBuku> createState() => _HalamanCrudBukuState();
}

class _HalamanCrudBukuState extends State<HalamanCrudBuku> {
  final TextEditingController _pencarianController = TextEditingController();

  // READ: data awal dibaca dari List yang berada di dalam State.
  final List<DataBuku> _daftarBuku = [
    const DataBuku(
      id: 'buku-001',
      judul: 'Dasar-Dasar Pemrograman',
      penulis: 'Andi Pratama',
      penerbit: 'Pustaka Kampus',
      tahunTerbit: 2023,
      kategori: 'Informatika',
      ringkasan: 'Pengenalan algoritma, variabel, percabangan, dan perulangan.',
      stok: 3,
    ),
    const DataBuku(
      id: 'buku-002',
      judul: 'Pengantar Basis Data',
      penulis: 'Siti Rahmawati',
      penerbit: 'Media Ilmu',
      tahunTerbit: 2022,
      kategori: 'Informatika',
      ringkasan: 'Pengenalan konsep basis data, tabel, relasi, dan SQL.',
      stok: 0,
    ),
  ];

  String _kataKunci = '';
  String _kategoriAktif = 'Semua';

  List<DataBuku> get _bukuTampil {
    final kategoriUnik = _daftarBuku
        .map((buku) => buku.kategori)
        .toSet()
        .toList();
    final kategoriValid = kategoriUnik.contains(_kategoriAktif)
        ? _kategoriAktif
        : 'Semua';

    return _daftarBuku.where((buku) {
      final cocokKataKunci =
          buku.judul.toLowerCase().contains(_kataKunci.toLowerCase()) ||
          buku.penulis.toLowerCase().contains(_kataKunci.toLowerCase());
      final cocokKategori =
          kategoriValid == 'Semua' || buku.kategori == kategoriValid;
      return cocokKataKunci && cocokKategori;
    }).toList();
  }

  @override
  void dispose() {
    _pencarianController.dispose();
    super.dispose();
  }

  String _buatIdUnik() {
    // Timestamp mikrodetik digunakan sebagai ID sederhana tanpa package tambahan.
    var id = DateTime.now().microsecondsSinceEpoch.toString();
    while (_daftarBuku.any((buku) => buku.id == id)) {
      id = '${DateTime.now().microsecondsSinceEpoch}${_daftarBuku.length}';
    }
    return id;
  }

  // CREATE: membuka form, menerima data valid, lalu menambahkannya ke List.
  Future<void> _tambahBuku() async {
    final bukuBaru = await showDialog<DataBuku>(
      context: context,
      builder: (context) => FormBukuDialog(idBaru: _buatIdUnik()),
    );

    if (!mounted || bukuBaru == null) return;

    setState(() {
      _daftarBuku.add(bukuBaru);
    });
    _tampilkanPesan('Data buku berhasil ditambahkan ke daftar contoh.');
  }

  // UPDATE: formulir mengembalikan objek baru dengan ID yang sama.
  Future<void> _ubahBuku(DataBuku bukuLama) async {
    final bukuBaru = await showDialog<DataBuku>(
      context: context,
      builder: (context) => FormBukuDialog(buku: bukuLama),
    );

    if (!mounted || bukuBaru == null) return;

    final index = _daftarBuku.indexWhere((item) => item.id == bukuLama.id);
    if (index == -1) {
      _tampilkanPesan('Data buku tidak ditemukan.');
      return;
    }

    setState(() {
      _daftarBuku[index] = bukuBaru;
    });

    _tampilkanPesan('Data buku berhasil diubah di daftar contoh.');
  }

  // DELETE: tampilkan AlertDialog sebelum data boleh dihapus.
  Future<void> _konfirmasiHapus(DataBuku buku) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus data buku?'),
          content: Text(
            'Data contoh "${buku.judul}" akan dihapus dari daftar lokal. '
            'Penghapusan ini tidak memengaruhi katalog resmi perpustakaan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!mounted || yakin != true) return;

    setState(() {
      _daftarBuku.removeWhere((item) => item.id == buku.id);
    });

    _tampilkanPesan('Data buku berhasil dihapus dari daftar contoh.');
    ;
  }

  void _lihatDetail(DataBuku buku) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(buku.judul),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Penulis: ${buku.penulis}'),
            Text('Penerbit: ${buku.penerbit}'),
            Text('Tahun terbit: ${buku.tahunTerbit}'),
            Text('Kategori: ${buku.kategori}'),
            const SizedBox(height: 8),
            Text(buku.ringkasan),
            const SizedBox(height: 8),
            Text('Stok: ${buku.stok} (${buku.status})'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final kategoriUnik =
        _daftarBuku.map((buku) => buku.kategori).toSet().toList()..sort();
    final opsiKategori = ['Semua', ...kategoriUnik];
    final kategoriTerpilih = opsiKategori.contains(_kategoriAktif)
        ? _kategoriAktif
        : 'Semua';
    final bukuTampil = _bukuTampil;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SI RAKUS — Data Buku Lokal'),
        actions: [
          IconButton(
            tooltip: 'Informasi latihan',
            onPressed: () => _tampilkanPesan(
              'Data ini hanya dataset contoh untuk latihan CRUD lokal.',
            ),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kelola Dataset Buku Contoh',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Data lokal untuk demonstrasi Create, Read, Update, dan Delete.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _pencarianController,
                  decoration: InputDecoration(
                    labelText: 'Cari judul atau penulis',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      tooltip: 'Hapus pencarian',
                      onPressed: () {
                        _pencarianController.clear();
                        setState(() => _kataKunci = '');
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (nilai) => setState(() => _kataKunci = nilai),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: kategoriTerpilih,
                  decoration: const InputDecoration(
                    labelText: 'Filter kategori',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.filter_list),
                  ),
                  items: opsiKategori
                      .map(
                        (kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        ),
                      )
                      .toList(),
                  onChanged: (nilai) {
                    if (nilai == null) return;
                    setState(() => _kategoriAktif = nilai);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: bukuTampil.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 52,
                            color: warna.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _daftarBuku.isEmpty
                                ? 'Belum ada data buku'
                                : 'Buku tidak ditemukan',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tambahkan buku atau ubah kata kunci pencarian.',
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
                    itemCount: bukuTampil.length,
                    itemBuilder: (context, index) {
                      final buku = bukuTampil[index];
                      final tersedia = buku.stok > 0;
                      final warnaStatus = tersedia
                          ? warna.primaryContainer
                          : warna.surfaceContainerHighest;
                      final warnaTeks = tersedia
                          ? warna.onPrimaryContainer
                          : warna.onSurfaceVariant;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  width: 48,
                                  height: 58,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: warna.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.menu_book,
                                    color: warna.onSurfaceVariant,
                                  ),
                                ),
                                title: Text(
                                  buku.judul,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '${buku.penulis}\n${buku.penerbit} · ${buku.tahunTerbit}',
                                ),
                                isThreeLine: true,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Chip(
                                    label: Text(buku.status),
                                    backgroundColor: warnaStatus,
                                    labelStyle: TextStyle(color: warnaTeks),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Text('Stok: ${buku.stok}'),
                                  Text('Kategori: ${buku.kategori}'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => _lihatDetail(buku),
                                    icon: const Icon(Icons.visibility_outlined),
                                    label: const Text('Detail'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _ubahBuku(buku),
                                    icon: const Icon(Icons.edit_outlined),
                                    label: const Text('Ubah'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _konfirmasiHapus(buku),
                                    icon: const Icon(Icons.delete_outline),
                                    label: const Text('Hapus'),
                                  ),
                                ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahBuku,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
      ),
    );
  }
}

/// Dialog form dipakai untuk Create dan Update.
class FormBukuDialog extends StatefulWidget {
  const FormBukuDialog({super.key, this.buku, this.idBaru});

  final DataBuku? buku;
  final String? idBaru;

  @override
  State<FormBukuDialog> createState() => _FormBukuDialogState();
}

class _FormBukuDialogState extends State<FormBukuDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulController;
  late final TextEditingController _penulisController;
  late final TextEditingController _penerbitController;
  late final TextEditingController _tahunController;
  late final TextEditingController _kategoriController;
  late final TextEditingController _ringkasanController;
  late final TextEditingController _stokController;

  @override
  void initState() {
    super.initState();
    final buku = widget.buku;
    _judulController = TextEditingController(text: buku?.judul ?? '');
    _penulisController = TextEditingController(text: buku?.penulis ?? '');
    _penerbitController = TextEditingController(text: buku?.penerbit ?? '');
    _tahunController = TextEditingController(
      text: buku?.tahunTerbit.toString() ?? '2024',
    );
    _kategoriController = TextEditingController(
      text: buku?.kategori ?? 'Informatika',
    );
    _ringkasanController = TextEditingController(text: buku?.ringkasan ?? '');
    _stokController = TextEditingController(text: buku?.stok.toString() ?? '1');
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _penerbitController.dispose();
    _tahunController.dispose();
    _kategoriController.dispose();
    _ringkasanController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? nilai, String namaField) {
    if (nilai == null || nilai.trim().isEmpty) {
      return '$namaField wajib diisi.';
    }
    return null;
  }

  void _simpanForm() {
    if (!_formKey.currentState!.validate()) return;

    final tahun = int.parse(_tahunController.text.trim());
    final stok = int.parse(_stokController.text.trim());

    final hasil = DataBuku(
      id:
          widget.buku?.id ??
          widget.idBaru ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      penerbit: _penerbitController.text.trim(),
      tahunTerbit: tahun,
      kategori: _kategoriController.text.trim(),
      ringkasan: _ringkasanController.text.trim(),
      stok: stok,
    );

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    final sedangEdit = widget.buku != null;

    return AlertDialog(
      title: Text(sedangEdit ? 'Ubah Data Buku' : 'Tambah Data Buku'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _field(_judulController, 'Judul buku'),
                _field(_penulisController, 'Penulis'),
                _field(_penerbitController, 'Penerbit'),
                _field(
                  _tahunController,
                  'Tahun terbit',
                  keyboardType: TextInputType.number,
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Tahun terbit wajib diisi.';
                    }
                    final angka = int.tryParse(nilai.trim());
                    if (angka == null || angka < 1000 || angka > 2100) {
                      return 'Masukkan tahun antara 1000–2100.';
                    }
                    return null;
                  },
                ),
                _field(_kategoriController, 'Kategori'),
                _field(_ringkasanController, 'Ringkasan', maxLines: 3),
                _field(
                  _stokController,
                  'Jumlah stok',
                  keyboardType: TextInputType.number,
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Jumlah stok wajib diisi.';
                    }
                    final angka = int.tryParse(nilai.trim());
                    if (angka == null || angka < 0) {
                      return 'Stok harus bilangan bulat minimal 0.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _simpanForm,
          child: Text(sedangEdit ? 'Simpan Perubahan' : 'Tambah'),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator ?? (nilai) => _wajibDiisi(nilai, label),
      ),
    );
  }
}
