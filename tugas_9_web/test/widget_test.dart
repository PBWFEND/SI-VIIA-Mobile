import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_9_web/service_api.dart';

void main() {
  test('TransaksiApi.fromJson memakai nilai cadangan', () {
    final item = TransaksiApi.fromJson(<String, dynamic>{});

    expect(item.id, 0);
    expect(item.nama, 'Transaksi tanpa nama');
    expect(item.jumlah, 10000);
    expect(item.kategori, 'API Demo');
  });
}
