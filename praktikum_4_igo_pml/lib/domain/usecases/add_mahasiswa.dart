import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class AddMahasiswa {
  final MahasiswaRepository repository;
  AddMahasiswa(this.repository);

  void call(Mahasiswa mahasiswa) {
    if (mahasiswa.ipk < 0.0 || mahasiswa.ipk > 4.0) {
      throw Exception(
        'Validasi Gagal: Nilai IPK harus berada di antara 0.0 dan 4.0!',
      );
    }
    repository.addMahasiswa(mahasiswa);
  }
}
