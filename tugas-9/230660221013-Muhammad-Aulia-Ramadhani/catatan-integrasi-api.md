# Catatan Teknis Integrasi API — KantinApp

## 1. Tabel Endpoint API

| Operasi | Endpoint URL | HTTP Method | Payload Request (JSON) | Contoh Response (JSON) |
|:---|:---|:---|:---|:---|
| **Ambil Daftar Menu** | `https://jsonplaceholder.typicode.com/posts?_limit=10` | `GET` | *(Tidak ada)* | `[{"id": 1, "title": "sunt aut facere..."}]` |
| **Tambah Menu Baru** | `https://jsonplaceholder.typicode.com/posts` | `POST` | `{"title": "Nasi Goreng", "harga": 15000}` | `{"id": 101, "title": "Nasi Goreng", "harga": 15000}` |

## 2. Struktur Data Model & Sinkronisasi UI
Model data `MenuKantin` memiliki tiga field bertipe `final`: `id` (`String`), `namaMenu` (`String`), dan `harga` (`int`). Proses parsing dilakukan melalui *factory constructor* `MenuKantin.fromJson(Map<String, dynamic> json)` yang memetakan properti JSON dari server menjadi objek Dart yang *type-safe* (mengonversi `title` menjadi `namaMenu` dan menghitung simulasi harga dari `id`).

Karena endpoint pengujian publik bersifat *non-persistent* (data `POST` dibalas sukses `201 Created` tetapi tidak disimpan permanen di database server), antarmuka menggunakan penampung sementara `_menuBaruLokal` untuk menyisipkan objek hasil respons `POST` langsung ke bagian teratas daftar katalog agar perubahan segera terlihat oleh pengguna.

## 3. Strategi Penanganan Error (Error Handling)
Penanganan kesalahan pada class `ApiService` diterapkan dalam tiga lapisan pengamanan:
1. **Batas Waktu (Timeout):** Menggunakan `.timeout(const Duration(seconds: 10))` pada setiap panggilan `http.get` dan `http.post` agar aplikasi tidak menggantung (*hang*) ketika koneksi lambat.
2. **Validasi Status Code HTTP:** Memastikan server mengembalikan kode `200` (OK) untuk operasi `GET` dan `201` (Created) untuk operasi `POST`. Kode status di luar ketentuan akan memicu pelemparan `Exception` dengan informasi kode statusnya.
3. **Blok `try-catch`:** Menangkap kegagalan jaringan (seperti perangkat *offline*, DNS tidak ditemukan, atau kesalahan URL) dan meneruskannya ke `FutureBuilder` untuk merender tampilan error lengkap beserta tombol **Coba Lagi**.