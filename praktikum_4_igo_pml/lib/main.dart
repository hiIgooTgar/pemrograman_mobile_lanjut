import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:praktikum_4_igo_pml/data/data_sources/mahasiswa_local_data_source.dart';
import 'package:praktikum_4_igo_pml/data/repositories/mahasiswa_repository_impl.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/add_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/delete_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/get_all_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/search_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/update_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_4_igo_pml/presentation/pages/mahasiswa_page.dart';

void main() {
  final localDataSource = MahasiswaLocalDataSourceImpl();
  final MahasiswaRepository repo = MahasiswaRepositoryImpl(
    localDataSource: localDataSource,
  );
  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final MahasiswaRepository repo;
  const MyApp({super.key, required this.repo});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture + BLoC',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => MahasiswaBloc(
          getAllMahasiswa: GetAllMahasiswa(repo),
          addMahasiswa: AddMahasiswa(repo),
          updateMahasiswa: UpdateMahasiswa(repo),
          deleteMahasiswa: DeleteMahasiswa(repo),
          searchMahasiswa: SearchMahasiswa(repo),
        )..add(LoadMahasiswaEvent()),
        child: const MahasiswaPage(),
      ),
    );
  }
}
