// Nama berkas pengumpulan dan berkas web dipertahankan sesuai panduan tugas.
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// Bantuan: ChatGPT/Codex untuk perbaikan peluncur, feedback, dan pengujian alur.
void main() => runApp(const TaskCampusApp());

const _ruteDaftar = '/';
const _ruteDetail = '/detail-tugas';
const _ruteTambah = '/tambah-tugas';

enum StatusTugas {
  belumDimulai('Belum dimulai', Icons.circle_outlined),
  dikerjakan('Dikerjakan', Icons.timelapse_rounded),
  selesai('Selesai', Icons.check_rounded);

  const StatusTugas(this.label, this.ikon);

  final String label;
  final IconData ikon;
}

class Tugas {
  const Tugas({
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    required this.status,
  });

  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  final StatusTugas status;

  Tugas denganStatus(StatusTugas statusBaru) {
    return Tugas(
      judul: judul,
      mataKuliah: mataKuliah,
      tenggat: tenggat,
      status: statusBaru,
    );
  }

  bool identikDengan(Tugas lain) {
    return judul.trim().toLowerCase() == lain.judul.trim().toLowerCase() &&
        mataKuliah == lain.mataKuliah &&
        DateUtils.isSameDay(tenggat, lain.tenggat) &&
        tenggat.hour == lain.tenggat.hour &&
        tenggat.minute == lain.tenggat.minute;
  }
}

const _pab = 'Pemrograman Aplikasi Bergerak';
const _apb = 'Analisis Proses Bisnis';
const _imk = 'Interaksi Manusia dan Komputer';
const _mataKuliah = [_pab, _apb, _imk, 'Basis Data'];

final _contohTugas = <Tugas>[
  Tugas(
    judul: 'Prototype UI/UX TaskCampus',
    mataKuliah: _pab,
    tenggat: DateTime(2026, 11, 18, 23, 59),
    status: StatusTugas.dikerjakan,
  ),
  Tugas(
    judul: 'Diagram Proses Bisnis',
    mataKuliah: _apb,
    tenggat: DateTime(2026, 11, 20, 21),
    status: StatusTugas.belumDimulai,
  ),
  Tugas(
    judul: 'Rancangan Antarmuka Sistem',
    mataKuliah: _imk,
    tenggat: DateTime(2026, 11, 23, 20),
    status: StatusTugas.belumDimulai,
  ),
  Tugas(
    judul: 'Dokumen Kebutuhan dan User Flow',
    mataKuliah: _pab,
    tenggat: DateTime(2026, 11, 12, 23, 59),
    status: StatusTugas.selesai,
  ),
];

class TaskCampusApp extends StatelessWidget {
  const TaskCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = ColorScheme.fromSeed(seedColor: const Color(0xFF087F78));

    return MaterialApp(
      title: 'TaskCampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: warna,
        scaffoldBackgroundColor: warna.surfaceContainerLowest,
      ),
      initialRoute: _ruteDaftar,
      routes: {
        _ruteDaftar: (_) => const DaftarTugasPage(),
        _ruteDetail: (context) {
          final argumen = ModalRoute.of(context)?.settings.arguments;
          if (argumen is Tugas) {
            return _DetailTugasPage(tugas: argumen);
          }
          return _PesanRutePage(
            judul: 'Detail Tugas',
            pesan: argumen == null
                ? 'Pilih tugas dari Daftar Tugas.'
                : 'Data tugas tidak valid.',
          );
        },
        _ruteTambah: (context) {
          final argumen = ModalRoute.of(context)?.settings.arguments;
          if (argumen is List<Tugas>) {
            return _FormTambahTugasPage(tugasTercatat: argumen);
          }
          return _PesanRutePage(
            judul: 'Form Tambah Tugas',
            pesan: argumen == null
                ? 'Buka formulir dari Daftar Tugas.'
                : 'Data daftar tugas tidak valid.',
          );
        },
      },
    );
  }
}

class DaftarTugasPage extends StatefulWidget {
  const DaftarTugasPage({super.key});

  @override
  State<DaftarTugasPage> createState() => _DaftarTugasPageState();
}

class _DaftarTugasPageState extends State<DaftarTugasPage> {
  static const _lebarKonten = 680.0;
  final _daftarTugas = <Tugas>[..._contohTugas];
  String? _pilihanMataKuliah;

  Future<void> _tambahTugas() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final tugasBaru = await Navigator.pushNamed<Object?>(
      context,
      _ruteTambah,
      arguments: List<Tugas>.unmodifiable(_daftarTugas),
    );
    if (!mounted || tugasBaru is! Tugas) return;

    setState(() {
      _daftarTugas.insert(0, tugasBaru);
      if (_pilihanMataKuliah != tugasBaru.mataKuliah) {
        _pilihanMataKuliah = null;
      }
    });
    _tampilkanPesan('Tugas berhasil ditambahkan.');
  }

  Future<void> _bukaDetail(Tugas tugas) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final statusBaru = await Navigator.pushNamed<Object?>(
      context,
      _ruteDetail,
      arguments: tugas,
    );
    if (!mounted || statusBaru is! StatusTugas) return;

    final indeks = _daftarTugas.indexOf(tugas);
    if (indeks < 0) return;
    setState(() => _daftarTugas[indeks] = tugas.denganStatus(statusBaru));
    _tampilkanPesan('Status tugas berhasil diperbarui.');
  }

  void _tampilkanPesan(String pesan) {
    // Tampilkan pada daftar sesudah form/detail selesai mengembalikan hasil.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(pesan),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 15),
            persist: false,
            action: SnackBarAction(
              label: 'Tutup',
              onPressed: () => messenger.hideCurrentSnackBar(),
            ),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    final daftarTugas = _pilihanMataKuliah == null
        ? _daftarTugas
        : _daftarTugas
              .where((tugas) => tugas.mataKuliah == _pilihanMataKuliah)
              .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.surfaceContainerLow,
        scrolledUnderElevation: 0,
        toolbarHeight: 64,
        centerTitle: true,
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _lebarKonten - 32),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: warna.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.school_outlined,
                  color: warna.onPrimary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'TaskCampus',
                style: tema.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _lebarKonten),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Text(
                        'Daftar Tugas',
                        style: tema.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: _tambahTugas,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 48),
                        ),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Tambah Tugas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Mata kuliah', style: tema.textTheme.labelLarge),
                  const SizedBox(height: 6),
                  _FilterMataKuliah(
                    nilai: _pilihanMataKuliah,
                    onChanged: (nilai) {
                      setState(() => _pilihanMataKuliah = nilai);
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${daftarTugas.length} tugas',
                    style: tema.textTheme.labelLarge?.copyWith(
                      color: warna.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: daftarTugas.isEmpty
                        ? _KeadaanKosong(mataKuliah: _pilihanMataKuliah)
                        : ListView.builder(
                            key: ValueKey((
                              _pilihanMataKuliah,
                              _daftarTugas.length,
                            )),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: daftarTugas.length,
                            itemBuilder: (context, index) {
                              final tugas = daftarTugas[index];
                              return _KartuTugas(
                                tugas: tugas,
                                onTap: () => _bukaDetail(tugas),
                              );
                            },
                          ),
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

class _FilterMataKuliah extends StatelessWidget {
  const _FilterMataKuliah({required this.nilai, required this.onChanged});

  final String? nilai;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return MenuAnchor(
      menuChildren: [
        for (final pilihan in [null, ..._mataKuliah])
          MenuItemButton(
            leadingIcon: pilihan == nilai
                ? const Icon(Icons.check_rounded, size: 18)
                : const SizedBox(width: 18),
            onPressed: () => onChanged(pilihan),
            child: Text(pilihan ?? 'Semua mata kuliah'),
          ),
      ],
      builder: (context, pengontrol, child) {
        return OutlinedButton(
          onPressed: () {
            if (pengontrol.isOpen) {
              pengontrol.close();
            } else {
              pengontrol.open();
            }
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: warna.surface,
            foregroundColor: warna.onSurface,
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            side: BorderSide(color: warna.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.filter_list_rounded, color: warna.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(nilai ?? 'Semua mata kuliah')),
              const Icon(Icons.expand_more_rounded, size: 20),
            ],
          ),
        );
      },
    );
  }
}

class _KartuTugas extends StatelessWidget {
  const _KartuTugas({required this.tugas, required this.onTap});

  final Tugas tugas;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: warna.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: warna.outlineVariant),
      ),
      child: ListTile(
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        horizontalTitleGap: 10,
        minLeadingWidth: 38,
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: warna.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.assignment_outlined,
            size: 20,
            color: warna.onSurfaceVariant,
          ),
        ),
        title: Text(
          tugas.judul,
          style: tema.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(tugas.mataKuliah),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: warna.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        _formatTenggat(tugas.tenggat),
                        semanticsLabel:
                            'Tenggat ${_formatTenggat(tugas.tenggat)}',
                        style: tema.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                _LencanaStatus(status: tugas.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LencanaStatus extends StatelessWidget {
  const _LencanaStatus({required this.status});

  final StatusTugas status;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    final selesai = status == StatusTugas.selesai;
    final dikerjakan = status == StatusTugas.dikerjakan;
    final latar = selesai
        ? warna.primaryContainer
        : dikerjakan
        ? warna.tertiaryContainer
        : warna.surfaceContainerHighest;
    final teks = selesai
        ? warna.onPrimaryContainer
        : dikerjakan
        ? warna.onTertiaryContainer
        : warna.onSurfaceVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: latar,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status.ikon, size: 14, color: teks),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                status.label,
                style: tema.textTheme.labelSmall?.copyWith(color: teks),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeadaanKosong extends StatelessWidget {
  const _KeadaanKosong({required this.mataKuliah});

  final String? mataKuliah;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 76),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: warna.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.inbox_outlined,
                  color: warna.onPrimaryContainer,
                  size: 32,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Belum ada tugas',
                textAlign: TextAlign.center,
                style: tema.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                mataKuliah == null
                    ? 'Ketuk Tambah Tugas untuk mulai mencatat.'
                    : 'Belum ada tugas untuk $mataKuliah.',
                textAlign: TextAlign.center,
                style: tema.textTheme.bodyMedium?.copyWith(
                  color: warna.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatTanggal(DateTime tanggal) {
  const bulan = [
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
  return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
}

String _formatJam(TimeOfDay jam) {
  final jamTeks = jam.hour.toString().padLeft(2, '0');
  final menit = jam.minute.toString().padLeft(2, '0');
  return '$jamTeks.$menit';
}

String _formatTenggat(DateTime tenggat) {
  return '${_formatTanggal(tenggat)} · ${_formatJam(TimeOfDay.fromDateTime(tenggat))}';
}

AppBar _appBarDalam(BuildContext context, String judul) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    scrolledUnderElevation: 0,
    toolbarHeight: 64,
    leading: BackButton(onPressed: () => Navigator.pop(context)),
    title: Text(judul),
  );
}

class _PesanRutePage extends StatelessWidget {
  const _PesanRutePage({required this.judul, required this.pesan});

  final String judul;
  final String pesan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarDalam(context, judul),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(pesan, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class _DetailTugasPage extends StatefulWidget {
  const _DetailTugasPage({required this.tugas});

  final Tugas tugas;

  @override
  State<_DetailTugasPage> createState() => _DetailTugasPageState();
}

class _DetailTugasPageState extends State<_DetailTugasPage> {
  late StatusTugas _status = widget.tugas.status;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    final tugas = widget.tugas;

    return Scaffold(
      appBar: _appBarDalam(context, 'Detail Tugas'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: warna.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: warna.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LencanaStatus(status: tugas.status),
                        const SizedBox(height: 14),
                        Text(
                          tugas.judul,
                          style: tema.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tugas.mataKuliah,
                          style: tema.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Divider(height: 1, color: warna.outlineVariant),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded, color: warna.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tenggat',
                                    style: tema.textTheme.labelMedium?.copyWith(
                                      color: warna.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    _formatTenggat(tugas.tenggat),
                                    style: tema.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Ubah Status',
                  style: tema.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    for (final status in StatusTugas.values)
                      ChoiceChip(
                        avatar: Icon(status.ikon, size: 16),
                        label: Text(status.label),
                        selected: _status == status,
                        showCheckmark: false,
                        onSelected: (_) => setState(() => _status = status),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  onPressed: _status == tugas.status
                      ? null
                      : () => Navigator.pop<StatusTugas>(context, _status),
                  child: const Text('Simpan Status'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormTambahTugasPage extends StatefulWidget {
  const _FormTambahTugasPage({required this.tugasTercatat});

  final List<Tugas> tugasTercatat;

  @override
  State<_FormTambahTugasPage> createState() => _FormTambahTugasPageState();
}

class _FormTambahTugasPageState extends State<_FormTambahTugasPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _jamController = TextEditingController();

  late String _judulSimpan;
  late String _mataKuliahSimpan;
  late DateTime _tanggalSimpan;
  late TimeOfDay _jamSimpan;
  String? _pesanDuplikat;

  @override
  void dispose() {
    _judulController.dispose();
    _tanggalController.dispose();
    _jamController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    FocusScope.of(context).unfocus();
    final pilihan = await showDatePicker(
      context: context,
      initialDate: _bacaTanggal(_tanggalController.text) ?? DateTime.now(),
      firstDate: DateTime(1),
      lastDate: DateTime(9999, 12, 31),
      helpText: 'Pilih tanggal tenggat',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      fieldLabelText: 'Tanggal',
      errorFormatText: 'Gunakan format tanggal yang ditunjukkan.',
      errorInvalidText: 'Pilih tanggal yang valid.',
    );
    if (!mounted || pilihan == null) return;
    final hari = pilihan.day.toString().padLeft(2, '0');
    final bulan = pilihan.month.toString().padLeft(2, '0');
    final tahun = pilihan.year.toString().padLeft(4, '0');
    _tanggalController.text = '$hari/$bulan/$tahun';
  }

  Future<void> _pilihJam() async {
    FocusScope.of(context).unfocus();
    final pilihan = await showTimePicker(
      context: context,
      initialTime: _bacaJam(_jamController.text) ?? TimeOfDay.now(),
      helpText: 'Pilih jam tenggat',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      hourLabelText: 'Jam',
      minuteLabelText: 'Menit',
      errorInvalidText: 'Masukkan jam dan menit yang valid.',
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (!mounted || pilihan == null) return;
    _jamController.text = _formatJam(pilihan).replaceFirst('.', ':');
  }

  DateTime? _bacaTanggal(String? nilai) {
    final bagian = RegExp(r'^(\d{1,2})[/-](\d{1,2})[/-](\d{4})$')
        .firstMatch(nilai?.trim() ?? '');
    if (bagian == null) return null;

    final hari = int.parse(bagian.group(1)!);
    final bulan = int.parse(bagian.group(2)!);
    final tahun = int.parse(bagian.group(3)!);
    if (tahun == 0) return null;

    final tanggal = DateTime(tahun, bulan, hari);
    if (tanggal.year != tahun ||
        tanggal.month != bulan ||
        tanggal.day != hari) {
      return null;
    }
    return tanggal;
  }

  TimeOfDay? _bacaJam(String? nilai) {
    final bagian = RegExp(r'^(\d{1,2})[:.](\d{2})$')
        .firstMatch(nilai?.trim() ?? '');
    if (bagian == null) return null;

    final jam = int.parse(bagian.group(1)!);
    final menit = int.parse(bagian.group(2)!);
    if (jam > 23 || menit > 59) return null;
    return TimeOfDay(hour: jam, minute: menit);
  }

  String? _validasiJudul(String? nilai) {
    final judul = nilai?.trim() ?? '';
    if (judul.isEmpty) return 'Isi judul tugas.';
    if (judul.characters.length > 100) return 'Maksimal 100 karakter.';

    return null;
  }

  void _simpan() {
    if (ModalRoute.of(context)?.isCurrent != true) return;
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    final tugas = Tugas(
      judul: _judulSimpan,
      mataKuliah: _mataKuliahSimpan,
      tenggat: DateTime(
        _tanggalSimpan.year,
        _tanggalSimpan.month,
        _tanggalSimpan.day,
        _jamSimpan.hour,
        _jamSimpan.minute,
      ),
      status: StatusTugas.belumDimulai,
    );
    if (widget.tugasTercatat.any(tugas.identikDengan)) {
      setState(() {
        _pesanDuplikat =
            'Tugas dengan judul, mata kuliah, dan tenggat yang sama sudah ada.';
      });
      return;
    }

    FocusScope.of(context).unfocus();
    Navigator.pop<Tugas>(context, tugas);
  }

  InputDecoration _dekorasi(
    String label, {
    String? petunjuk,
    String? bantuan,
    Widget? aksi,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: petunjuk,
      helperText: bantuan,
      suffixIcon: aksi,
      suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 44),
      errorMaxLines: 3,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: _appBarDalam(context, 'Form Tambah Tugas'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                if (_pesanDuplikat != null) {
                  setState(() => _pesanDuplikat = null);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _judulController,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            decoration: _dekorasi(
                              'Judul tugas',
                              petunjuk: 'Masukkan judul tugas',
                              bantuan: '1–100 karakter',
                            ),
                            validator: _validasiJudul,
                            forceErrorText: _pesanDuplikat,
                            onSaved: (nilai) => _judulSimpan = nilai!.trim(),
                          ),
                          const SizedBox(height: 18),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: _dekorasi('Mata kuliah'),
                            hint: const Text('Pilih mata kuliah'),
                            items: [
                              for (final mataKuliah in _mataKuliah)
                                DropdownMenuItem(
                                  value: mataKuliah,
                                  child: Text(
                                    mataKuliah,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                            onChanged: (_) {},
                            validator: (nilai) => _mataKuliah.contains(nilai)
                                ? null
                                : 'Pilih mata kuliah.',
                            onSaved: (nilai) => _mataKuliahSimpan = nilai!,
                          ),
                          const SizedBox(height: 24),
                          Text('Tenggat', style: tema.textTheme.titleMedium),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _tanggalController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.next,
                                  decoration: _dekorasi(
                                    'Tanggal',
                                    bantuan: 'DD/MM/YYYY',
                                    aksi: IconButton(
                                      tooltip: 'Pilih tanggal lewat kalender',
                                      icon: const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 20,
                                      ),
                                      onPressed: _pilihTanggal,
                                    ),
                                  ),
                                  validator: (nilai) =>
                                      _bacaTanggal(nilai) == null
                                      ? 'Isi tanggal yang valid.'
                                      : null,
                                  onSaved: (nilai) =>
                                      _tanggalSimpan = _bacaTanggal(nilai)!,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _jamController,
                                  keyboardType: TextInputType.datetime,
                                  textInputAction: TextInputAction.done,
                                  decoration: _dekorasi(
                                    'Jam',
                                    bantuan: 'Contoh 23:59',
                                    aksi: IconButton(
                                      tooltip: 'Pilih jam lewat dialog',
                                      icon: const Icon(
                                        Icons.schedule_rounded,
                                        size: 20,
                                      ),
                                      onPressed: _pilihJam,
                                    ),
                                  ),
                                  validator: (nilai) => _bacaJam(nilai) == null
                                      ? 'Isi jam 00:00–23:59.'
                                      : null,
                                  onSaved: (nilai) =>
                                      _jamSimpan = _bacaJam(nilai)!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: _simpan,
                      child: const Text('Simpan'),
                    ),
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
