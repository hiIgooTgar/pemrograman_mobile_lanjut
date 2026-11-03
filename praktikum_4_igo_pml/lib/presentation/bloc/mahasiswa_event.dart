import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';

abstract class MahasiswaEvent {}

class LoadMahasiswaEvent extends MahasiswaEvent {}

class AddMahasiswaEvent extends MahasiswaEvent {
  final Mahasiswa mahasiswa;
  AddMahasiswaEvent(this.mahasiswa);
}

class UpdateMahasiswaEvent extends MahasiswaEvent {
  final String nim;
  final Mahasiswa mahasiswa;
  UpdateMahasiswaEvent(this.nim, this.mahasiswa);
}

class DeleteMahasiswaEvent extends MahasiswaEvent {
  final String nim;
  DeleteMahasiswaEvent(this.nim);
}

class SearchMahasiswaEvent extends MahasiswaEvent {
  final String query;
  SearchMahasiswaEvent(this.query);
}
