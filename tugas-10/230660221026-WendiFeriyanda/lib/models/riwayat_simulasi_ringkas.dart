/// Model gabungan yang siap ditampilkan pada halaman Flutter.
/// Data disusun dari DataAktivitasSimulasi dan DataPengguna.
class RiwayatSimulasiRingkas {
  const RiwayatSimulasiRingkas({
    required this.id,
    required this.userId,
    required this.namaPengguna,
    required this.emailPengguna,
    required this.judulAktivitas,
    required this.deskripsiAktivitas,
  });

  final int id;
  final int userId;
  final String namaPengguna;
  final String emailPengguna;
  final String judulAktivitas;
  final String deskripsiAktivitas;
}
