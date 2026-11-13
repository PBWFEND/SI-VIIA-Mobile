
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments;

    final DataPengaduan? laporan =
        args is DataPengaduan ? args : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengaduan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: laporan == null
            ? const Center(
                child: Text(
                  'Data pengaduan tidak tersedia.',
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laporan.id,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 30),
                  Text('Kategori: ${laporan.kategori}'),
                  const SizedBox(height: 12),
                  Text('Deskripsi: ${laporan.deskripsi}'),
                  const SizedBox(height: 12),
                  Text('Tanggal: ${laporan.tanggal}'),
                  const SizedBox(height: 12),
                  Text('Status: ${laporan.status}'),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
