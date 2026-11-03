import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_state.dart';

class MahasiswaPage extends StatelessWidget {
  const MahasiswaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MahasiswaBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("Data Mahasiswa")),
      body: BlocBuilder<MahasiswaBloc, MahasiswaState>(
        builder: (context, state) {
          if (state is MahasiswaInitial || state is MahasiswaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MahasiswaLoaded) {
            final data = state.mahasiswaList;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          child: Text("Data mahasiswa tidak ditemukan."),
                        )
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            final mhs = data[i];
                            return ListTile(
                              title: Text("${mhs.nama} (${mhs.nim})"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Prodi: ${mhs.prodi}"),
                                  Text("Email: ${mhs.email}"),
                                  Text("IPK: ${mhs.ipk}"),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _showForm(context, bloc, mhs: mhs);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      bloc.add(DeleteMahasiswaEvent(mhs.nim));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
    final ipkCtrl = TextEditingController(text: mhs?.ipk.toString() ?? '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(mhs == null ? "Tambah Mahasiswa" : "Edit Mahasiswa"),
        content: SingleChildScrollView(
          child: Column(
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
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final mahasiswa = Mahasiswa(
                nim: nimCtrl.text,
                nama: namaCtrl.text,
                email: emailCtrl.text,
                prodi: prodiCtrl.text,
                ipk: double.tryParse(ipkCtrl.text) ?? 0,
              );
              if (mhs == null) {
                bloc.add(AddMahasiswaEvent(mahasiswa));
              } else {
                bloc.add(UpdateMahasiswaEvent(mhs.nim, mahasiswa));
              }
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
