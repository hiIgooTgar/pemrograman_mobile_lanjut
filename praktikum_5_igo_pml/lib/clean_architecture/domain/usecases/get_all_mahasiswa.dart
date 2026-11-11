import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class GetAllMahasiswa {
  final MahasiswaRepository repository;
  GetAllMahasiswa(this.repository);

  Future<List<Mahasiswa>> call() async => repository.getAllMahasiswa();
}
