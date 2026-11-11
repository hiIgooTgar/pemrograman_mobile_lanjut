import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:praktikum_5_igo_pml/clean_architecture/data/data_sources/mahasiswa_data_source.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/data/data_sources/mahasiswa_remote_data_source.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/data/repositories/mahasiswa_repository_impl.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/add_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/delete_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/get_all_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/search_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/update_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/pages/mahasiswa_page.dart';

void main() {
  // final MahasiswaDataSource dataSource = MahasiswaLocalDataSourceImpl();
  final MahasiswaDataSource dataSource = MahasiswaRemoteDataSourceImpl();

  final MahasiswaRepository repo = MahasiswaRepositoryImpl(
    dataSource: dataSource,
  );

  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  static const Color primaryNavy = Color(0xFF0A2481);
  final MahasiswaRepository repo;

  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture + BLoC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
        ),
      ),
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
