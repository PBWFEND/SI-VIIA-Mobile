# Integrasi Data Pengajuan — Tugas 10

Jalankan aplikasi Flutter Web dengan PowerShell:

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_10_web
    flutter pub get
    flutter run -d chrome

Aplikasi mengambil data pengguna dari GET /users dan data pengajuan dari GET /posts secara paralel, lalu mencocokkan userId dengan id. Untuk menguji kondisi error, jalankan:

    flutter run -d chrome --dart-define=API_BASE_URL=https://jsonplaceholder.typicode.com/not-found

Source utama berada di lib/models, lib/services, dan lib/main.dart.
