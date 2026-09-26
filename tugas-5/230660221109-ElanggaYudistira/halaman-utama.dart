import 'package:flutter/material.dart';

void main() {
  runApp(const MoneyTrackApp());
}

class MoneyTrackApp extends StatelessWidget {
  const MoneyTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyTrack Mahasiswa',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),

      home: const DashboardPage(),
    );
  }
}


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});


  @override
  Widget build(BuildContext context) {

    final transaksi = [
      {
        "nama": "Makan Siang",
        "jumlah": "Rp20.000",
        "status": "Pengeluaran"
      },

      {
        "nama": "Transportasi",
        "jumlah": "Rp10.000",
        "status": "Pengeluaran"
      },

      {
        "nama": "Uang Saku",
        "jumlah": "Rp500.000",
        "status": "Pemasukan"
      },
    ];


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "MoneyTrack Mahasiswa",
        ),
      ),


      body: transaksi.isEmpty

          ? const Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.account_balance_wallet,
                    size: 70,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Belum ada transaksi",
                  ),

                ],
              ),
            )


          : Padding(

              padding:
                  const EdgeInsets.all(16),


              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Card(

                    child: Padding(

                      padding:
                          const EdgeInsets.all(20),


                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          const Text(
                            "Total Saldo",
                          ),


                          const SizedBox(
                            height: 10,
                          ),


                          Text(

                            "Rp1.500.000",

                            style:
                                Theme.of(context)
                                    .textTheme
                                    .headlineMedium,

                          ),

                        ],
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 20,
                  ),


                  Text(

                    "Daftar Transaksi",

                    style:
                        Theme.of(context)
                            .textTheme
                            .titleLarge,

                  ),


                  const SizedBox(
                    height: 10,
                  ),


                  Expanded(

                    child: ListView.builder(

                      itemCount:
                          transaksi.length,


                      itemBuilder:
                          (context,index){


                        final item =
                            transaksi[index];


                        return Card(

                          child: ListTile(


                            leading:
                                const Icon(
                              Icons.receipt_long,
                            ),


                            title:
                                Text(
                              item["nama"]!,
                            ),


                            subtitle:
                                Text(
                              item["jumlah"]!,
                            ),


                            trailing:
                                Text(

                              item["status"]!,


                              style:
                                  TextStyle(

                                color:
                                    item["status"] ==
                                            "Pengeluaran"

                                        ? Theme.of(context)
                                            .colorScheme
                                            .error

                                        : Theme.of(context)
                                            .colorScheme
                                            .primary,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                          ),
                        );

                      },

                    ),
                  ),

                ],

              ),

            ),



      floatingActionButton:

          FloatingActionButton.extended(

            onPressed: () {},


            icon:
                const Icon(
              Icons.add,
            ),


            label:
                const Text(
              "Tambah Transaksi",
            ),

          ),

    );
  }
}