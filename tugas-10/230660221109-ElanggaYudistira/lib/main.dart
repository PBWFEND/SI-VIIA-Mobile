import 'package:flutter/material.dart';

import 'models/pengajuan_terintegrasi.dart';
import 'services/integrasi_service.dart';

void main() {
  const endpoint = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com',
  );
  runApp(Tugas10App(baseUrl: endpoint));
}

class Tugas10App extends StatelessWidget {
  final String baseUrl;

  const Tugas10App({super.key, required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Integrasi Data Pengajuan',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B57)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
      ),
      home: IntegrasiPage(service: IntegrasiService(baseUrl: baseUrl)),
    );
  }
}

enum HalamanState { loading, success, empty, error }

class IntegrasiPage extends StatefulWidget {
  final IntegrasiService service;

  const IntegrasiPage({super.key, required this.service});

  @override
  State<IntegrasiPage> createState() => _IntegrasiPageState();
}

class _IntegrasiPageState extends State<IntegrasiPage> {
  HalamanState _state = HalamanState.loading;
  List<PengajuanTerintegrasi> _items = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  @override
  void dispose() {
    widget.service.dispose();
    super.dispose();
  }

  Future<void> _muatData() async {
    if (mounted) {
      setState(() {
        _state = HalamanState.loading;
        _error = null;
      });
    }

    try {
      final items = await widget.service.ambilDataTerintegrasi();
      if (!mounted) return;
      setState(() {
        _items = items;
        _state = items.isEmpty ? HalamanState.empty : HalamanState.success;
      });
    } on IntegrasiApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _state = HalamanState.error;
        _error = error.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrasi Data Pengajuan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            tooltip: 'Coba lagi',
            onPressed: _state == HalamanState.loading ? null : _muatData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case HalamanState.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Menggabungkan data pengguna dan pengajuan...'),
            ],
          ),
        );
      case HalamanState.empty:
        return _StateCard(
          icon: Icons.inbox_outlined,
          title: 'Belum ada data pengajuan',
          message: 'Request berhasil, tetapi kedua endpoint belum mengembalikan data yang dapat ditampilkan.',
          actionLabel: 'Coba Lagi',
          onAction: _muatData,
        );
      case HalamanState.error:
        return _StateCard(
          icon: Icons.cloud_off_outlined,
          title: 'Integrasi gagal',
          message: _error ?? 'Terjadi kesalahan yang tidak diketahui.',
          actionLabel: 'Coba Lagi',
          onAction: _muatData,
          error: true,
        );
      case HalamanState.success:
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          itemCount: _items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                        child: Icon(
                          Icons.merge_type,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Data pengajuan digabung berdasarkan userId '
                          'antara endpoint pengguna dan pengajuan.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return _buildItem(_items[index - 1]);
          },
        );
    }
  }

  Widget _buildItem(PengajuanTerintegrasi item) {
    final status = item.pengajuan.status;
    final statusColor = status.toLowerCase().contains('proses')
        ? Colors.blue.shade700
        : Colors.orange.shade800;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: statusColor.withAlpha(28),
          foregroundColor: statusColor,
          child: const Icon(Icons.description_outlined),
        ),
        title: Text(
          item.pengajuan.judul,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            item.namaPemohon +
                ' • ' +
                item.emailPemohon +
                '\n' +
                item.organisasiPemohon,
          ),
        ),
        isThreeLine: true,
        trailing: Chip(
          label: Text(status),
          visualDensity: VisualDensity.compact,
          side: BorderSide.none,
          backgroundColor: statusColor.withAlpha(24),
          labelStyle: TextStyle(color: statusColor),
        ),
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;
  final bool error;

  const _StateCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = error
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 58, color: color),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: onAction,
                    icon: const Icon(Icons.refresh),
                    label: Text(actionLabel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
