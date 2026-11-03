import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class GetAllMahasiswa {
  final MahasiswaRepository repository;
  GetAllMahasiswa(this.repository);
  List<Mahasiswa> call() => repository.getAllMahasiswa();
}
