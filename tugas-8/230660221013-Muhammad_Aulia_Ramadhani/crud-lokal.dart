import 'package:flutter/material.dart';

void main() {
  runApp(const KantinApp());
}

// =============================================================================
// 1. MODEL DATA (PesananKantin)
// =============================================================================
class PesananKantin {
  final String id;
  final String namaPemesan;
  final String namaMenu;
  final int jumlahPorsi;
  final int hargaSatuan;
  final String catatan;
  final String status;

  PesananKantin({
    required this.id,
    required this.namaPemesan,
    required this.namaMenu,
    required this.jumlahPorsi,
    required this.hargaSatuan,
    required this.catatan,
    this.status = 'Diproses',
  });

  // Perhitungan total harga otomatis
  int get totalHarga => jumlahPorsi * hargaSatuan;

  @override
  String toString() {
    return 'PesananKantin(id: $id, pemesan: $namaPemesan, menu: $namaMenu, porsi: $jumlahPorsi, total: Rp$totalHarga, status: $status)';
  }
}

// =============================================================================
// 2. APLIKASI UTAMA
// =============================================================================
class KantinApp extends StatelessWidget {
  const KantinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVP Kantin Kampus Local CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HalamanManajemenPesanan(),
    );
  }
}

// =============================================================================
// 3. LAYAR DAFTAR & MANAGEMENT PESANAN (StatefulWidget)
// =============================================================================
class HalamanManajemenPesanan extends StatefulWidget {
  const HalamanManajemenPesanan({super.key});

  @override
  State<HalamanManajemenPesanan> createState() =>
      _HalamanManajemenPesananState();
}

class _HalamanManajemenPesananState extends State<HalamanManajemenPesanan> {
  // State: List penampung data pesanan lokal
  final List<PesananKantin> _daftarPesanan = [
    PesananKantin(
      id: 'PESAN-101',
      namaPemesan: 'Muhammad Aulia Ramadhani',
      namaMenu: 'Nasi Goreng Spesial',
      jumlahPorsi: 2,
      hargaSatuan: 15000,
      catatan: 'Pedas sedang, telur ceplok',
      status: 'Diproses',
    ),
    PesananKantin(
      id: 'PESAN-102',
      namaPemesan: 'Galih Permana',
      namaMenu: 'Es Teh Manis Jumbo',
      jumlahPorsi: 1,
      hargaSatuan: 5000,
      catatan: 'Es dikit',
      status: 'Selesai',
    ),
  ];

  // ---------------------------------------------------------------------------
  // OPERASI CRUD: CREATE / UPDATE
  // ---------------------------------------------------------------------------
  void _bukaFormModal([PesananKantin? pesananLama]) {
    final isEdit = pesananLama != null;
    final pemesanController =
        TextEditingController(text: isEdit ? pesananLama.namaPemesan : '');
    final porsiController = TextEditingController(
        text: isEdit ? pesananLama.jumlahPorsi.toString() : '1');
    final catatanController =
        TextEditingController(text: isEdit ? pesananLama.catatan : '');

    String menuTerpilih = isEdit ? pesananLama.namaMenu : 'Nasi Goreng Spesial';
    final Map<String, int> pilihanMenu = {
      'Nasi Goreng Spesial': 15000,
      'Ayam Geprek Sambal Matah': 18000,
      'Es Teh Manis Jumbo': 5000,
      'Jus Alpukat Kocok': 10000,
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAlignment.start,
            children: [
              Text(
                isEdit ? 'Ubah Pesanan' : 'Tambah Pesanan Baru',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pemesanController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pemesan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: menuTerpilih,
                decoration: const InputDecoration(
                  labelText: 'Pilih Menu',
                  border: OutlineInputBorder(),
                ),
                items: pilihanMenu.keys.map((menu) {
                  return DropdownMenuItem(
                    value: menu,
                    child: Text('$menu (Rp${pilihanMenu[menu]})'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) menuTerpilih = val;
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: porsiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Porsi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: catatanController,
                decoration: const InputDecoration(
                  labelText: 'Catatan Khusus',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final nama = pemesanController.text.trim();
                    final porsi = int.tryParse(porsiController.text) ?? 1;
                    final catatan = catatanController.text.trim();
                    final harga = pilihanMenu[menuTerpilih] ?? 10000;

                    if (nama.isEmpty || porsi <= 0) return;

                    // setState membungkus pengubahan data
                    setState(() {
                      if (isEdit) {
                        // UPDATE: Penggantian Objek Berdasarkan indexWhere id
                        final idx = _daftarPesanan
                            .indexWhere((item) => item.id == pesananLama.id);
                        if (idx != -1) {
                          _daftarPesanan[idx] = PesananKantin(
                            id: pesananLama.id,
                            namaPemesan: nama,
                            namaMenu: menuTerpilih,
                            jumlahPorsi: porsi,
                            hargaSatuan: harga,
                            catatan: catatan,
                            status: pesananLama.status,
                          );
                        }
                      } else {
                        // CREATE: Tambah Objek Baru ke List State
                        final idBaru =
                            'PESAN-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
                        _daftarPesanan.add(
                          PesananKantin(
                            id: idBaru,
                            namaPemesan: nama,
                            namaMenu: menuTerpilih,
                            jumlahPorsi: porsi,
                            hargaSatuan: harga,
                            catatan: catatan,
                          ),
                        );
                      }
                    });

                    Navigator.pop(ctx);
                  },
                  child: Text(isEdit ? 'Simpan Perubahan' : 'Kirim Pesanan'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // OPERASI CRUD: DELETE (Dengan AlertDialog Konfirmasi)
  // ---------------------------------------------------------------------------
  void _konfirmasiHapus(PesananKantin item) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus pesanan "${item.namaMenu}" atas nama ${item.namaPemesan}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                // setState membungkus penghapusan data dengan removeWhere berdasarkan id
                setState(() {
                  _daftarPesanan.removeWhere((p) => p.id == item.id);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pesanan ${item.id} berhasil dihapus.'),
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // OPERASI UPDATE STATUS PESANAN (Status Toggle)
  // ---------------------------------------------------------------------------
  void _toggleStatus(PesananKantin item) {
    setState(() {
      final idx = _daftarPesanan.indexWhere((p) => p.id == item.id);
      if (idx != -1) {
        final statusBaru =
            item.status == 'Diproses' ? 'Selesai' : 'Diproses';
        _daftarPesanan[idx] = PesananKantin(
          id: item.id,
          namaPemesan: item.namaPemesan,
          namaMenu: item.namaMenu,
          jumlahPorsi: item.jumlahPorsi,
          hargaSatuan: item.hargaSatuan,
          catatan: item.catatan,
          status: statusBaru,
        );
      }
    });
  }

  // ---------------------------------------------------------------------------
  // OPERASI CRUD: READ (ListView.builder)
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MVP Kantin Kampus — Data Lokal'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: _daftarPesanan.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data pesanan.\nKlik tombol + di bawah untuk menambah.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _daftarPesanan.length,
              itemBuilder: (context, index) {
                final item = _daftarPesanan[index];
                final isSelesai = item.status == 'Selesai';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: isSelesai
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                      child: Icon(
                        isSelesai ? Icons.check_circle : Icons.hourglass_top,
                        color: isSelesai ? Colors.green : Colors.orange,
                      ),
                    ),
                    title: Text(
                      '${item.namaMenu} (${item.jumlahPorsi}x)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Text('Pemesan: ${item.namaPemesan}'),
                        Text(
                          'Total: Rp${item.totalHarga} • Catatan: ${item.catatan.isEmpty ? "-" : item.catatan}',
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelesai
                                ? Colors.green.shade50
                                : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Status: ${item.status}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelesai
                                  ? Colors.green.shade800
                                  : Colors.orange.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.swap_horiz, color: Colors.blue),
                          tooltip: 'Ubah Status',
                          onPressed: () => _toggleStatus(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          tooltip: 'Edit Pesanan',
                          onPressed: () => _bukaFormModal(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Hapus Pesanan',
                          onPressed: () => _konfirmasiHapus(item),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bukaFormModal(),
        icon: const Icon(Icons.add),
        label: const Text('Pesanan Baru'),
      ),
    );
  }
}