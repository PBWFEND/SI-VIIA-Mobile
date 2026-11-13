import 'package:flutter/material.dart';

void main() {
  runApp(const CrudLokalApp());
}

class Buku {
  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
    required this.rak,
  });

  final int id;
  final String judul;
  final String penulis;
  final String kategori;
  final String status;
  final String rak;

  Buku copyWith({String? status}) {
    return Buku(
      id: id,
      judul: judul,
      penulis: penulis,
      kategori: kategori,
      status: status ?? this.status,
      rak: rak,
    );
  }

  @override
  String toString() {
    return 'Buku(id: $id, judul: $judul, status: $status, rak: $rak)';
  }
}

class CrudLokalApp extends StatelessWidget {
  const CrudLokalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8BBF88)),
        useMaterial3: true,
      ),
      home: const DaftarBukuLayar(),
    );
  }
}

class DaftarBukuLayar extends StatefulWidget {
  const DaftarBukuLayar({super.key});

  @override
  State<DaftarBukuLayar> createState() => _DaftarBukuLayarState();
}

class _DaftarBukuLayarState extends State<DaftarBukuLayar> {
  final List<Buku> _daftarBuku = [
    const Buku(
      id: 1,
      judul: 'Pemrograman Aplikasi Bergerak',
      penulis: 'R. Kurniawan',
      kategori: 'Teknologi',
      status: 'Tersedia',
      rak: 'A-12',
    ),
    const Buku(
      id: 2,
      judul: 'Analisis dan Perancangan Sistem',
      penulis: 'S. Pratama',
      kategori: 'Sistem Informasi',
      status: 'Terbatas',
      rak: 'B-04',
    ),
    const Buku(
      id: 3,
      judul: 'Dasar-Dasar Basis Data',
      penulis: 'N. Wijaya',
      kategori: 'Teknologi',
      status: 'Tersedia',
      rak: 'A-08',
    ),
  ];

  int _nextId = 4;

  Future<void> _tambahBuku() async {
    final data = await showDialog<_BukuFormResult>(
      context: context,
      builder: (context) => const _BukuFormDialog(),
    );

    if (data == null) {
      return;
    }

    setState(() {
      _daftarBuku.add(
        Buku(
          id: _nextId++,
          judul: data.judul,
          penulis: data.penulis,
          kategori: data.kategori,
          status: data.status,
          rak: data.rak,
        ),
      );
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Buku "${data.judul}" berhasil ditambahkan.')),
      );
    }
  }

  Future<void> _ubahStatus(Buku buku) async {
    final statusBaru = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Ubah status buku'),
        children: [
          for (final status in ['Tersedia', 'Terbatas', 'Tidak tersedia'])
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, status),
              child: Text(status),
            ),
        ],
      ),
    );

    if (statusBaru == null) {
      return;
    }

    final index = _daftarBuku.indexWhere((item) => item.id == buku.id);
    if (index == -1) {
      return;
    }

    setState(() {
      _daftarBuku[index] = _daftarBuku[index].copyWith(status: statusBaru);
    });
  }

  Future<void> _hapusBuku(Buku buku) async {
    final disetujui = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus buku?'),
        content: Text('Data "${buku.judul}" akan dihapus dari daftar lokal.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (disetujui != true) {
      return;
    }

    setState(() {
      _daftarBuku.removeWhere((item) => item.id == buku.id);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Buku "${buku.judul}" dihapus.')),
      );
    }
  }

  Color _warnaStatus(String status, ColorScheme warna) {
    return status == 'Tersedia'
        ? warna.primary
        : status == 'Terbatas'
            ? warna.tertiary
            : warna.error;
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final tersedia = _daftarBuku.where((buku) => buku.status == 'Tersedia').length;
    final terbatas = _daftarBuku.where((buku) => buku.status == 'Terbatas').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus'),
        backgroundColor: warna.primary,
        foregroundColor: warna.onPrimary,
      ),
      body: SizedBox.expand(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ringkasan Koleksi',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: warna.primaryContainer,
                                  foregroundColor: warna.onPrimaryContainer,
                                  child: const Icon(Icons.inventory_2_outlined),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Total koleksi'),
                                    Text(
                                      '${_daftarBuku.length} buku',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: warna.secondaryContainer,
                                  foregroundColor: warna.onSecondaryContainer,
                                  child: const Icon(Icons.check_circle_outline),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Tersedia'),
                                    Text(
                                      '$tersedia buku',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: warna.tertiaryContainer,
                                  foregroundColor: warna.onTertiaryContainer,
                                  child: const Icon(Icons.hourglass_bottom_rounded),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Terbatas'),
                                    Text(
                                      '$terbatas buku',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar Buku',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text('${_daftarBuku.length} item'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _daftarBuku.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.menu_book_outlined, size: 64, color: warna.outline),
                                const SizedBox(height: 12),
                                const Text('Belum ada buku dalam daftar.'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _daftarBuku.length,
                            itemBuilder: (context, index) {
                              final buku = _daftarBuku[index];
                              final warnaStatus = _warnaStatus(buku.status, warna);
                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                elevation: 1,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 5,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: buku.status == 'Terbatas'
                                        ? warna.tertiaryContainer
                                        : warna.primaryContainer,
                                    foregroundColor: buku.status == 'Terbatas'
                                        ? warna.onTertiaryContainer
                                        : warna.onPrimaryContainer,
                                    child: Icon(
                                      buku.status == 'Terbatas'
                                          ? Icons.hourglass_bottom_rounded
                                          : Icons.menu_book_rounded,
                                    ),
                                  ),
                                  title: Text(
                                    buku.judul,
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    '${buku.kategori} • ${buku.penulis} • Rak ${buku.rak}',
                                  ),
                                  trailing: Wrap(
                                    spacing: 4,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        buku.status,
                                        style: TextStyle(
                                          color: warnaStatus,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        tooltip: 'Aksi buku',
                                        onSelected: (aksi) {
                                          if (aksi == 'ubah') {
                                            _ubahStatus(buku);
                                          } else {
                                            _hapusBuku(buku);
                                          }
                                        },
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                            value: 'ubah',
                                            child: Text('Ubah status'),
                                          ),
                                          PopupMenuItem(
                                            value: 'hapus',
                                            child: Text('Hapus buku'),
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
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahBuku,
        icon: const Icon(Icons.add),
        label: const Text('Tambah buku'),
      ),
    );
  }
}

class _BukuFormResult {
  const _BukuFormResult({
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
    required this.rak,
  });

  final String judul;
  final String penulis;
  final String kategori;
  final String status;
  final String rak;
}

class _BukuFormDialog extends StatefulWidget {
  const _BukuFormDialog();

  @override
  State<_BukuFormDialog> createState() => _BukuFormDialogState();
}

class _BukuFormDialogState extends State<_BukuFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _rakController = TextEditingController();
  String _status = 'Tersedia';

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _kategoriController.dispose();
    _rakController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(
      context,
      _BukuFormResult(
        judul: _judulController.text.trim(),
        penulis: _penulisController.text.trim(),
        kategori: _kategoriController.text.trim(),
        status: _status,
        rak: _rakController.text.trim(),
      ),
    );
  }

  String? _wajib(String? nilai, String label) {
    if (nilai == null || nilai.trim().isEmpty) {
      return '$label wajib diisi.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah buku'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (nilai) => _wajib(nilai, 'Judul'),
              ),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(labelText: 'Penulis'),
                validator: (nilai) => _wajib(nilai, 'Penulis'),
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
                validator: (nilai) => _wajib(nilai, 'Kategori'),
              ),
              TextFormField(
                controller: _rakController,
                decoration: const InputDecoration(labelText: 'Rak'),
                validator: (nilai) => _wajib(nilai, 'Rak'),
              ),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'Tersedia', child: Text('Tersedia')),
                  DropdownMenuItem(value: 'Terbatas', child: Text('Terbatas')),
                  DropdownMenuItem(
                    value: 'Tidak tersedia',
                    child: Text('Tidak tersedia'),
                  ),
                ],
                onChanged: (nilai) {
                  if (nilai != null) {
                    setState(() => _status = nilai);
                  }
                },
                validator: (nilai) => _wajib(nilai, 'Status'),
              ),
            ],
          ),
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


