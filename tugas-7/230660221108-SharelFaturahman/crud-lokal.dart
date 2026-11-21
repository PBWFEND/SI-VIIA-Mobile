// Nama berkas mengikuti panduan pengumpulan.
// ignore_for_file: file_names
import 'package:flutter/material.dart';

// Bantuan ChatGPT/Codex: rancangan CRUD, dokumentasi, dan pengujian.
void main() => runApp(const TaskCampusApp());

const mataKuliah = [
  'Pemrograman Aplikasi Bergerak',
  'Analisis Proses Bisnis',
  'Basis Data',
];
const statusTugas = ['Belum dimulai', 'Dikerjakan', 'Selesai'];

class Tugas {
  const Tugas({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    required this.status,
  });
  final int id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  final String status;

  @override
  String toString() =>
      'Tugas(id: $id, judul: $judul, mataKuliah: $mataKuliah, tenggat: $tenggat, status: $status)';
}

String formatTenggat(DateTime t) =>
    '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}/${t.year} ${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

DateTime? bacaTenggat(String teks) {
  final m = RegExp(r'^(\d{2})/(\d{2})/(\d{4}) (\d{2}):(\d{2})$')
      .firstMatch(teks.trim());
  if (m == null) return null;
  final n = List.generate(5, (i) => int.parse(m.group(i + 1)!));
  if (n[2] < 1 || n[3] > 23 || n[4] > 59) return null;
  final t = DateTime(n[2], n[1], n[0], n[3], n[4]);
  return t.year == n[2] && t.month == n[1] && t.day == n[0] ? t : null;
}

class TaskCampusApp extends StatelessWidget {
  const TaskCampusApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TaskCampus',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F78)),
    ),
    home: const DaftarTugasPage(),
  );
}

class DaftarTugasPage extends StatefulWidget {
  const DaftarTugasPage({super.key});
  @override
  State<DaftarTugasPage> createState() => _DaftarTugasState();
}

class _DaftarTugasState extends State<DaftarTugasPage> {
  final List<Tugas> _tugas = [
    Tugas(
      id: 1,
      judul: 'MVP Data Lokal TaskCampus',
      mataKuliah: mataKuliah[0],
      tenggat: DateTime(2026, 12, 18, 23, 59),
      status: statusTugas[1],
    ),
    Tugas(
      id: 2,
      judul: 'Diagram Proses Bisnis',
      mataKuliah: mataKuliah[1],
      tenggat: DateTime(2026, 12, 20, 21),
      status: statusTugas[0],
    ),
  ];
  int _idBerikut = 3;
  String? _filter;

  void _pesan(String pesan) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          duration: const Duration(seconds: 15),
          persist: false,
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: messenger.hideCurrentSnackBar,
          ),
        ),
      );
  }

  Future<void> _form([Tugas? lama]) async {
    final hasil = await showDialog<Tugas>(
      context: context,
      builder: (_) => FormTugas(
        id: lama?.id ?? _idBerikut,
        lama: lama,
        tercatat: List.unmodifiable(_tugas),
      ),
    );
    if (!mounted || hasil == null) return;
    setState(() {
      if (lama == null) {
        _tugas.insert(0, hasil);
        _idBerikut++;
      } else {
        final indeks = _tugas.indexWhere((t) => t.id == hasil.id);
        if (indeks >= 0) _tugas[indeks] = hasil;
      }
      _filter = null;
    });
    _pesan(
      lama == null
          ? 'Tugas berhasil ditambahkan.'
          : 'Tugas berhasil diperbarui.',
    );
  }

  Future<void> _hapus(Tugas tugas) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus tugas?'),
        content: Text(
          'Hapus "${tugas.judul}" dari daftar? Tindakan ini menghapus catatan selama sesi ini.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (!mounted || yakin != true) return;
    setState(() => _tugas.removeWhere((t) => t.id == tugas.id));
    _pesan('Tugas berhasil dihapus.');
  }

  @override
  Widget build(BuildContext context) {
    final tampil = _tugas
        .where((t) => _filter == null || t.mataKuliah == _filter)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('TaskCampus')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Daftar Tugas',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Text('Sharel Faturahman · 230660221108 · SI-VIIA'),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _filter,
                    decoration: const InputDecoration(
                      labelText: 'Filter mata kuliah',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua mata kuliah'),
                      ),
                      ...mataKuliah.map(
                        (m) => DropdownMenuItem(value: m, child: Text(m)),
                      ),
                    ],
                    isExpanded: true,
                    onChanged: (nilai) => setState(() => _filter = nilai),
                    key: ValueKey(_filter),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Text(
                        '${tampil.length} tugas · ${_tugas.where((t) => t.status == 'Selesai').length} selesai',
                      ),
                      FilledButton.icon(
                        onPressed: () => _form(),
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah Tugas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: tampil.isEmpty
                        ? const Center(
                            child: Text(
                              'Belum ada tugas. Tambahkan tugas atau ubah filter.',
                            ),
                          )
                        : ListView.builder(
                            itemCount: tampil.length,
                            itemBuilder: (_, i) {
                              final tugas = tampil[i];
                              return Card(
                                key: ValueKey(tugas.id),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tugas.judul,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(tugas.mataKuliah),
                                      Text(
                                        'Tenggat: ${formatTenggat(tugas.tenggat)}',
                                      ),
                                      Text('Status: ${tugas.status}'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () => _form(tugas),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                            label: const Text('Ubah'),
                                          ),
                                          TextButton.icon(
                                            onPressed: () => _hapus(tugas),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                            ),
                                            label: const Text('Hapus'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const Text(
                    'Data tersimpan selama sesi berjalan.',
                    textAlign: TextAlign.center,
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

class FormTugas extends StatefulWidget {
  const FormTugas({
    super.key,
    required this.id,
    required this.lama,
    required this.tercatat,
  });
  final int id;
  final Tugas? lama;
  final List<Tugas> tercatat;
  @override
  State<FormTugas> createState() => _FormTugasState();
}

class _FormTugasState extends State<FormTugas> {
  final _key = GlobalKey<FormState>();
  late final _judul = TextEditingController(text: widget.lama?.judul ?? '');
  late final _tenggat = TextEditingController(
    text: widget.lama == null ? '' : formatTenggat(widget.lama!.tenggat),
  );
  late String? _kuliah = widget.lama?.mataKuliah;
  late String _status = widget.lama?.status ?? statusTugas.first;
  String? _duplikat;

  @override
  void dispose() {
    _judul.dispose();
    _tenggat.dispose();
    super.dispose();
  }

  void _simpan() {
    setState(() => _duplikat = null);
    if (!_key.currentState!.validate()) return;
    final tanggal = bacaTenggat(_tenggat.text)!;
    if (widget.tercatat.any(
      (t) =>
          t.id != widget.id &&
          t.judul.trim().toLowerCase() == _judul.text.trim().toLowerCase() &&
          t.mataKuliah == _kuliah &&
          t.tenggat == tanggal,
    )) {
      setState(
        () => _duplikat =
            'Tugas dengan judul, mata kuliah, dan tenggat sama sudah ada.',
      );
      return;
    }
    Navigator.pop(
      context,
      Tugas(
        id: widget.id,
        judul: _judul.text.trim(),
        mataKuliah: _kuliah!,
        tenggat: tanggal,
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.lama == null ? 'Tambah Tugas' : 'Ubah Tugas'),
    content: SizedBox(
      width: 480,
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _judul,
                decoration: const InputDecoration(labelText: 'Judul tugas'),
                validator: (v) =>
                    v == null ||
                        v.trim().isEmpty ||
                        v.trim().characters.length > 100
                    ? 'Isi judul 1–100 karakter.'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _kuliah,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Mata kuliah'),
                items: mataKuliah
                    .map(
                      (m) => DropdownMenuItem(
                        value: m,
                        child: Text(m, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _kuliah = v),
                validator: (v) =>
                    mataKuliah.contains(v) ? null : 'Pilih mata kuliah.',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tenggat,
                decoration: const InputDecoration(
                  labelText: 'Tenggat',
                  helperText: 'DD/MM/YYYY HH:MM · contoh 18/12/2026 23:59',
                ),
                validator: (v) => bacaTenggat(v ?? '') == null
                    ? 'Isi tanggal dan jam yang valid.'
                    : null,
              ),
              if (widget.lama != null) ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: statusTugas
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setState(() => _status = v!),
                ),
              ],
              if (_duplikat != null)
                Text(
                  _duplikat!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
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
      FilledButton(onPressed: _simpan, child: const Text('Simpan')),
    ],
  );
}
