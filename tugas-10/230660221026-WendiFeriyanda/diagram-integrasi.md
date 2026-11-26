# Diagram Integrasi Data — SI RAKUS Tugas 10

## 1. Diagram Alur Data

```mermaid
flowchart TD
    A[HalamanIntegrasi] --> B[IntegrasiService.ambilDataTerintegrasi]
    B --> C1[GET /users]
    B --> C2[GET /posts]
    C1 --> D1[Response JSON pengguna]
    C2 --> D2[Response JSON aktivitas simulasi]
    D1 --> E1[DataPengguna.fromJson]
    D2 --> E2[DataAktivitasSimulasi.fromJson]
    E1 --> F[Future.wait mengumpulkan dua hasil]
    E2 --> F
    F --> G[Cocokkan users.id dengan posts.userId]
    G --> H[RiwayatSimulasiRingkas]
    H --> I[Halaman menampilkan daftar]
```

## 2. Diagram Relasi Identifier

```mermaid
erDiagram
    DATA_PENGGUNA ||--o{ DATA_AKTIVITAS_SIMULASI : "users.id = posts.userId"
    DATA_PENGGUNA {
        int id PK
        string nama
        string email
    }
    DATA_AKTIVITAS_SIMULASI {
        int id PK
        int userId FK
        string judulAktivitas
        string deskripsiAktivitas
    }
```

Keterangan: `users.id` menjadi identifier pengguna, sedangkan `posts.userId` mengacu kepada ID pengguna yang terkait dengan aktivitas simulasi. Satu pengguna dapat memiliki beberapa aktivitas.

## 3. Diagram State Halaman

```mermaid
stateDiagram-v2
    [*] --> Loading
    Loading --> Success: kedua request berhasil dan data tersedia
    Loading --> Empty: request berhasil, hasil penggabungan kosong
    Loading --> Error: request gagal / timeout / response tidak sesuai
    Error --> Loading: pengguna menekan Coba Lagi
    Empty --> Loading: pengguna memuat ulang
    Success --> Loading: pengguna refresh
```

## 4. Penjelasan `Future.wait`

GET `/users` dan GET `/posts` dijalankan secara bersamaan karena keduanya tidak membutuhkan hasil satu sama lain. Setelah keduanya selesai, service menggabungkan hasilnya menggunakan `users.id` dan `posts.userId`. Jika salah satu request gagal, proses integrasi ditangani sebagai error dan halaman menampilkan pesan serta tombol Coba Lagi.

## 5. Batasan Diagram

Endpoint yang digambarkan merupakan API simulasi JSONPlaceholder. Diagram ini menunjukkan teknik integrasi beberapa endpoint, bukan arsitektur produksi perpustakaan atau koneksi ke Libsys.
