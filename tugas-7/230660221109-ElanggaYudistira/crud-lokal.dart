import 'package:flutter/material.dart';

void main() {
  runApp(const MoneyTrackApp());
}

enum JenisTransaksi { pemasukan, pengeluaran }

extension JenisTransaksiLabel on JenisTransaksi {
  String get label =>
      this == JenisTransaksi.pemasukan ? 'Pemasukan' : 'Pengeluaran';
  IconData get icon => this == JenisTransaksi.pemasukan
      ? Icons.south_west_rounded
      : Icons.north_east_rounded;
}

class Transaksi {
  final String id;
  final String nama;
  final int jumlah;
  final JenisTransaksi jenis;
  final String kategori;
  final DateTime tanggal;
  final String? catatan;

  const Transaksi({
    required this.id,
    required this.nama,
    required this.jumlah,
    required this.jenis,
    required this.kategori,
    required this.tanggal,
    required this.catatan,
  });

  @override
  String toString() {
    return 'Transaksi(id: $id, nama: $nama, jumlah: $jumlah, jenis: ${jenis.label}, kategori: $kategori, tanggal: $tanggal, catatan: $catatan)';
  }
}

class MoneyTrackApp extends StatelessWidget {
  const MoneyTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyTrack Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B57)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
      ),
      home: const DaftarTransaksiPage(),
    );
  }
}

class DaftarTransaksiPage extends StatefulWidget {
  const DaftarTransaksiPage({super.key});

  @override
  State<DaftarTransaksiPage> createState() => _DaftarTransaksiPageState();
}

class _DaftarTransaksiPageState extends State<DaftarTransaksiPage> {
  final List<Transaksi> _transaksi = [
    Transaksi(
      id: 'seed-1',
      nama: 'Uang Saku Mingguan',
      jumlah: 500000,
      jenis: JenisTransaksi.pemasukan,
      kategori: 'Uang Saku',
      tanggal: DateTime(2026, 10, 30),
      catatan: 'Transfer dari orang tua',
    ),
    Transaksi(
      id: 'seed-2',
      nama: 'Makan Siang',
      jumlah: 25000,
      jenis: JenisTransaksi.pengeluaran,
      kategori: 'Makanan',
      tanggal: DateTime(2026, 10, 30),
      catatan: 'Kantin kampus',
    ),
    Transaksi(
      id: 'seed-3',
      nama: 'Transportasi',
      jumlah: 15000,
      jenis: JenisTransaksi.pengeluaran,
      kategori: 'Transportasi',
      tanggal: DateTime(2026, 10, 29),
      catatan: 'Perjalanan ke kampus',
    ),
  ];

  int get _totalPemasukan => _transaksi
      .where((item) => item.jenis == JenisTransaksi.pemasukan)
      .fold(0, (total, item) => total + item.jumlah);

  int get _totalPengeluaran => _transaksi
      .where((item) => item.jenis == JenisTransaksi.pengeluaran)
      .fold(0, (total, item) => total + item.jumlah);

  int get _saldo => _totalPemasukan - _totalPengeluaran;

  String _rupiah(int value) {
    final text = value.abs().toString();
    final groups = <String>[];
    for (var end = text.length; end > 0; end -= 3) {
      final start = (end - 3).clamp(0, end);
      groups.insert(0, text.substring(start, end));
    }
    return '${value < 0 ? '-' : ''}Rp${groups.join('.')}';
  }

  String _tanggal(DateTime value) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${value.day} ${months[value.month - 1]} ${value.year}';
  }

  Future<void> _tambahTransaksi() async {
    final hasil = await showDialog<Transaksi>(
      context: context,
      builder: (context) => const _FormTransaksiDialog(),
    );
    if (!mounted || hasil == null) return;
    setState(() => _transaksi.add(hasil));
    _beriUmpan('Transaksi berhasil ditambahkan');
  }

  Future<void> _ubahTransaksi(Transaksi lama) async {
    final hasil = await showDialog<Transaksi>(
      context: context,
      builder: (context) => _FormTransaksiDialog(awal: lama),
    );
    if (!mounted || hasil == null) return;
    final index = _transaksi.indexWhere((item) => item.id == hasil.id);
    if (index == -1) return;
    setState(() => _transaksi[index] = hasil);
    _beriUmpan('Transaksi berhasil diperbarui');
  }

  Future<void> _hapusTransaksi(Transaksi item) async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus transaksi?'),
        content: Text('Transaksi "${item.nama}" akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (!mounted || setuju != true) return;
    setState(() => _transaksi.removeWhere((data) => data.id == item.id));
    _beriUmpan('Transaksi dihapus');
  }

  void _beriUmpan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoneyTrack Mahasiswa'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                children: [
                  Text(
                    'Ringkasan Keuangan',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: wide ? 3 : 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: wide ? 2.5 : 4.6,
                    children: [
                      _RingkasanCard(
                        label: 'Saldo',
                        value: _rupiah(_saldo),
                        icon: Icons.account_balance_wallet_outlined,
                        color: colors.primary,
                      ),
                      _RingkasanCard(
                        label: 'Pemasukan',
                        value: _rupiah(_totalPemasukan),
                        icon: Icons.trending_up,
                        color: Colors.teal.shade700,
                      ),
                      _RingkasanCard(
                        label: 'Pengeluaran',
                        value: _rupiah(_totalPengeluaran),
                        icon: Icons.trending_down,
                        color: Colors.orange.shade800,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Transaksi',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_transaksi.length} item',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_transaksi.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(28),
                        child: Center(
                          child: Text(
                            'Belum ada transaksi. Tambahkan transaksi pertama Anda.',
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: (_transaksi.length * 88.0)
                          .clamp(88.0, 600.0)
                          .toDouble(),
                      child: ListView.builder(
                        itemCount: _transaksi.length,
                        itemBuilder: (context, index) =>
                            _buildTransactionCard(_transaksi[index]),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahTransaksi,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Transaksi'),
      ),
    );
  }

  Widget _buildTransactionCard(Transaksi item) {
    final isIncome = item.jenis == JenisTransaksi.pemasukan;
    final color = isIncome ? Colors.teal.shade700 : Colors.orange.shade800;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(30),
          foregroundColor: color,
          child: Icon(item.jenis.icon),
        ),
        title: Text(
          item.nama,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${item.kategori} • ${_tanggal(item.tanggal)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${isIncome ? '+' : '-'}${_rupiah(item.jumlah)}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton<String>(
              tooltip: 'Aksi transaksi',
              onSelected: (value) {
                if (value == 'ubah') _ubahTransaksi(item);
                if (value == 'hapus') _hapusTransaksi(item);
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'ubah', child: Text('Ubah')),
                PopupMenuItem(value: 'hapus', child: Text('Hapus')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RingkasanCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _RingkasanCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withAlpha(30),
              foregroundColor: color,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label),
                  const SizedBox(height: 4),
                  FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
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

class _FormTransaksiDialog extends StatefulWidget {
  final Transaksi? awal;

  const _FormTransaksiDialog({this.awal});

  @override
  State<_FormTransaksiDialog> createState() => _FormTransaksiDialogState();
}

class _FormTransaksiDialogState extends State<_FormTransaksiDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _namaController;
  late final TextEditingController _jumlahController;
  late final TextEditingController _kategoriController;
  late final TextEditingController _catatanController;
  late JenisTransaksi _jenis;
  late DateTime _tanggal;

  @override
  void initState() {
    super.initState();
    final awal = widget.awal;
    _namaController = TextEditingController(text: awal?.nama ?? '');
    _jumlahController = TextEditingController(
      text: awal?.jumlah.toString() ?? '',
    );
    _kategoriController = TextEditingController(text: awal?.kategori ?? '');
    _catatanController = TextEditingController(text: awal?.catatan ?? '');
    _jenis = awal?.jenis ?? JenisTransaksi.pengeluaran;
    _tanggal = awal?.tanggal ?? DateTime.now();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    _kategoriController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  String? _wajib(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    return null;
  }

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: _tanggal,
      helpText: 'Pilih tanggal transaksi',
    );
    if (tanggal != null) setState(() => _tanggal = tanggal);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final nilai = int.tryParse(
      _jumlahController.text.replaceAll('.', '').replaceAll(',', '').trim(),
    );
    if (nilai == null || nilai <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah harus berupa angka positif')),
      );
      return;
    }
    final id =
        widget.awal?.id ?? DateTime.now().microsecondsSinceEpoch.toString();
    Navigator.pop(
      context,
      Transaksi(
        id: id,
        nama: _namaController.text.trim(),
        jumlah: nilai,
        jenis: _jenis,
        kategori: _kategoriController.text.trim(),
        tanggal: _tanggal,
        catatan: _catatanController.text.trim().isEmpty
            ? null
            : _catatanController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final edit = widget.awal != null;
    return AlertDialog(
      title: Text(edit ? 'Ubah Transaksi' : 'Tambah Transaksi'),
      content: SizedBox(
        width: 430,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama transaksi',
                    prefixIcon: Icon(Icons.receipt_long),
                  ),
                  validator: (value) => _wajib(value, 'Nama transaksi'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _jumlahController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah (Rupiah)',
                    prefixText: 'Rp ',
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => _wajib(value, 'Jumlah'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<JenisTransaksi>(
                  initialValue: _jenis,
                  decoration: const InputDecoration(
                    labelText: 'Jenis transaksi',
                    prefixIcon: Icon(Icons.swap_vert),
                  ),
                  items: JenisTransaksi.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.label),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _jenis = value ?? _jenis),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _kategoriController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  validator: (value) => _wajib(value, 'Kategori'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: _pilihTanggal,
                  borderRadius: BorderRadius.circular(4),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal',
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                    child: Text(
                      '${_tanggal.day}/${_tanggal.month}/${_tanggal.year}',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _catatanController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (opsional)',
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
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _simpan,
          child: Text(edit ? 'Simpan Perubahan' : 'Simpan'),
        ),
      ],
    );
  }
}
