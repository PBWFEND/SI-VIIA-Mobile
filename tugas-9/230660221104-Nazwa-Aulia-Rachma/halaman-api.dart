import 'package:flutter/material.dart';

import 'service-api.dart';

void main() {
  runApp(const PerpustakaanApiApp());
}

class PerpustakaanApiApp extends StatelessWidget {
  const PerpustakaanApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF117560)),
        useMaterial3: true,
      ),
      home: const HalamanApi(),
    );
  }
}

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final _service = BukuApiService();
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _kategoriController = TextEditingController();
  late Future<List<BukuApi>> _futureBuku;
  bool _mengirim = false;

  @override
  void initState() {
    super.initState();
    _futureBuku = _service.fetchBuku();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  void _cobaLagi() {
    setState(() {
      _futureBuku = _service.fetchBuku();
    });
  }

  Future<void> _kirimBuku() async {
    if (!_formKey.currentState!.validate() || _mengirim) {
      return;
    }

    setState(() => _mengirim = true);
    try {
      final buku = await _service.createBuku(
        judul: _judulController.text.trim(),
        kategori: _kategoriController.text.trim(),
      );
      _judulController.clear();
      _kategoriController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('POST berhasil: ${buku.judul}')),
        );
        _cobaLagi();
      }
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _mengirim = false);
      }
    }
  }

  Widget _buildForm(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _judulController,
                  decoration: const InputDecoration(
                    labelText: 'Judul buku',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Judul wajib diisi.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _kategoriController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Kategori wajib diisi.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _mengirim ? null : _kirimBuku,
                icon: _mengirim
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(_mengirim ? 'Mengirim...' : 'Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<List<BukuApi>>(
      future: _futureBuku,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Memuat katalog buku...'),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 56,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Data katalog gagal dimuat.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}'),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _cobaLagi,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final buku = snapshot.data ?? [];
        if (buku.isEmpty) {
          return const Center(child: Text('Belum ada data dari API.'));
        }

        return ListView.builder(
          itemCount: buku.length,
          itemBuilder: (context, index) {
            final item = buku[index];
            final warna = Theme.of(context).colorScheme;
            final statusColor = item.status == 'Tersedia'
                ? warna.primary
                : warna.error;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: warna.primaryContainer,
                  foregroundColor: warna.onPrimaryContainer,
                  child: const Icon(Icons.menu_book_rounded),
                ),
                title: Text(item.judul),
                subtitle: Text('${item.kategori} • stok ${item.stok}'),
                trailing: Text(
                  item.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perpustakaan Kampus API')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Katalog dari REST API',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 14),
                _buildForm(context),
                const SizedBox(height: 20),
                Expanded(child: _buildContent(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
