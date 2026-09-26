import 'package:flutter/material.dart';

void main() {
  runApp(const MoneyTrackApp());
}

class MoneyTrackApp extends StatelessWidget {
  const MoneyTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyTrack Mahasiswa',
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<Map<String, String>> transaksi = const [
    {'nama':'Gaji Freelance','kategori':'Pemasukan','status':'Masuk'},
    {'nama':'Makan Siang','kategori':'Kuliner','status':'Keluar'},
    {'nama':'Kuota Internet','kategori':'Internet','status':'Keluar'},
    {'nama':'Transportasi','kategori':'Perjalanan','status':'Keluar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Keuangan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'MoneyTrack Mahasiswa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          Text('Pemasukan'),
                          Text('Rp 2.000.000')
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          Text('Pengeluaran'),
                          Text('Rp 800.000')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transaksi.length,
                itemBuilder: (context, index) {
                  final item = transaksi[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.wallet),
                      title: Text(item['nama']!),
                      subtitle: Text(item['kategori']!),
                      trailing: Text(item['status']!),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}