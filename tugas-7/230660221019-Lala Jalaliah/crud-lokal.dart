import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSurat());
}

// ======================================================
// MODEL DATA SURAT
// ======================================================

class SuratMasuk {
  final String id;
  final String judul;
  final String pengirim;
  final String status;

  SuratMasuk({
    required this.id,
    required this.judul,
    required this.pengirim,
    required this.status,
  });

  @override
  String toString() {
    return 'SuratMasuk(id: $id, judul: $judul, '
        'pengirim: $pengirim, status: $status)';
  }
}

// ======================================================
// HASIL FORM TAMBAH / EDIT
// ======================================================

class HasilFormSurat {
  final String judul;
  final String pengirim;
  final String status;

  HasilFormSurat({
    required this.judul,
    required this.pengirim,
    required this.status,
  });
}

// ======================================================
// APLIKASI UTAMA
// ======================================================

class AplikasiSurat extends StatelessWidget {
  const AplikasiSurat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Surat UKM',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
      ),
      home: const HalamanSurat(),
    );
  }
}

// ======================================================
// HALAMAN DAFTAR SURAT
// ======================================================

class HalamanSurat extends StatefulWidget {
  const HalamanSurat({super.key});

  @override
  State<HalamanSurat> createState() => _HalamanSuratState();
}

class _HalamanSuratState extends State<HalamanSurat> {
  // DATA LOKAL (in-memory)
  final List<SuratMasuk> _daftarSurat = [
    SuratMasuk(
      id: '1',
      judul: 'Undangan Rapat UKM',
      pengirim: 'BEM Fakultas',
      status: 'Belum diperiksa',
    ),
    SuratMasuk(
      id: '2',
      judul: 'Permohonan Kerja Sama',
      pengirim: 'Himpunan Mahasiswa',
      status: 'Sudah diperiksa',
    ),
    SuratMasuk(
      id: '3',
      judul: 'Pemberitahuan Kegiatan',
      pengirim: 'Fakultas',
      status: 'Belum diperiksa',
    ),
    SuratMasuk(
      id: '4',
      judul: 'Undangan Seminar',
      pengirim: 'UKM Mahasiswa',
      status: 'Sudah diperiksa',
    ),
  ];

  String _role = 'Pengurus';
  String _kataKunci = '';

  bool get _adalahSekretaris => _role == 'Sekretaris';

  // ====================================================
  // CREATE - TAMBAH SURAT
  // ====================================================

  Future<void> _tambahSurat() async {
    final hasil = await showDialog<HasilFormSurat>(
      context: context,
      builder: (context) {
        return const FormSuratDialog(
          judulDialog: 'Tambah Surat',
          teksTombol: 'Simpan',
          bolehUbahStatus: false,
        );
      },
    );

    if (!mounted || hasil == null) return;

    setState(() {
      _daftarSurat.add(
        SuratMasuk(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          judul: hasil.judul,
          pengirim: hasil.pengirim,
          status: 'Belum diperiksa',
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Surat berhasil ditambahkan'),
      ),
    );
  }

  // ====================================================
  // UPDATE - EDIT SURAT
  // ====================================================

  Future<void> _editSurat(SuratMasuk surat) async {
    if (!_adalahSekretaris) return;

    final hasil = await showDialog<HasilFormSurat>(
      context: context,
      builder: (context) {
        return FormSuratDialog(
          judulDialog: 'Edit Surat',
          teksTombol: 'Simpan Perubahan',
          surat: surat,
          bolehUbahStatus: true,
        );
      },
    );

    if (!mounted || hasil == null) return;

    setState(() {
      // id dipakai sebagai kunci, bukan index daftar
      final index = _daftarSurat.indexWhere(
        (item) => item.id == surat.id,
      );

      if (index != -1) {
        _daftarSurat[index] = SuratMasuk(
          id: surat.id,
          judul: hasil.judul,
          pengirim: hasil.pengirim,
          status: hasil.status,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Surat berhasil diperbarui'),
      ),
    );
  }

  // ====================================================
  // DELETE - KONFIRMASI DAN HAPUS SURAT
  // ====================================================

  Future<void> _konfirmasiHapus(SuratMasuk surat) async {
    if (!_adalahSekretaris) return;

    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Surat'),
          content: Text(
            'Apakah Anda yakin ingin menghapus surat '
            '"${surat.judul}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!mounted || yakin != true) return;

    setState(() {
      _daftarSurat.removeWhere(
        (item) => item.id == surat.id,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Surat berhasil dihapus'),
      ),
    );
  }

  // ====================================================
  // READ - DETAIL SURAT
  // ====================================================

  void _lihatDetail(SuratMasuk surat) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Detail Surat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ID Surat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(surat.id),

              const SizedBox(height: 12),

              const Text(
                'Judul Surat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(surat.judul),

              const SizedBox(height: 12),

              const Text(
                'Pengirim',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(surat.pengirim),

              const SizedBox(height: 12),

              const Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(surat.status),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // ====================================================
  // PENCARIAN
  // ====================================================

  List<SuratMasuk> get _suratDitampilkan {
    if (_kataKunci.isEmpty) {
      return _daftarSurat;
    }

    return _daftarSurat.where((surat) {
      final kataKunci = _kataKunci.toLowerCase();

      return surat.judul.toLowerCase().contains(kataKunci) ||
          surat.pengirim.toLowerCase().contains(kataKunci);
    }).toList();
  }

  // ====================================================
  // WARNA DAN LENCANA STATUS
  // ====================================================

  Color _warnaStatus(String status) {
    if (status == 'Belum diperiksa') {
      return Colors.redAccent;
    }

    return Colors.deepPurple;
  }

  // Lencana status memuat teks, jadi tidak bergantung
  // pada warna saja untuk membedakan status.
  Widget _lencanaStatus(String status) {
    final belumDiperiksa = status == 'Belum diperiksa';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: belumDiperiksa
            ? const Color(0xFFFFE5E5)
            : const Color(0xFFF1E8FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _warnaStatus(status),
        ),
      ),
    );
  }

  // ====================================================
  // KARTU RINGKASAN
  // ====================================================

  Widget _kartuRingkasan({
    required String judul,
    required int jumlah,
    required IconData ikon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              color: Colors.deepPurple,
              size: 24,
            ),
            const SizedBox(height: 6),
            Text(
              judul,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              jumlah.toString(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bagianRingkasan() {
    final belumDicek = _daftarSurat
        .where(
          (surat) => surat.status == 'Belum diperiksa',
        )
        .length;

    return Row(
      children: [
        _kartuRingkasan(
          judul: 'Total Surat',
          jumlah: _daftarSurat.length,
          ikon: Icons.mail_outline,
        ),
        const SizedBox(width: 12),
        _kartuRingkasan(
          judul: 'Belum Dicek',
          jumlah: belumDicek,
          ikon: Icons.mark_email_unread_outlined,
        ),
      ],
    );
  }

  // ====================================================
  // ITEM DAFTAR SURAT
  // ====================================================

  Widget _itemSurat(SuratMasuk surat) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFF1E8FF),
          child: Icon(
            Icons.mail_outline,
            color: Colors.deepPurple,
            size: 20,
          ),
        ),
        title: Text(
          surat.judul,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Pengirim dan status tampil untuk semua peran (F-07)
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                surat.pengirim,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              _lencanaStatus(surat.status),
            ],
          ),
        ),
        onTap: () {
          _lihatDetail(surat);
        },

        // Menu edit dan hapus hanya untuk Sekretaris
        trailing: _adalahSekretaris
            ? PopupMenuButton<String>(
                onSelected: (pilihan) {
                  if (pilihan == 'edit') {
                    _editSurat(surat);
                  } else if (pilihan == 'hapus') {
                    _konfirmasiHapus(surat);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'hapus',
                    child: Text(
                      'Hapus',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            : const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
      ),
    );
  }

  // ====================================================
  // KONDISI KOSONG
  // ====================================================

  Widget _kondisiKosong() {
    final daftarMemangKosong = _daftarSurat.isEmpty;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 56,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            daftarMemangKosong
                ? 'Belum ada surat masuk'
                : 'Surat tidak ditemukan',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // TAMPILAN UTAMA
  // ====================================================

  @override
  Widget build(BuildContext context) {
    final daftarTampil = _suratDitampilkan;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JUDUL
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
              child: Text(
                'Surat Masuk UKM',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Kelola surat masuk dengan mudah',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // RINGKASAN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _bagianRingkasan(),
            ),

            const SizedBox(height: 14),

            // PILIH PERAN (simulasi hak akses)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 18,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Masuk sebagai: ',
                    style: TextStyle(fontSize: 13),
                  ),
                  DropdownButton<String>(
                    value: _role,
                    isDense: true,
                    underline: const SizedBox(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Pengurus',
                        child: Text('Pengurus'),
                      ),
                      DropdownMenuItem(
                        value: 'Sekretaris',
                        child: Text('Sekretaris'),
                      ),
                    ],
                    onChanged: (nilai) {
                      if (nilai != null) {
                        setState(() {
                          _role = nilai;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // KOLOM PENCARIAN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Cari judul atau pengirim...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                onChanged: (nilai) {
                  setState(() {
                    _kataKunci = nilai;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            // JUDUL DAFTAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Daftar Surat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${daftarTampil.length} surat',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // LISTVIEW BUILDER - READ
            Expanded(
              child: daftarTampil.isEmpty
                  ? _kondisiKosong()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        90,
                      ),
                      itemCount: daftarTampil.length,
                      itemBuilder: (context, index) {
                        return _itemSurat(daftarTampil[index]);
                      },
                    ),
            ),
          ],
        ),
      ),

      // TOMBOL TAMBAH
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahSurat,
        backgroundColor: const Color(0xFFE9D7FF),
        foregroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Surat'),
      ),
    );
  }
}

// ======================================================
// FORM TAMBAH DAN EDIT SURAT
// ======================================================

class FormSuratDialog extends StatefulWidget {
  final String judulDialog;
  final String teksTombol;
  final SuratMasuk? surat;
  final bool bolehUbahStatus;

  const FormSuratDialog({
    super.key,
    required this.judulDialog,
    required this.teksTombol,
    this.surat,
    required this.bolehUbahStatus,
  });

  @override
  State<FormSuratDialog> createState() =>
      _FormSuratDialogState();
}

class _FormSuratDialogState extends State<FormSuratDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _judulController;
  late final TextEditingController _pengirimController;

  String _status = 'Belum diperiksa';

  final List<String> _pilihanStatus = [
    'Belum diperiksa',
    'Sudah diperiksa',
  ];

  @override
  void initState() {
    super.initState();

    _judulController = TextEditingController(
      text: widget.surat?.judul ?? '',
    );

    _pengirimController = TextEditingController(
      text: widget.surat?.pengirim ?? '',
    );

    _status = widget.surat?.status ?? 'Belum diperiksa';
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pengirimController.dispose();
    super.dispose();
  }

  // Validasi dulu, lalu kirim hasil form ke halaman daftar.
  void _simpanForm() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      HasilFormSurat(
        judul: _judulController.text.trim(),
        pengirim: _pengirimController.text.trim(),
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.judulDialog),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Surat',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Judul surat wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _pengirimController,
                decoration: const InputDecoration(
                  labelText: 'Pengirim',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Pengirim wajib diisi';
                  }
                  return null;
                },
              ),

              // STATUS HANYA SAAT EDIT (oleh Sekretaris)
              if (widget.bolehUbahStatus) ...[
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status Surat',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                  items: _pilihanStatus.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (nilai) {
                    if (nilai != null) {
                      setState(() {
                        _status = nilai;
                      });
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _simpanForm,
          child: Text(widget.teksTombol),
        ),
      ],
    );
  }
}