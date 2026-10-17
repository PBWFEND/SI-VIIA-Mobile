import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAbsensi());
}

class AplikasiAbsensi extends StatelessWidget {
  const AplikasiAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PresenGo',
      // Menggunakan Material 3 dan Warna Benih sesuai rubrik
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil warna tema agar konsisten dan tidak hardcode warna manual
    final tema = Theme.of(context);
    final warnaTema = tema.colorScheme;

    // DATA STATIS (Untuk menguji keadaan kosong / empty state, 
    // ubah isi list ini menjadi: final List<Map<String, String>> daftarKegiatan = []; )
    final List<Map<String, String>> daftarKegiatan = [
      {'nama': 'Rapat BPH Mingguan', 'waktu': '10:00 WIB', 'lokasi': 'Ruang Sekre', 'status': 'Segera'},
      {'nama': 'Kunjungan Studi', 'waktu': '09:00 WIB', 'lokasi': 'Luar Kota', 'status': 'Selesai'},
      {'nama': 'Evaluasi Program Kerja', 'waktu': '15:00 WIB', 'lokasi': 'Zoom Meeting', 'status': 'Segera'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kegiatan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: warnaTema.primaryContainer,
        foregroundColor: warnaTema.onPrimaryContainer,
      ),
      
      // PERCABANGAN KONDISI KOSONG (Empty State)
      body: daftarKegiatan.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 80, color: warnaTema.outlineVariant),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada kegiatan terdekat',
                    style: TextStyle(fontSize: 16, color: warnaTema.onSurfaceVariant),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: daftarKegiatan.length,
              itemBuilder: (context, index) {
                final kegiatan = daftarKegiatan[index];
                
                // Menentukan warna status menggunakan ternary dari tema Material 3
                final warnaStatusBg = kegiatan['status'] == 'Selesai' 
                    ? warnaTema.tertiaryContainer 
                    : warnaTema.errorContainer;
                final warnaStatusTeks = kegiatan['status'] == 'Selesai' 
                    ? warnaTema.onTertiaryContainer 
                    : warnaTema.onErrorContainer;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: warnaTema.secondaryContainer,
                      child: Icon(Icons.event, color: warnaTema.onSecondaryContainer),
                    ),
                    title: Text(
                      kegiatan['nama']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('${kegiatan['waktu']} • ${kegiatan['lokasi']}'),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: warnaStatusBg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        kegiatan['status']!,
                        style: TextStyle(
                          color: warnaStatusTeks, 
                          fontSize: 12, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            
      // Aksi Utama: Tombol Extended
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // Kosong dulu (belum ada navigasi)
        backgroundColor: warnaTema.primary,
        foregroundColor: warnaTema.onPrimary,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Scan Absen'),
      ),
    );
  }
}