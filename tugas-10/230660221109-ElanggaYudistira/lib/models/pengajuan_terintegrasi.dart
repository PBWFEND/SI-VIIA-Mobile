import 'data_pengajuan.dart';
import 'data_pengguna.dart';

class PengajuanTerintegrasi {
  final DataPengajuan pengajuan;
  final DataPengguna? pemohon;

  const PengajuanTerintegrasi({required this.pengajuan, required this.pemohon});

  String get namaPemohon => pemohon?.nama ?? 'Pemohon tidak ditemukan';
  String get emailPemohon => pemohon?.email ?? 'Email tidak tersedia';
  String get organisasiPemohon =>
      pemohon?.organisasi ?? 'Organisasi tidak tersedia';
}
