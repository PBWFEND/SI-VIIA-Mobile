
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSuratUKM());
}

class AplikasiSuratUKM extends StatelessWidget {
  const AplikasiSuratUKM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelolaan Surat Masuk UKM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  final List<Map<String, String>> surat = const [
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

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Masuk UKM'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Daftar Surat Masuk',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: surat.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mail_outline, size: 56),
                        SizedBox(height: 12),
                        Text('Belum ada surat masuk'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    itemCount: surat.length,
                    itemBuilder: (context, index) {
                      final item = surat[index];
                      final sudahDiperiksa =
                          item['status'] == 'Sudah diperiksa';

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.mail_outline),
                          title: Text(item['judul']!),
                          subtitle: Text(
                            'Dari: ${item['pengirim']}',
                          ),
                          trailing: Text(
                            item['status']!,
                            style: TextStyle(
                              color: sudahDiperiksa
                                  ? warna.primary
                                  : warna.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Fitur tambah surat akan dikembangkan berikutnya.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Surat'),
      ),
    );
  }
}
