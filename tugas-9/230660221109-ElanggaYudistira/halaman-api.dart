import 'package:flutter/material.dart';

import 'service-api.dart';

void main() {
  const endpoint = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com/posts',
  );
  runApp(MoneyTrackApiApp(baseUrl: endpoint));
}

class MoneyTrackApiApp extends StatelessWidget {
  final String baseUrl;

  const MoneyTrackApiApp({super.key, required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyTrack REST API',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B57)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
      ),
      home: HalamanApiPage(service: TransaksiApiService(baseUrl: baseUrl)),
    );
  }
}

class HalamanApiPage extends StatefulWidget {
  final TransaksiApiService service;

  const HalamanApiPage({super.key, required this.service});

  @override
  State<HalamanApiPage> createState() => _HalamanApiPageState();
}

class _HalamanApiPageState extends State<HalamanApiPage> {
  List<TransaksiApi> _items = [];
  bool _loading = true;
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
        _loading = true;
        _error = null;
      });
    }

    try {
      final data = await widget.service.ambilTransaksi();
      if (!mounted) return;
      setState(() {
        _items = data;
        _loading = false;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error.message;
      });
    }
  }

  Future<void> _bukaForm() async {
    final result = await showDialog<TransaksiApi>(
      context: context,
      builder: (context) => _FormApiDialog(service: widget.service),
    );
    if (!mounted || result == null) return;
    setState(() => _items = [result, ..._items]);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi berhasil dikirim ke API')),
    );
  }

  String _rupiah(int value) {
    final digits = value.abs().toString();
    final groups = <String>[];
    for (var end = digits.length; end > 0; end -= 3) {
      final start = (end - 3).clamp(0, end);
      groups.insert(0, digits.substring(start, end));
    }
    return (value < 0 ? '-' : '') + 'Rp' + groups.join('.');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoneyTrack • REST API'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            onPressed: _loading ? null : _muatData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _loading || _error != null
          ? null
          : FloatingActionButton.extended(
              onPressed: _bukaForm,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Kirim Transaksi'),
            ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Mengambil data transaksi dari REST API...'),
          ],
        ),
      );
    }

    if (_error != null) {
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
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 58,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Data gagal dimuat',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(_error!, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: _muatData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (_items.isEmpty) {
      return const Center(child: Text('API mengembalikan data kosong.'));
    }

    return RefreshIndicator(
      onRefresh: _muatData,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        itemCount: _items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                'Riwayat transaksi dari REST API',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            );
          }
          return _buildItem(_items[index - 1]);
        },
      ),
    );
  }

  Widget _buildItem(TransaksiApi item) {
    final income = item.jenis.toLowerCase().contains('pemasukan');
    final color = income ? Colors.teal.shade700 : Colors.orange.shade800;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(30),
          foregroundColor: color,
          child: Icon(income ? Icons.trending_up : Icons.trending_down),
        ),
        title: Text(
          item.nama,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(item.kategori + ' • ' + item.tanggal),
        trailing: Text(
          (income ? '+' : '-') + _rupiah(item.jumlah),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _FormApiDialog extends StatefulWidget {
  final TransaksiApiService service;

  const _FormApiDialog({required this.service});

  @override
  State<_FormApiDialog> createState() => _FormApiDialogState();
}

class _FormApiDialogState extends State<_FormApiDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _jumlah = TextEditingController();
  final _kategori = TextEditingController();
  final _catatan = TextEditingController();
  String _jenis = 'Pengeluaran';
  bool _sending = false;

  @override
  void dispose() {
    _nama.dispose();
    _jumlah.dispose();
    _kategori.dispose();
    _catatan.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final amount = int.tryParse(
      _jumlah.text.replaceAll('.', '').replaceAll(',', '').trim(),
    );
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah harus berupa angka positif')),
      );
      return;
    }

    setState(() => _sending = true);
    try {
      final result = await widget.service.tambahTransaksi(
        nama: _nama.text.trim(),
        jumlah: amount,
        jenis: _jenis,
        kategori: _kategori.text.trim(),
        catatan: _catatan.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context, result);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _sending = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Kirim Transaksi ke API'),
      content: SizedBox(
        width: 430,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nama,
                  decoration: const InputDecoration(
                    labelText: 'Nama transaksi',
                    prefixIcon: Icon(Icons.receipt_long),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _jumlah,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah',
                    prefixText: 'Rp ',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Jumlah wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _jenis,
                  decoration: const InputDecoration(
                    labelText: 'Jenis',
                    prefixIcon: Icon(Icons.swap_vert),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Pengeluaran',
                      child: Text('Pengeluaran'),
                    ),
                    DropdownMenuItem(
                      value: 'Pemasukan',
                      child: Text('Pemasukan'),
                    ),
                  ],
                  onChanged: _sending
                      ? null
                      : (value) => setState(() => _jenis = value ?? _jenis),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _kategori,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Kategori wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _catatan,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _sending ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _sending ? null : _submit,
          child: _sending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Kirim'),
        ),
      ],
    );
  }
}

