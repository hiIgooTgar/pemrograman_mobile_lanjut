import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class UpdateMahasiswa {
  final MahasiswaRepository repository;
  UpdateMahasiswa(this.repository);

  Future<void> call(String nim, Mahasiswa mahasiswa) async =>
      repository.updateMahasiswa(nim, mahasiswa);
}
