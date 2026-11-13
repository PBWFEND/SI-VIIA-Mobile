
import 'package:flutter/material.dart';
import '../services/integrasi_service.dart';

class HalamanIntegrasi extends StatefulWidget {
  const HalamanIntegrasi({super.key});

  @override
  State<HalamanIntegrasi> createState() => _HalamanIntegrasiState();
}

class _HalamanIntegrasiState extends State<HalamanIntegrasi> {
  final IntegrasiService service = IntegrasiService();

  List<Map<String, dynamic>> daftarData = [];

  bool sedangMemuat = true;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    muatData();
  }

  // Memuat data dari dua API
  Future<void> muatData() async {
    setState(() {
      sedangMemuat = true;
      pesanError = null;
    });

    try {
      final hasil = await service.ambilDataTerintegrasi();

      if (!mounted) return;

      setState(() {
        daftarData = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        sedangMemuat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Integrasi Data Pengajuan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: sedangMemuat ? null : muatData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      body: tampilkanKonten(),
    );
  }

  // Mengatur tampilan berdasarkan kondisi data
  Widget tampilkanKonten() {
    // 1. Kondisi loading
    if (sedangMemuat) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Sedang mengambil data...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    // 2. Kondisi error
    if (pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 65,
              ),
              const SizedBox(height: 12),
              const Text(
                'Gagal Memuat Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pesanError!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: muatData,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Kondisi data kosong
    if (daftarData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 65,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'Belum Ada Data Pengajuan',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: muatData,
              icon: const Icon(Icons.refresh),
              label: const Text('Muat Ulang'),
            ),
          ],
        ),
      );
    }

    // 4. Kondisi data tersedia
    return RefreshIndicator(
      onRefresh: muatData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarData.length,
        itemBuilder: (context, index) {
          final item = daftarData[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: Text('${item['id']}'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['judul'] ?? 'Tanpa Judul',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    'Nama Pengguna: ${item['nama']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('ID Pengguna: ${item['userId']}'),
                  const SizedBox(height: 10),
                  const Text(
                    'Deskripsi:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['deskripsi'] ?? 'Tidak ada deskripsi',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
