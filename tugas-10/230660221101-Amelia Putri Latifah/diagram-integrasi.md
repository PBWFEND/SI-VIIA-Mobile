flowchart TD
    A[HalamanIntegrasiJadwal] -->|initState / Refresh / Coba Lagi| B[IntegrasiPresenGoService.ambilJadwalTerintegrasi]
    B -->|Future.wait| C1[GET /users -> List DataPengguna]
    B -->|Future.wait| C2[GET /posts -> List DataKegiatanApi]
    B -->|Future.wait| C3[GET /comments -> List DataRuangSimulasi]
    C1 --> D{Status 200 & JSON Valid?}
    C2 --> D
    C3 --> D
    D -->|Gagal / Timeout / 404 / 500| E[Lempar Exception ke Halaman -> State Error + Tombol Coba Lagi]
    D -->|Berhasil| F[Gabungkan via userId & roomId -> List DataJadwalTerintegrasi]
    F --> G{List Kosong?}
    G -->|Ya| H[State Kosong]
    G -->|Tidak| I[State Sukses: Tampilkan ListView Jadwal]