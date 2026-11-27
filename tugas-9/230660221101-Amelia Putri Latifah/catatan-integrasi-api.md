# Catatan Teknis Integrasi REST API — Tugas 9 (PresenGo)

## 1. Kontrak Endpoint API

| Operasi | HTTP Method | URL Endpoint | Status Code Sukses | Keterangan |
| :--- | :--- | :--- | :--- | :--- |
| Ambil Daftar Jadwal | `GET` | `[https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)` | `200 OK` | Mengambil data JSON array dari server lalu memetakannya ke dalam `List<DataKegiatan>`. |
| Tambah Jadwal Baru | `POST` | `[https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)` | `201 Created` | Mengirim payload JSON jadwal kegiatan baru dengan header `Content-Type: application/json; charset=UTF-8`. |

### Contoh Payload Request (`POST`)
```json
{
  "title": "Rapat Koordinasi Proker HIMSIF",
  "body": "13.00 - 15.00 • Sekretariat Himsif",
  "userId": 1
}