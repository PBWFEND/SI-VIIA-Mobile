
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiInventaris());
}

class AplikasiInventaris extends StatelessWidget {
  const AplikasiInventaris({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris Barang',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
        '/detail': (context) => const HalamanDetail(),
        '/form': (context) => const HalamanFormTransaksi(),
      },
    );
  }
}

class DataBarang {
  final String nama;
  final String harga;
  final int stok;

  const DataBarang({
    required this.nama,
    required this.harga,
    required this.stok,
  });
}

const daftarBarang = [
  DataBarang(nama: 'Minyak Goreng 1L', harga: 'Rp 16.000', stok: 12),
  DataBarang(nama: 'Beras Premium 5kg', harga: 'Rp 68.000', stok: 3),
  DataBarang(nama: 'Mie Instan Goreng', harga: 'Rp 3.100', stok: 0),
  DataBarang(nama: 'Kopi Instant Sachet', harga: 'Rp 1.500', stok: 25),
];

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Inventaris'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Daftar Barang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...daftarBarang.map(
            (barang) => Card(
              child: ListTile(
                title: Text(barang.nama),
                subtitle: Text(
                  '${barang.harga} • Stok: ${barang.stok}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: barang,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/form');
            },
            icon: const Icon(Icons.receipt_long),
            label: const Text('Buat Transaksi'),
          ),
        ],
      ),
    );
  }
}

class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! DataBarang) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Barang')),
        body: const Center(
          child: Text('Data barang tidak tersedia atau tidak valid.'),
        ),
      );
    }

    final barang = args;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              barang.nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Harga: ${barang.harga}'),
            Text('Stok tersedia: ${barang.stok}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Daftar Barang'),
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanFormTransaksi extends StatefulWidget {
  const HalamanFormTransaksi({super.key});

  @override
  State<HalamanFormTransaksi> createState() =>
      _HalamanFormTransaksiState();
}

class _HalamanFormTransaksiState extends State<HalamanFormTransaksi> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _catatanController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _kirimFormulir() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();
    final jumlah = int.parse(_jumlahController.text.trim());
    final catatan = _catatanController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Transaksi berhasil divalidasi: $nama, jumlah $jumlah'
          '${catatan.isNotEmpty ? ", catatan: $catatan" : ""}',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Transaksi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Kembali',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Input Transaksi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama pelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pelanggan wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah barang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jumlah barang wajib diisi.';
                  }

                  final jumlah = int.tryParse(value.trim());

                  if (jumlah == null || jumlah <= 0) {
                    return 'Masukkan jumlah berupa angka lebih dari 0.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _catatanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  // Catatan opsional, sehingga selalu valid.
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _kirimFormulir,
                child: const Text('Validasi dan Kirim'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal dan Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
