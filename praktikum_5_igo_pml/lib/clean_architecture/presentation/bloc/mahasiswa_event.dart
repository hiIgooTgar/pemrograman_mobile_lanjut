import 'package:equatable/equatable.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';

abstract class MahasiswaEvent extends Equatable {
  const MahasiswaEvent();
  @override
  List<Object?> get props => [];
}

class LoadMahasiswaEvent extends MahasiswaEvent {}

class AddMahasiswaEvent extends MahasiswaEvent {
  final Mahasiswa mahasiswa;
  const AddMahasiswaEvent(this.mahasiswa);
  @override
  List<Object?> get props => [mahasiswa];
}

class UpdateMahasiswaEvent extends MahasiswaEvent {
  final String nim;
  final Mahasiswa mahasiswa;
  const UpdateMahasiswaEvent(this.nim, this.mahasiswa);
  @override
  List<Object?> get props => [nim, mahasiswa];
}

class DeleteMahasiswaEvent extends MahasiswaEvent {
  final String nim;
  const DeleteMahasiswaEvent(this.nim);
  @override
  List<Object?> get props => [nim];
}

class SearchMahasiswaEvent extends MahasiswaEvent {
  final String query;
  const SearchMahasiswaEvent(this.query);

  @override
  List<Object?> get props => [query];
}
