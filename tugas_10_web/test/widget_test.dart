import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_10_web/models/data_pengajuan.dart';

void main() {
  test('DataPengajuan.fromJson menyediakan nilai default', () {
    final item = DataPengajuan.fromJson(<String, dynamic>{});

    expect(item.id, 0);
    expect(item.userId, 0);
    expect(item.judul, 'Pengajuan tanpa judul');
    expect(item.deskripsi, 'Deskripsi tidak tersedia');
  });
}
