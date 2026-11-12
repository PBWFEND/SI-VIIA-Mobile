
import 'package:flutter/material.dart';
import 'service-api.dart';

void main() {
  runApp(const SiRuangApiApp());
}

class SiRuangApiApp extends StatelessWidget {
  const SiRuangApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRuang Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HalamanApi(),
    );
  }
}

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final PeminjamanApiService _service = PeminjamanApiService();

  final TextEditingController _ruanganController =
      TextEditingController();
  final TextEditingController _kategoriController =
      TextEditingController();
  final TextEditingController _tanggalController =
      TextEditingController();
  final TextEditingController _waktuController =
      TextEditingController();
  final TextEditingController _tujuanController =
      TextEditingController();

  List<Peminjaman> _daftarPeminjaman = [];
  bool _isLoading = true;
  bool _isSending = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Mengambil data dari API menggunakan GET
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _service.getPeminjaman();

      if (!mounted) return;

      setState(() {
        _daftarPeminjaman = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Mengirim data peminjaman menggunakan POST
  Future<void> _kirimData() async {
    if (_ruanganController.text.trim().isEmpty ||
        _kategoriController.text.trim().isEmpty ||
        _tanggalController.text.trim().isEmpty ||
        _waktuController.text.trim().isEmpty ||
        _tujuanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom harus diisi!'),
        ),
      );
      return;
    }

    final peminjaman = Peminjaman(
      namaRuangan: _ruanganController.text.trim(),
      kategori: _kategoriController.text.trim(),
      tanggal: _tanggalController.text.trim(),
      waktu: _waktuController.text.trim(),
      tujuan: _tujuanController.text.trim(),
    );

    setState(() {
      _isSending = true;
    });

    try {
      final hasil = await _service.tambahPeminjaman(peminjaman);

      if (!mounted) return;

      setState(() {
        _daftarPeminjaman.insert(0, hasil);
        _isSending = false;
      });

      _ruanganController.clear();
      _kategoriController.clear();
      _tanggalController.clear();
      _waktuController.clear();
      _tujuanController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data peminjaman berhasil dikirim!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSending = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ruanganController.dispose();
    _kategoriController.dispose();
    _tanggalController.dispose();
    _waktuController.dispose();
    _tujuanController.dispose();
    super.dispose();
  }

  // Membuat kolom input formulir
  Widget _buildTextField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiRuang Kampus'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _loadData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Formulir Peminjaman Ruangan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildTextField('Nama Ruangan', _ruanganController),
            _buildTextField('Kategori Ruangan', _kategoriController),
            _buildTextField('Tanggal Peminjaman', _tanggalController),
            _buildTextField('Waktu Peminjaman', _waktuController),
            _buildTextField('Tujuan Peminjaman', _tujuanController),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _kirimData,
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Kirim Peminjaman'),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Daftar Peminjaman Ruangan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Kondisi loading
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Sedang mengambil data...'),
                    ],
                  ),
                ),
              )

            // Kondisi error
            else if (_errorMessage != null)
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gagal memuat data peminjaman.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _loadData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              )

            // Kondisi sukses
            else if (_daftarPeminjaman.isEmpty)
              const Center(
                child: Text('Belum ada data peminjaman.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _daftarPeminjaman.length,
                itemBuilder: (context, index) {
                  final data = _daftarPeminjaman[index];

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.meeting_room),
                      ),
                      title: Text(data.namaRuangan),
                      subtitle: Text(
                        '${data.kategori}\n'
                        'Tanggal: ${data.tanggal}\n'
                        'Waktu: ${data.waktu}\n'
                        'Tujuan: ${data.tujuan}\n'
                        'Status: ${data.status}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
