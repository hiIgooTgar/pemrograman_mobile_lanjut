import 'package:equatable/equatable.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';

abstract class MahasiswaState extends Equatable {
  const MahasiswaState();
  @override
  List<Object?> get props => [];
}

class MahasiswaInitial extends MahasiswaState {}

class MahasiswaLoading extends MahasiswaState {}

class MahasiswaLoaded extends MahasiswaState {
  final List<Mahasiswa> mahasiswaList;
  const MahasiswaLoaded(this.mahasiswaList);
  @override
  List<Object?> get props => [mahasiswaList];
}

class MahasiswaError extends MahasiswaState {
  final String message;
  const MahasiswaError(this.message);
  @override
  List<Object?> get props => [message];
}
