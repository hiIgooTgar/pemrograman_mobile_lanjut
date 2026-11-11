import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class DeleteMahasiswa {
  final MahasiswaRepository repository;
  DeleteMahasiswa(this.repository);

  Future<void> call(String nim) async => repository.deleteMahasiswa(nim);
}
