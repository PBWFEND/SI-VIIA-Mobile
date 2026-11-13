# Catatan Keputusan Data — Tugas 7

| Keputusan | Pilihan Saya | Alasan (Merujuk Kebutuhan) |
|:---|:---|:---|
| Field model | `id`, `judul`, `penulis`, `status` | Memenuhi kebutuhan minimal F-01 dan F-03 dari Tugas 4. |
| Kunci data (`id`) | `DateTime.now().millisecondsSinceEpoch.toString()` | Menjamin keunikan kunci agar operasi Update & Delete tidak salah sasaran. |
| Operasi CRUD per kebutuhan | Create (Form), Read (ListView), Update (Toggle status), Delete (AlertDialog) | Mendukung seluruh alur interaksi pengguna tanpa perlu backend di MVP awal. |
| Keputusan persistensi | In-Memory (StatefulWidget) | Memenuhi batas cakupan Tugas 7 dan dapat dijalankan langsung tanpa kendala package eksternal. |