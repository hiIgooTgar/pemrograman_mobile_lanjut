import 'package:flutter/material.dart';
import 'package:praktikum_2_igo_pml/data_source/data_source.dart';
import 'package:praktikum_2_igo_pml/responsive/nilai_mahasiswa.dart';
import 'package:praktikum_2_igo_pml/responsive/total_mahasiswa.dart';

class DataMahasiswaLayarKecil extends StatefulWidget {
  const DataMahasiswaLayarKecil({super.key});
  @override
  State<DataMahasiswaLayarKecil> createState() =>
      _DataMahasiswaLayarKecilState();
}

class _DataMahasiswaLayarKecilState extends State<DataMahasiswaLayarKecil> {
  static const Color primaryNavy = Color(0xFF0A2481);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F6FA),
      child: Column(
        children: [
          TotalMahasiswa(),
          Expanded(
            child: ListView.builder(
              itemCount: mahasiswaList.length,
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
    );
  }
}
