import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_state.dart';

class MahasiswaPage extends StatelessWidget {
  static const Color primaryNavy = Color(0xFF0A2481);
  const MahasiswaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MahasiswaBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clean Architecture",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<MahasiswaBloc, MahasiswaState>(
        builder: (context, state) {
          if (state is MahasiswaInitial || state is MahasiswaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MahasiswaLoaded) {
            final data = state.mahasiswaList;
            return Column(
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Cari Mahasiswa (Nama/NIM)",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      bloc.add(SearchMahasiswaEvent(query));
                    },
                  ),
                ),
                Expanded(
                  child: data.isEmpty
                      ? const Center(
                          child: Text(
                            "Data mahasiswa tidak terdata. Tekan + untuk menambahkan data.",
                            style: TextStyle(
                              color: primaryNavy,
                              fontWeight: FontWeight(500),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(16),
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              final mhs = data[i];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: const Color.fromARGB(120, 0, 0, 0),
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 3.0,
                                    right: 3.0,
                                    top: 6.0,
                                    bottom: 6.0,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${mhs.nama} (${mhs.nim})",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Prodi: ${mhs.prodi}"),
                                        Text("Email: ${mhs.email}"),
                                        Text("Semester: ${mhs.semester}"),
                                        Text("No. HP: ${mhs.nomorHp}"),
                                        Text("Alamat: ${mhs.alamat}"),
                                        Text("IPK: ${mhs.ipk}"),
                                      ],
                                    ),
                                    isThreeLine: true,
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showForm(context, bloc, mhs: mhs);
                                          },
                                          iconSize: 19.0,
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            bloc.add(
                                              DeleteMahasiswaEvent(mhs.nim),
                                            );
                                          },
                                          iconSize: 19.0,
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          } else if (state is MahasiswaError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, bloc),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext context, MahasiswaBloc bloc, {Mahasiswa? mhs}) {
    final nimCtrl = TextEditingController(text: mhs?.nim ?? '');
    final namaCtrl = TextEditingController(text: mhs?.nama ?? '');
    final emailCtrl = TextEditingController(text: mhs?.email ?? '');
    final prodiCtrl = TextEditingController(text: mhs?.prodi ?? '');
    final semesterCtrl = TextEditingController(
      text: mhs?.semester.toString() ?? '',
    );
    final nomorHpCtrl = TextEditingController(text: mhs?.nomorHp ?? '');
    final alamatCtrl = TextEditingController(text: mhs?.alamat ?? '');
    final ipkCtrl = TextEditingController(text: mhs?.ipk.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          mhs == null ? "Tambah Mahasiswa" : "Edit Mahasiswa",
          style: TextStyle(color: primaryNavy, fontWeight: FontWeight(600)),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nimCtrl,
                decoration: const InputDecoration(labelText: "NIM"),
              ),
              TextField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: prodiCtrl,
                decoration: const InputDecoration(labelText: "Prodi"),
              ),
              TextField(
                controller: semesterCtrl,
                decoration: const InputDecoration(labelText: "Semester"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nomorHpCtrl,
                decoration: const InputDecoration(labelText: "Nomor HP"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: alamatCtrl,
                decoration: const InputDecoration(labelText: "Alamat"),
              ),
              TextField(
                controller: ipkCtrl,
                decoration: const InputDecoration(labelText: "IPK"),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Batal", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              final ipkVal = double.tryParse(ipkCtrl.text) ?? 0.0;
              if (ipkVal < 0.0 || ipkVal > 4.0) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Validasi Gagal: Nilai IPK harus berada di antara 0.0 dan 4.0!',
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              }
              final mahasiswa = Mahasiswa(
                nim: nimCtrl.text,
                nama: namaCtrl.text,
                email: emailCtrl.text,
                prodi: prodiCtrl.text,
                semester: int.tryParse(semesterCtrl.text) ?? 1,
                nomorHp: nomorHpCtrl.text,
                alamat: alamatCtrl.text,
                ipk: double.tryParse(ipkCtrl.text) ?? 0.0,
              );

              if (mhs == null) {
                bloc.add(AddMahasiswaEvent(mahasiswa));
              } else {
                bloc.add(UpdateMahasiswaEvent(mhs.nim, mahasiswa));
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryNavy),
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
