
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSuratUKM());
}

class AplikasiSuratUKM extends StatelessWidget {
  const AplikasiSuratUKM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surat Masuk UKM',
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
        '/detail': (context) => const HalamanDetail(),
        '/form': (context) => const HalamanForm(),
      },
    );
  }
}

// HALAMAN UTAMA: DAFTAR SURAT
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    final daftarSurat = [
      {
        'judul': 'Surat Undangan Rapat',
        'pengirim': 'Ketua UKM',
        'status': 'Belum diperiksa',
      },
      {
        'judul': 'Surat Permohonan Kerja Sama',
        'pengirim': 'Organisasi Mahasiswa',
        'status': 'Belum diperiksa',
      },
      {
        'judul': 'Surat Pemberitahuan Kegiatan',
        'pengirim': 'Fakultas',
        'status': 'Sudah diperiksa',
      },
      {
        'judul': 'Surat Undangan Seminar',
        'pengirim': 'Universitas',
        'status': 'Sudah diperiksa',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Masuk UKM'),
      ),
      body: ListView.builder(
        itemCount: daftarSurat.length,
        itemBuilder: (context, index) {
          final surat = daftarSurat[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              title: Text(surat['judul']!),
              subtitle: Text(
                'Pengirim: ${surat['pengirim']}\n'
                'Status: ${surat['status']}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: surat,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        tooltip: 'Tambah Surat',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// HALAMAN DETAIL SURAT
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments;

    if (data is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Surat'),
        ),
        body: const Center(
          child: Text('Data surat tidak tersedia.'),
        ),
      );
    }

    final judul = data['judul'] ?? 'Judul tidak tersedia';
    final pengirim = data['pengirim'] ?? 'Pengirim tidak tersedia';
    final status = data['status'] ?? 'Status tidak tersedia';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Surat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Pengirim: $pengirim'),
            const SizedBox(height: 8),
            Text('Status: $status'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Daftar Surat'),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN FORM TAMBAH SURAT
class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});

  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _pengirimController = TextEditingController();

  String _status = 'Belum diperiksa';

  @override
  void dispose() {
    _judulController.dispose();
    _pengirimController.dispose();
    super.dispose();
  }

  void _simpanSurat() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data surat berhasil divalidasi!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Surat'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Form Pencatatan Surat Masuk',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Input judul surat
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Surat',
                  hintText: 'Masukkan judul surat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul surat wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input nama pengirim
              TextFormField(
                controller: _pengirimController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengirim',
                  hintText: 'Masukkan nama pengirim',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pengirim wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pilihan status pemeriksaan
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status Pemeriksaan',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Belum diperiksa',
                    child: Text('Belum diperiksa'),
                  ),
                  DropdownMenuItem(
                    value: 'Sudah diperiksa',
                    child: Text('Sudah diperiksa'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Status pemeriksaan wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol simpan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _simpanSurat,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Surat'),
                ),
              ),
              const SizedBox(height: 8),

              // Tombol kembali
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
