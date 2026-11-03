import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class SearchMahasiswa {
  final MahasiswaRepository repository;

  SearchMahasiswa(this.repository);

  List<Mahasiswa> call(String query) => repository.searchMahasiswa(query);
}
