import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class SearchMahasiswa {
  final MahasiswaRepository repository;
  SearchMahasiswa(this.repository);

  Future<List<Mahasiswa>> call(String query) async =>
      repository.searchMahasiswa(query);
}
