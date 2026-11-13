
import 'package:flutter/material.dart';
import 'service-api.dart';

// ============================================================
// HALAMAN REST API
// ============================================================

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final ServiceApi serviceApi = ServiceApi();

  List<BarangApi> daftarBarang = [];

  bool sedangMemuat = false;
  bool sedangMengirim = false;

  String? pesanError;

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController deskripsiController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  void dispose() {
    namaController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  // ==========================================================
  // GET DATA DARI API
  // ==========================================================

  Future<void> ambilData() async {
    setState(() {
      sedangMemuat = true;
      pesanError = null;
    });

    try {
      final hasil = await serviceApi.ambilDataBarang();

      if (!mounted) return;

      setState(() {
        daftarBarang = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        sedangMemuat = false;
      });
    }
  }

  // ==========================================================
  // MENAMPILKAN FORM TAMBAH DATA
  // ==========================================================

  void tampilkanFormTambah() {
    namaController.clear();
    deskripsiController.clear();

    showDialog(
      context: context,
      barrierDismissible: !sedangMengirim,
      builder: (dialogContext) {
        bool mengirim = false;

        return StatefulBuilder(
          builder: (contextDialog, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Tambah Data Barang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namaController,
                      enabled: !mengirim,
                      decoration: const InputDecoration(
                        labelText: 'Nama Barang',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: deskripsiController,
                      enabled: !mengirim,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Barang',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: mengirim
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                        },
                  child: const Text('Batal'),
                ),

                ElevatedButton.icon(
                  onPressed: mengirim
                      ? null
                      : () async {
                          final nama =
                              namaController.text.trim();

                          final deskripsi =
                              deskripsiController.text.trim();

                          if (nama.isEmpty ||
                              deskripsi.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Nama dan deskripsi harus diisi!',
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() {
                            mengirim = true;
                          });

                          await kirimData(
                            nama,
                            deskripsi,
                          );

                          if (!mounted) return;

                          if (Navigator.canPop(dialogContext)) {
                            Navigator.pop(dialogContext);
                          }
                        },

                  icon: mengirim
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send),

                  label: Text(
                    mengirim ? 'Mengirim...' : 'Kirim',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // POST DATA KE API
  // ==========================================================

  Future<void> kirimData(
    String nama,
    String deskripsi,
  ) async {
    if (!mounted) return;

    setState(() {
      sedangMengirim = true;
    });

    try {
      final hasil = await serviceApi.tambahDataBarang(
        nama: nama,
        deskripsi: deskripsi,
      );

      if (!mounted) return;

      setState(() {
        daftarBarang.insert(0, hasil);
        sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data berhasil dikirim ke API!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengirim data: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ==========================================================
  // TAMPILAN LOADING
  // ==========================================================

  Widget tampilanLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),

          SizedBox(height: 15),

          Text(
            'Sedang mengambil data dari API...',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // TAMPILAN ERROR
  // ==========================================================

  Widget tampilanError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 65,
            ),

            const SizedBox(height: 15),

            const Text(
              'Gagal Mengambil Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              pesanError ?? 'Terjadi kesalahan.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: ambilData,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TAMPILAN BERHASIL
  // ==========================================================

  Widget tampilanData() {
    return RefreshIndicator(
      onRefresh: ambilData,

      child: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Integrasi REST API',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Jumlah data dari API: ${daftarBarang.length}',
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sumber: JSONPlaceholder',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          ...daftarBarang.map((barang) {
            return Card(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),

              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    barang.id.toString(),
                  ),
                ),

                title: Text(
                  barang.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),

                  child: Text(
                    barang.deskripsi,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                trailing: const Icon(
                  Icons.cloud_done,
                  color: Colors.green,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Integrasi REST API',
        ),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        actions: [
          IconButton(
            onPressed: sedangMemuat ? null : ambilData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang Data',
          ),
        ],
      ),

      body: sedangMemuat
          ? tampilanLoading()
          : pesanError != null
              ? tampilanError()
              : tampilanData(),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: sedangMengirim
            ? null
            : tampilkanFormTambah,

        icon: const Icon(Icons.add),

        label: const Text('Tambah Data'),
      ),
    );
  }
}
