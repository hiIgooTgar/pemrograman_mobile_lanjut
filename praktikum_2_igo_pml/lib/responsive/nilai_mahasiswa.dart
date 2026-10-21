import 'package:flutter/material.dart';
import 'package:praktikum_2_igo_pml/data_source/data_source.dart';

class NilaiMahasiswa extends StatefulWidget {
  final bool lebar;
  final String judul;
  final Mahasiswa mahasiswa;
  const NilaiMahasiswa({
    super.key,
    required this.mahasiswa,
    required this.judul,
    required this.lebar,
  });
  @override
  State<NilaiMahasiswa> createState() => _NilaiMahasiswaState();
}

class _NilaiMahasiswaState extends State<NilaiMahasiswa> {
  static const Color primaryNavy = Color(0xFF0A2481);

  @override
  Widget build(BuildContext context) {
    var mhs = widget.mahasiswa;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(widget.judul),
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(mhs.foto)),
              title: Text(mhs.nim),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(mhs.nama), Text(mhs.email), Text(mhs.prodi)],
              ),
            ),
          ),
          (MediaQuery.of(context).size.width < 1024 || widget.lebar)
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mhs.nilai
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kode Matakuliah : ${e.kodeMatakuliah}",
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Nama Matakuliah : ${e.namaMatakuliah}",
                                        ),
                                        const SizedBox(height: 4),
                                        Text("SKS : ${e.sks}"),
                                        const SizedBox(height: 4),
                                        Text("Nilai UTS : ${e.nilaiUts}"),
                                        const SizedBox(height: 4),
                                        Text("Nilai UAS : ${e.nilaiUas}"),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Nilai Presensi : ${e.nilaiPresensi}",
                                        ),
                                        const SizedBox(height: 4),
                                        Text("Nilai Tugas : ${e.nilaiTugas}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Expanded(flex: 1, child: Text("Kode Matakuliah")),
                            Expanded(flex: 3, child: Text("Nama Matakuliah")),
                            Expanded(flex: 1, child: Text("SKS")),
                            Expanded(flex: 1, child: Text("Nilai UTS")),
                            Expanded(flex: 1, child: Text("Nilai Uas")),
                            Expanded(flex: 1, child: Text("Nilai Presensi")),
                            Expanded(flex: 1, child: Text("Nilai Tugas")),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: mhs.nilai
                              .map(
                                (e) => Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.kodeMatakuliah),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(e.namaMatakuliah),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.sks.toString()),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.nilaiUts.toString()),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.nilaiUas.toString()),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.nilaiPresensi.toString()),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(e.nilaiTugas.toString()),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
