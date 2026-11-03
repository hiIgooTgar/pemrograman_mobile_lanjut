import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class DeleteMahasiswa {
  final MahasiswaRepository repository;
  DeleteMahasiswa(this.repository);

  void call(String nim) => repository.deleteMahasiswa(nim);
}
