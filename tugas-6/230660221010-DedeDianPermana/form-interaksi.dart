
import 'package:flutter/material.dart';

void main() {
  runApp(const SiRuangKampusApp());
}

class SiRuangKampusApp extends StatelessWidget {
  const SiRuangKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRuang Kampus',
      debugShowCheckedModeBanner: false,
      initialRoute: '/ruangan',
      routes: {
        '/ruangan': (context) => const DaftarRuanganPage(),
        '/detail-ruangan': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is Map<String, String>) {
            return DetailRuanganPage(dataRuangan: arguments);
          }
          return const DataTidakTersediaPage();
        },
        '/form-peminjaman': (context) => const FormPeminjamanPage(),
      },
    );
  }
}

class DaftarRuanganPage extends StatelessWidget {
  const DaftarRuanganPage({super.key});

  final List<Map<String, String>> ruangan = const [
    {
      'nama': 'Ruang 1',
      'kategori': 'Ruang Kelas',
      'status': 'Tersedia',
    },
    {
      'nama': 'Ruang 2',
      'kategori': 'Ruang Kelas',
      'status': 'Dipakai',
    },
    {
      'nama': 'Ruang 3',
      'kategori': 'Laboratorium',
      'status': 'Tersedia',
    },
    {
      'nama': 'Ruang 4',
      'kategori': 'Laboratorium',
      'status': 'Tersedia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SiRuang Kampus')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ruangan.length,
        itemBuilder: (context, index) {
          final item = ruangan[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.meeting_room),
              title: Text(item['nama']!),
              subtitle: Text(
                '${item['kategori']} • ${item['status']}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail-ruangan',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailRuanganPage extends StatelessWidget {
  final Map<String, String> dataRuangan;

  const DetailRuanganPage({
    super.key,
    required this.dataRuangan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail dan Jadwal Ruangan')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataRuangan['nama'] ?? 'Nama tidak tersedia',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Kategori: ${dataRuangan['kategori'] ?? '-'}',
            ),
            Text(
              'Status: ${dataRuangan['status'] ?? '-'}',
            ),
            const SizedBox(height: 12),
            const Text(
              'Informasi jadwal ditampilkan sebagai simulasi '
              'untuk prototipe navigasi.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/form-peminjaman',
                  );
                },
                child: const Text('Ajukan Peminjaman'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali ke Daftar Ruangan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormPeminjamanPage extends StatefulWidget {
  const FormPeminjamanPage({super.key});

  @override
  State<FormPeminjamanPage> createState() =>
      _FormPeminjamanPageState();
}

class _FormPeminjamanPageState extends State<FormPeminjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final _tanggalController = TextEditingController();
  final _waktuController = TextEditingController();
  final _tujuanController = TextEditingController();

  @override
  void dispose() {
    _tanggalController.dispose();
    _waktuController.dispose();
    _tujuanController.dispose();
    super.dispose();
  }

  void _kirimFormulir() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pengajuan peminjaman berhasil disimulasikan!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Peminjaman')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Lengkapi data peminjaman ruangan.',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tanggalController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Peminjaman',
                hintText: 'Contoh: 30-10-2026',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tanggal peminjaman wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _waktuController,
              decoration: const InputDecoration(
                labelText: 'Waktu Peminjaman',
                hintText: 'Contoh: 09.00 - 11.00',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Waktu peminjaman wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tujuanController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Tujuan Peminjaman',
                hintText: 'Tuliskan tujuan peminjaman ruangan',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tujuan peminjaman wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kirimFormulir,
              child: const Text('Kirim Pengajuan'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class DataTidakTersediaPage extends StatelessWidget {
  const DataTidakTersediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Ruangan')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Data ruangan tidak tersedia.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/ruangan',
                  (route) => false,
                );
              },
              child: const Text('Kembali ke Daftar Ruangan'),
            ),
          ],
        ),
      ),
    );
  }
}
