import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class AddMahasiswa {
  final MahasiswaRepository repository;
  AddMahasiswa(this.repository);

  Future<void> call(Mahasiswa mahasiswa) async {
    if (mahasiswa.ipk < 0.0 || mahasiswa.ipk > 4.0) {
      throw Exception(
        'Validasi Gagal: Nilai IPK harus berada di antara 0.0 dan 4.0!',
      );
    }
    await repository.addMahasiswa(mahasiswa);
  }
}
