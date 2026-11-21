
import 'package:flutter/material.dart';
import 'service-api.dart';

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final TextEditingController _judulController =
      TextEditingController();

  final TextEditingController _pengirimController =
      TextEditingController();

  List<SuratMasuk> _daftarSurat = [];

  bool _sedangMemuat = false;
  bool _sedangMengirim = false;
  String? _pesanError;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pengirimController.dispose();
    super.dispose();
  }

  // ================================================
  // MENGAMBIL DATA SURAT (GET)
  // ================================================

  Future<void> _muatData() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      // Jeda sementara untuk screenshot loading.
      await Future.delayed(const Duration(seconds: 8));

      final hasil = await SuratApiService.ambilDaftarSurat();

      if (!mounted) return;

      setState(() {
        _daftarSurat = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _pesanError = e.toString();
        _sedangMemuat = false;
      });
    }
  }

  // ================================================
  // MENGIRIM DATA SURAT (POST)
  // ================================================

  Future<void> _kirimSurat() async {
    if (_judulController.text.trim().isEmpty ||
        _pengirimController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan pengirim harus diisi.'),
        ),
      );
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    try {
      final suratBaru = SuratMasukBaru(
        judul: _judulController.text.trim(),
        pengirim: _pengirimController.text.trim(),
      );

      final hasil = await SuratApiService.tambahSurat(suratBaru);

      if (!mounted) return;

      setState(() {
        _daftarSurat.insert(0, hasil);
        _sedangMengirim = false;
      });

      _judulController.clear();
      _pengirimController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Surat berhasil dikirim!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim surat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ================================================
  // TAMPILAN FORM SURAT
  // ================================================

  Widget _formSurat() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Surat Masuk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Surat',
                hintText: 'Masukkan judul surat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _pengirimController,
              decoration: const InputDecoration(
                labelText: 'Pengirim',
                hintText: 'Masukkan nama pengirim',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sedangMengirim ? null : _kirimSurat,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _sedangMengirim
                      ? 'Mengirim...'
                      : 'Kirim Surat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================
  // TAMPILAN DAFTAR SURAT
  // ================================================

  Widget _daftarSuratWidget() {
    if (_sedangMemuat) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_pesanError != null) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 55,
                  color: Colors.red,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Gagal Memuat Data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _pesanError!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _muatData,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_daftarSurat.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('Belum ada surat masuk.'),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: _muatData,
        child: ListView.builder(
          itemCount: _daftarSurat.length,
          itemBuilder: (context, index) {
            final surat = _daftarSurat[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade100,
                  child: const Icon(
                    Icons.mail_outline,
                    color: Colors.deepPurple,
                  ),
                ),
                title: Text(
                  surat.judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Pengirim: ${surat.pengirim}',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ================================================
  // TAMPILAN UTAMA
  // ================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengelolaan Surat Masuk'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _sedangMemuat ? null : _muatData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang',
          ),
        ],
      ),
      body: Column(
        children: [
          _formSurat(),

          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Surat Masuk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          _daftarSuratWidget(),
        ],
      ),
    );
  }
}
