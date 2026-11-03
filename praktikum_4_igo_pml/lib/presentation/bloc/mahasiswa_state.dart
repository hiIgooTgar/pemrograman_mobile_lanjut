import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';

abstract class MahasiswaState {}

class MahasiswaInitial extends MahasiswaState {}

class MahasiswaLoading extends MahasiswaState {}

class MahasiswaLoaded extends MahasiswaState {
  final List<Mahasiswa> mahasiswaList;
  MahasiswaLoaded(this.mahasiswaList);
}

class MahasiswaError extends MahasiswaState {
  final String message;
  MahasiswaError(this.message);
}
