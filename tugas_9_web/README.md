# MoneyTrack REST API — Tugas 9

Jalankan aplikasi Flutter Web dengan PowerShell:

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_9_web
    flutter pub get
    flutter run -d chrome

Aplikasi mengambil data melalui GET JSONPlaceholder dan mengirim transaksi melalui POST. Untuk menguji tampilan error dengan endpoint yang salah, jalankan:

    flutter run -d chrome --dart-define=API_BASE_URL=https://jsonplaceholder.typicode.com/not-found

Source utama berada di lib/service_api.dart dan lib/halaman_api.dart.
