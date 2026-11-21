import 'package:flutter/material.dart';

void main() => runApp(const TaskCampusApp());

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
  final String tenggat;
  final StatusTugas status;
}

const _pab = 'Pemrograman Aplikasi Bergerak';
const _apb = 'Analisis Proses Bisnis';
const _imk = 'Interaksi Manusia dan Komputer';
const _mataKuliah = [_pab, _apb, _imk, 'Basis Data'];

const _contohTugas = <Tugas>[
  Tugas(
    judul: 'Prototype UI/UX TaskCampus',
    mataKuliah: _pab,
    tenggat: '18 Nov 2026 · 23.59',
    status: StatusTugas.dikerjakan,
  ),
  Tugas(
    judul: 'Diagram Proses Bisnis',
    mataKuliah: _apb,
    tenggat: '20 Nov 2026 · 21.00',
    status: StatusTugas.belumDimulai,
  ),
  Tugas(
    judul: 'Rancangan Antarmuka Sistem',
    mataKuliah: _imk,
    tenggat: '23 Nov 2026 · 20.00',
    status: StatusTugas.belumDimulai,
  ),
  Tugas(
    judul: 'Dokumen Kebutuhan dan User Flow',
    mataKuliah: _pab,
    tenggat: '12 Nov 2026 · 23.59',
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
      home: const DaftarTugasPage(),
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
  String? _pilihanMataKuliah;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    final daftarTugas = _pilihanMataKuliah == null
        ? _contohTugas
        : _contohTugas
            .where((tugas) => tugas.mataKuliah == _pilihanMataKuliah)
            .toList();
    final jarakTepi = (MediaQuery.sizeOf(context).width - _lebarKonten) / 2;

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
                  Text(
                    'Daftar Tugas',
                    style: tema.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
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
                            key: ValueKey(_pilihanMataKuliah),
                            padding: const EdgeInsets.only(bottom: 88),
                            itemCount: daftarTugas.length,
                            itemBuilder: (context, index) =>
                                _KartuTugas(tugas: daftarTugas[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: jarakTepi > 0 ? jarakTepi : 0),
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Form Tambah Tugas dirancang untuk Pertemuan 6.'),
                ),
              );
          },
          backgroundColor: warna.primary,
          foregroundColor: warna.onPrimary,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Tambah Tugas'),
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
  const _KartuTugas({required this.tugas});

  final Tugas tugas;

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
                        tugas.tenggat,
                        semanticsLabel: 'Tenggat ${tugas.tenggat}',
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
