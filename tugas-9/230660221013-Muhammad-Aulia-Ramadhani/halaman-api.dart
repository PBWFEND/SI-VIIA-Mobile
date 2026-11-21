import 'package:flutter/material.dart';
import 'service-api.dart';

class HalamanApi extends StatefulWidget {
  final Function(MenuKantin)? onPesanMenu;

  const HalamanApi({super.key, this.onPesanMenu});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final ApiService apiService = ApiService();
  late Future<List<MenuKantin>> futureMenu;

  // Penampung item baru hasil POST agar langsung tampil di urutan paling atas UI
  final List<MenuKantin> _menuBaruLokal = [];

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      futureMenu = apiService.fetchMenu();
    });
  }

  void _tambahData() async {
    if (_namaController.text.isNotEmpty && _hargaController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mengirim menu baru ke server...')),
      );

      try {
        final menuBaru = await apiService.tambahMenu(
          _namaController.text.trim(),
          int.parse(_hargaController.text.trim()),
        );
        _namaController.clear();
        _hargaController.clear();

        setState(() {
          _menuBaruLokal.insert(0, menuBaru);
        });

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Sukses (201): Menu berhasil ditambahkan!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Menu Kantin (API)'),
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh API',
            onPressed: _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Form POST
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Menu Baru (POST)',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _hargaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Harga',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.send),
                  onPressed: _tambahData,
                )
              ],
            ),
          ),
          const Divider(height: 1),
          // Daftar GET + Hasil POST
          Expanded(
            child: FutureBuilder<List<MenuKantin>>(
              future: futureMenu,
              builder: (context, snapshot) {
                // 1. Kondisi Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // 2. Kondisi Error
                else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadData,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // 3. Kondisi Sukses
                else if (snapshot.hasData) {
                  final gabunganMenu = [..._menuBaruLokal, ...snapshot.data!];

                  if (gabunganMenu.isEmpty) {
                    return const Center(child: Text('Tidak ada data menu.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: gabunganMenu.length,
                    itemBuilder: (context, index) {
                      final menu = gabunganMenu[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrange.shade100,
                            child: const Icon(Icons.fastfood, color: Colors.deepOrange),
                          ),
                          title: Text(
                            menu.namaMenu,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Rp ${menu.harga}'),
                          trailing: widget.onPesanMenu != null
                              ? FilledButton.tonalIcon(
                                  onPressed: () => widget.onPesanMenu!(menu),
                                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                                  label: const Text('Pesan'),
                                )
                              : null,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Tidak ada data menu.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}