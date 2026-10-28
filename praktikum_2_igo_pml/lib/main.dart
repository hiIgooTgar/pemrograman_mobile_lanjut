import 'package:flutter/material.dart';
import 'package:praktikum_2_igo_pml/responsive/constanta.dart';
import 'package:praktikum_2_igo_pml/responsive/data_mahasiswa_layar_kecil.dart';
import 'package:praktikum_2_igo_pml/responsive/data_mahasiswa_layar_lebar.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color primaryNavy = Color(0xFF0A2481);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HalamanUtama());
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  static const Color primaryNavy = Color(0xFF0A2481);

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Latihan Responsif"),
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: lebarLayar <= layarKecil
          ? DataMahasiswaLayarKecil()
          : DataMahasiswaLayarLebar(),
      bottomNavigationBar: lebarLayar <= layarKecil
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: primaryNavy,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Informatika",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Sistem Informasi",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Teknologi Informasi",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.high_quality),
                  label: "Terbaik",
                ),
              ],
            )
          : null,
      drawer: lebarLayar <= layarKecil
          ? null
          : Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: primaryNavy),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: primaryNavy),
                          ),
                          Text(
                            "Menu Utama",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.home, color: primaryNavy),
                          title: Text(
                            "Home",
                            style: TextStyle(color: primaryNavy),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.people, color: primaryNavy),
                          title: Text(
                            "Informatika",
                            style: TextStyle(color: primaryNavy),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.people, color: primaryNavy),
                          title: Text(
                            "Sistem Informasi",
                            style: TextStyle(color: primaryNavy),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.people, color: primaryNavy),
                          title: Text(
                            "Teknologi Informasi",
                            style: TextStyle(color: primaryNavy),
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
