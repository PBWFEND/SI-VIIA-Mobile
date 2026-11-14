import 'package:flutter/material.dart';

void main() {
  runApp(const KantinKampusApp());
}

class KantinKampusApp extends StatelessWidget {
  const KantinKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // Peta Route
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanKatalogUtama(),
        '/detail': (context) => const HalamanDetailMenu(),
      },
    );
  }
}

// -----------------------------------------------------------------------------
// LAYAR 1: KATALOG UTAMA (initialRoute: '/')
// -----------------------------------------------------------------------------
class HalamanKatalogUtama extends StatelessWidget {
  const HalamanKatalogUtama({super.key});

  final List<Map<String, dynamic>> daftarMenu = const [
    {
      'id': 'M-01',
      'nama': 'Nasi Goreng Spesial',
      'kategori': 'Makanan Utama',
      'harga': 'Rp 15.000',
      'isTersedia': true,
    },
    {
      'id': 'M-02',
      'nama': 'Ayam Geprek Sambal Matah',
      'kategori': 'Makanan Utama',
      'harga': 'Rp 18.000',
      'isTersedia': true,
    },
    {
      'id': 'M-03',
      'nama': 'Es Teh Manis Jumbo',
      'kategori': 'Minuman',
      'harga': 'Rp 5.000',
      'isTersedia': true,
    },
    {
      'id': 'M-04',
      'nama': 'Jus Alpukat Kocok',
      'kategori': 'Minuman',
      'harga': 'Rp 10.000',
      'isTersedia': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kantin Teknik — Katalog Menu'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          final bool isTersedia = item['isTersedia'] as bool;

          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              leading: CircleAvatar(
                backgroundColor: isTersedia
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHighest,
                child: Icon(
                  item['kategori'] == 'Minuman'
                      ? Icons.local_drink
                      : Icons.fastfood,
                  color: isTersedia
                      ? colorScheme.primary
                      : colorScheme.outline,
                ),
              ),
              title: Text(
                item['nama'].toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${item['kategori']} • ${item['harga']}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigasi Maju dengan Arguments
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// LAYAR 2: DETAIL MENU & FORM INTERAKSI ('/detail')
// -----------------------------------------------------------------------------
class HalamanDetailMenu extends StatefulWidget {
  const HalamanDetailMenu({super.key});

  @override
  State<HalamanDetailMenu> createState() => _HalamanDetailMenuState();
}

class _HalamanDetailMenuState extends State<HalamanDetailMenu> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Pembersihan Controller pada dispose()
    _catatanController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _submitForm(String namaMenu) {
    if (_formKey.currentState!.validate()) {
      // SnackBar Feedback setelah Kirim
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Berhasil memesan $namaMenu (${_jumlahController.text} porsi)!',
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Navigasi Kembali
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Pemeriksaan Tipe Data & Cabang Null Arguments
    final rawArgs = ModalRoute.of(context)?.settings.arguments;
    if (rawArgs == null || rawArgs is! Map<String, dynamic>) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error Data')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Data menu tidak ditemukan atau tidak valid.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    final Map<String, dynamic> menuData = rawArgs;
    final bool isTersedia = menuData['isTersedia'] as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(menuData['nama']?.toString() ?? 'Detail Menu'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigasi Kembali
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Detail Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Text(
                    menuData['nama']?.toString() ?? '',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${menuData['kategori']} • ${menuData['harga']}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Interaksi
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Text(
                    'Form Pemesanan',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Field Jumlah Porsi dengan Validator
                  TextFormField(
                    controller: _jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Porsi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.format_list_numbered),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Jumlah porsi wajib diisi.';
                      }
                      final n = int.tryParse(value);
                      if (n == null || n <= 0) {
                        return 'Jumlah porsi harus berupa angka lebih dari 0.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field Catatan Pesanan dengan Validator
                  TextFormField(
                    controller: _catatanController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Catatan Khusus (mis. Pedas/Tanpa Sayur)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.note_add),
                    ),
                    validator: (value) {
                      if (value != null && value.length > 100) {
                        return 'Catatan maksimal 100 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Tombol Kirim Form
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: isTersedia
                          ? () => _submitForm(menuData['nama'].toString())
                          : null,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: Text(
                        isTersedia ? 'Kirim Pesanan' : 'Stok Habis',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}