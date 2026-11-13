import 'package:flutter/material.dart';

void main() {
  runApp(const PerpustakaanApp());
}

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF155E75)),
        useMaterial3: true,
      ),
      home: const PerpustakaanPage(),
    );
  }
}

class PerpustakaanPage extends StatelessWidget {
  const PerpustakaanPage({super.key});

  static const daftarLayanan = [
    {
      'nama': 'Ruang Baca Utama',
      'kategori': 'Fasilitas',
      'status': 'Tersedia',
      'jam': '08.00–20.00',
    },
    {
      'nama': 'Peminjaman Buku',
      'kategori': 'Layanan',
      'status': 'Tersedia',
      'jam': '08.00–16.00',
    },
    {
      'nama': 'Komputer Referensi',
      'kategori': 'Fasilitas',
      'status': 'Terbatas',
      'jam': '09.00–18.00',
    },
    {
      'nama': 'Konsultasi Pustakawan',
      'kategori': 'Bantuan',
      'status': 'Penuh',
      'jam': '10.00–15.00',
    },
  ];

  Color _statusColor(String status, BuildContext context) {
    switch (status) {
      case 'Tersedia':
        return Colors.green.shade700;
      case 'Terbatas':
        return Colors.orange.shade800;
      default:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Kampus'),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang, Nazwa!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Temukan buku dan layanan terbaik untuk mendukung kegiatan belajar Anda.',
                          style: TextStyle(color: Colors.white70, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 18,
                  bottom: 16,
                  child: Icon(
                    Icons.auto_stories_rounded,
                    color: Colors.white70,
                    size: 66,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    label: 'Buku dipinjam',
                    value: '3',
                    icon: Icons.menu_book_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    label: 'Jatuh tempo',
                    value: '12 Jun',
                    icon: Icons.event_available_rounded,
                    color: Colors.orange.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              'Layanan hari ini',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: daftarLayanan.length,
                itemBuilder: (context, index) {
                  final layanan = daftarLayanan[index];
                  final status = layanan['status']!;
                  final statusColor = _statusColor(status, context);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            theme.colorScheme.primaryContainer,
                        child: Icon(
                          layanan['kategori'] == 'Fasilitas'
                              ? Icons.apartment_rounded
                              : Icons.support_agent_rounded,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      title: Text(
                        layanan['nama']!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        '${layanan['kategori']} • ${layanan['jam']}',
                      ),
                      trailing: Chip(
                        label: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: statusColor.withValues(alpha: 0.12),
                        side: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.search_rounded),
        label: const Text('Cari buku'),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Icon(icon),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

