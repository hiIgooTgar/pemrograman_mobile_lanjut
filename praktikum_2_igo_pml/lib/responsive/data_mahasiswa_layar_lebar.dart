import 'package:flutter/material.dart';
import 'package:praktikum_2_igo_pml/data_source/data_source.dart';
import 'package:praktikum_2_igo_pml/responsive/constanta.dart';
import 'package:praktikum_2_igo_pml/responsive/nilai_mahasiswa.dart';
import 'package:praktikum_2_igo_pml/responsive/total_mahasiswa.dart';

class DataMahasiswaLayarLebar extends StatefulWidget {
  const DataMahasiswaLayarLebar({super.key});
  @override
  State<DataMahasiswaLayarLebar> createState() =>
      _DataMahasiswaLayarLebarState();
}

class _DataMahasiswaLayarLebarState extends State<DataMahasiswaLayarLebar> {
  static const Color primaryNavy = Color(0xFF0A2481);

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFFF5F6FA),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              children: [
                TotalMahasiswa(),
                Expanded(
                  child: GridView.builder(
                    itemCount: mahasiswaList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: lebarLayar < layarLebar ? 2 : 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 5 / 3,
                    ),
                    itemBuilder: (context, index) {
                      var mahasiswa = mahasiswaList[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NilaiMahasiswa(
                                  mahasiswa: mahasiswa,
                                  judul: "Nilai Mahasiswa",
                                  lebar: false,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: primaryNavy,
                            backgroundImage: NetworkImage(mahasiswa.foto),
                          ),
                          title: Text(
                            mahasiswa.nim,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryNavy,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mahasiswa.nama),
                              Text(mahasiswa.email),
                              Text(mahasiswa.prodi),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          lebarLayar >= layarLebar
              ? Expanded(
                  flex: 2,
                  child: NilaiMahasiswa(
                    mahasiswa: mahasiswaList[0],
                    judul: "Mahasiswa Terbaik",
                    lebar: true,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
