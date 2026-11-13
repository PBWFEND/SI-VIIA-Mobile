import 'package:flutter/material.dart';

void main() {
  runApp(const PerpustakaanAppWeb());
}

// ==========================================
// 1. MODEL DATA BUKU (IMMUTABLE)
// ==========================================
class Buku {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final String status;

  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
  });

  Buku copyWith({
    String? id,
    String? judul,
    String? penulis,
    String? kategori,
    String? status,
  }) {
    return Buku(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      penulis: penulis ?? this.penulis,
      kategori: kategori ?? this.kategori,
      status: status ?? this.status,
    );
  }
}

// ==========================================
// 2. ROOT WIDGET & STATE MANAGEMENT
// ==========================================
class PerpustakaanAppWeb extends StatefulWidget {
  const PerpustakaanAppWeb({super.key});

  @override
  State<PerpustakaanAppWeb> createState() => _PerpustakaanAppWebState();
}

class _PerpustakaanAppWebState extends State<PerpustakaanAppWeb> {
  int _currentIndex = 0;

  // State Utama List Data Buku
  final List<Buku> _katalogBuku = [
    const Buku(
      id: '1700000000000',
      judul: 'Analisis dan Perancangan Sistem Informasi',
      penulis: 'Jogiyanto HM',
      kategori: 'Sistem Informasi',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000001',
      judul: 'Object-Oriented Programming in C++',
      penulis: 'Robert Lafore',
      kategori: 'Informatika',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000002',
      judul: 'Pengantar Psikologi Umum',
      penulis: 'S. S. Santoso',
      kategori: 'Psikologi',
      status: 'Tersedia',
    ),
    const Buku(
      id: '1700000000003',
      judul: 'Metode Penelitian Kualitatif',
      penulis: 'Lexy J. Moleong',
      kategori: 'Metodologi',
      status: 'Sedang Dipinjam',
    ),
    const Buku(
      id: '1700000000004',
      judul: 'Dasar Sistem Informasi',
      penulis: 'Andi Wijaya',
      kategori: 'Sistem Informasi',
      status: 'Tersedia',
    ),
  ];

  // Fungsi Tambah Buku Baru
  void _tambahBuku(Buku bukuBaru) {
    setState(() {
      _katalogBuku.insert(0, bukuBaru);
      _currentIndex = 0; // Otomatis kembali ke katalog
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buku "${bukuBaru.judul}" berhasil ditambahkan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Fungsi Edit Buku
  void _editBuku(Buku bukuDiperbarui) {
    final index = _katalogBuku.indexWhere((b) => b.id == bukuDiperbarui.id);
    if (index != -1) {
      setState(() {
        _katalogBuku[index] = bukuDiperbarui;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Buku "${bukuDiperbarui.judul}" berhasil diperbarui!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  // Fungsi Hapus Buku
  void _hapusBuku(String id) {
    final buku = _katalogBuku.firstWhere((b) => b.id == id);
    setState(() {
      _katalogBuku.removeWhere((b) => b.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buku "${buku.judul}" berhasil dihapus dari katalog.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> halaman = [
      HalamanKatalog(
        katalogBuku: _katalogBuku,
        onHapus: _hapusBuku,
        onEdit: _editBuku,
        onBukaForm: () => setState(() => _currentIndex = 1),
      ),
      HalamanFormBuku(
        onSimpan: _tambahBuku,
      ),
      HalamanHapusBuku(
        bukuTarget: _katalogBuku.isNotEmpty ? _katalogBuku.first : null,
        onKonfirmasiHapus: (id) {
          _hapusBuku(id);
          setState(() => _currentIndex = 0);
        },
        onBatal: () => setState(() => _currentIndex = 0),
      ),
    ];

    return MaterialApp(
      title: 'Perpustakaan Kampus Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: halaman,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.blue.shade700,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: '1. Katalog Buku',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: '2. Form Input',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete_forever),
              label: '3. Pop-up Hapus',
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TAMPILAN 1: HALAMAN KATALOG BUKU
// ==========================================
class HalamanKatalog extends StatelessWidget {
  final List<Buku> katalogBuku;
  final Function(String) onHapus;
  final Function(Buku) onEdit;
  final VoidCallback onBukaForm;

  const HalamanKatalog({
    super.key,
    required this.katalogBuku,
    required this.onHapus,
    required this.onEdit,
    required this.onBukaForm,
  });

  void _tampilkanModalEdit(BuildContext context, Buku buku) {
    final formKey = GlobalKey<FormState>();
    final judulController = TextEditingController(text: buku.judul);
    final penulisController = TextEditingController(text: buku.penulis);
    String selectedKategori = buku.kategori;
    String selectedStatus = buku.status;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Edit Data Buku', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              TextFormField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul Buku', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: penulisController,
                decoration: const InputDecoration(labelText: 'Nama Penulis', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Penulis wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedKategori,
                decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                items: ['Sistem Informasi', 'Informatika', 'Psikologi', 'Metodologi']
                    .map((kat) => DropdownMenuItem(value: kat, child: Text(kat)))
                    .toList(),
                onChanged: (val) => selectedKategori = val!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                decoration: const InputDecoration(labelText: 'Status Ketersediaan', border: OutlineInputBorder()),
                items: ['Tersedia', 'Sedang Dipinjam']
                    .map((st) => DropdownMenuItem(value: st, child: Text(st)))
                    .toList(),
                onChanged: (val) => selectedStatus = val!,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700, foregroundColor: Colors.white),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onEdit(buku.copyWith(
                        judul: judulController.text.trim(),
                        penulis: penulisController.text.trim(),
                        kategori: selectedKategori,
                        status: selectedStatus,
                      ));
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('PERBARUI BUKU'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanDialogHapus(BuildContext context, Buku buku) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Konfirmasi Hapus'),
          ],
        ),
        content: Text('Apakah Anda yakin ingin menghapus buku "${buku.judul}" karya ${buku.penulis} dari katalog perpustakaan?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              onHapus(buku.id);
              Navigator.pop(ctx);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: Colors.blue.shade50,
            child: const Row(
              children: [
                Icon(Icons.menu_book, size: 40, color: Colors.blue),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, Mahasiswa!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Nisa Rahmawati (230660221023) — SI-VIIA', style: TextStyle(color: Colors.black87, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Katalog Koleksi Buku (${katalogBuku.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Chip(
                  label: const Text('Katalog Utama', style: TextStyle(fontSize: 11, color: Colors.blue)),
                  backgroundColor: Colors.blue.shade100,
                  side: BorderSide.none,
                ),
              ],
            ),
          ),
          Expanded(
            child: katalogBuku.isEmpty
                ? const Center(child: Text('Katalog buku kosong.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: katalogBuku.length,
                    itemBuilder: (context, index) {
                      final item = katalogBuku[index];
                      final isTersedia = item.status == 'Tersedia';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isTersedia ? Colors.blue.shade100 : Colors.grey.shade300,
                            child: Icon(
                              Icons.book,
                              color: isTersedia ? Colors.blue : Colors.grey.shade700,
                            ),
                          ),
                          title: Text(item.judul, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Penulis: ${item.penulis}\nKategori: ${item.kategori} | Status: ${item.status}'),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _tampilkanModalEdit(context, item),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _tampilkanDialogHapus(context, item),
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
        onPressed: onBukaForm,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
      ),
    );
  }
}

// ==========================================
// TAMPILAN 2: HALAMAN FORM INPUT BUKU
// ==========================================
class HalamanFormBuku extends StatefulWidget {
  final Function(Buku) onSimpan;

  const HalamanFormBuku({super.key, required this.onSimpan});

  @override
  State<HalamanFormBuku> createState() => _HalamanFormBukuState();
}

class _HalamanFormBukuState extends State<HalamanFormBuku> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController(text: 'Analisis dan Perancangan Sistem Informasi');
  final _penulisController = TextEditingController(text: 'Jogiyanto HM');
  String _selectedKategori = 'Sistem Informasi';
  String _selectedStatus = 'Tersedia';

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final bukuBaru = Buku(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: _judulController.text.trim(),
        penulis: _penulisController.text.trim(),
        kategori: _selectedKategori,
        status: _selectedStatus,
      );
      widget.onSimpan(bukuBaru);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tambah Buku Baru',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _judulController,
                    decoration: const InputDecoration(
                      labelText: 'Judul Buku',
                      prefixIcon: Icon(Icons.book),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Judul buku wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _penulisController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Penulis',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Nama penulis wajib diisi' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedKategori,
                    decoration: const InputDecoration(
                      labelText: 'Kategori Buku',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Sistem Informasi', child: Text('Sistem Informasi')),
                      DropdownMenuItem(value: 'Informatika', child: Text('Informatika')),
                      DropdownMenuItem(value: 'Psikologi', child: Text('Psikologi')),
                      DropdownMenuItem(value: 'Metodologi', child: Text('Metodologi')),
                    ],
                    onChanged: (val) => setState(() => _selectedKategori = val!),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status Ketersediaan',
                      prefixIcon: Icon(Icons.info),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Tersedia', child: Text('Tersedia')),
                      DropdownMenuItem(value: 'Sedang Dipinjam', child: Text('Sedang Dipinjam')),
                    ],
                    onChanged: (val) => setState(() => _selectedStatus = val!),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        'SIMPAN DATA BUKU',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TAMPILAN 3: HALAMAN POP-UP HAPUS BUKU
// ==========================================
class HalamanHapusBuku extends StatelessWidget {
  final Buku? bukuTarget;
  final Function(String) onKonfirmasiHapus;
  final VoidCallback onBatal;

  const HalamanHapusBuku({
    super.key,
    this.bukuTarget,
    required this.onKonfirmasiHapus,
    required this.onBatal,
  });

  @override
  Widget build(BuildContext context) {
    final judul = bukuTarget?.judul ?? 'Analisis dan Perancangan Sistem Informasi';
    final penulis = bukuTarget?.penulis ?? 'Jogiyanto HM';

    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Container(
          width: 480,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                  SizedBox(width: 8),
                  Text('Konfirmasi Hapus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Apakah Anda yakin ingin menghapus buku "$judul" karya $penulis dari katalog perpustakaan?',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onBatal,
                    child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (bukuTarget != null) {
                        onKonfirmasiHapus(bukuTarget!.id);
                      } else {
                        onBatal();
                      }
                    },
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}