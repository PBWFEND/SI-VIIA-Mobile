// halaman_aplikasi.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiAbsensi());
}

class AplikasiAbsensi extends StatelessWidget {
  const AplikasiAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    // 1.1 Struktur MaterialApp
    return MaterialApp(
      title: 'Absensi Organisasi', // Sesuai domain SI
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HalamanJadwal(),
    );
  }
}

class HalamanJadwal extends StatelessWidget {
  const HalamanJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    // 1.3 Data Statis Minimal 4 Entri
    final List<Map<String, String>> daftarKegiatan = [
      {'nama': 'Rapat BPH Mingguan', 'waktu': '10:00 WIB', 'lokasi': 'Ruang Sekre', 'status': 'Segera'},
      {'nama': 'Pembekalan Anggota Baru', 'waktu': '13:00 WIB', 'lokasi': 'Aula Kampus', 'status': 'Terjadwal'},
      {'nama': 'Kunjungan Studi', 'waktu': '09:00 WIB', 'lokasi': 'Luar Kota', 'status': 'Selesai'},
      {'nama': 'Evaluasi Program Kerja', 'waktu': '15:00 WIB', 'lokasi': 'Zoom Meeting', 'status': 'Terjadwal'},
      {'nama': 'Pelatihan Kepemimpinan', 'waktu': '08:00 WIB', 'lokasi': 'Lap. Basket', 'status': 'Batal'},
    ];

    // 1.1 Struktur Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kegiatan'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      // 1.2 Layout: Column sebagai wadah utama
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layout: Padding
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Halo, Amelia! Berikut jadwal Anda minggu ini:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Layout: Expanded + ListView (mencegah RenderFlex Overflow)
          Expanded(
            child: ListView.builder(
              itemCount: daftarKegiatan.length,
              itemBuilder: (context, index) {
                final kegiatan = daftarKegiatan[index];
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    // Layout: Row (menyusun ikon dan teks secara horizontal)
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_note, 
                          size: 40, 
                          color: Colors.blue[600]
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kegiatan['nama']!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text('${kegiatan['waktu']} - ${kegiatan['lokasi']}'),
                            ],
                          ),
                        ),
                        // Status dengan Ternary sederhana
                        Chip(
                          label: Text(
                            kegiatan['status']!,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          backgroundColor: kegiatan['status'] == 'Selesai' 
                              ? Colors.green 
                              : kegiatan['status'] == 'Batal' 
                                  ? Colors.red 
                                  : Colors.orange,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Kosong dulu untuk pertemuan 3
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }
}