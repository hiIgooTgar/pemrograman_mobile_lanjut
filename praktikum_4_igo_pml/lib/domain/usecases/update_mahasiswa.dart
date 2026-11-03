import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class UpdateMahasiswa {
  final MahasiswaRepository repository;
  UpdateMahasiswa(this.repository);

  void call(String nim, Mahasiswa mahasiswa) =>
      repository.updateMahasiswa(nim, mahasiswa);
}
