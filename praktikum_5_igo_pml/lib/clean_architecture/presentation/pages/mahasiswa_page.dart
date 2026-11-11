import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_state.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/pages/mahasiswa_form_page.dart';

class MahasiswaPage extends StatelessWidget {
  static const Color primaryNavy = Color(0xFF0A2481);
  const MahasiswaPage({super.key});

  void _navigateToForm(
    BuildContext context,
    MahasiswaBloc bloc, {
    Mahasiswa? mhs,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MahasiswaFormPage(bloc: bloc, mhs: mhs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MahasiswaBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clean Architecture - Mahasiswa",
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            "Tidak Ada Data Mahasiswa",
                            style: TextStyle(
                              color: primaryNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              final mhs = data[i];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color.fromARGB(120, 0, 0, 0),
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                    vertical: 6.0,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${mhs.nama} (${mhs.nim})",
                                      style: const TextStyle(
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
                                          onPressed: () => _navigateToForm(
                                            context,
                                            bloc,
                                            mhs: mhs,
                                          ),
                                          iconSize: 19.0,
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.yellow,
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
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
        onPressed: () => _navigateToForm(context, bloc),
        child: const Icon(Icons.add),
      ),
    );
  }
}
