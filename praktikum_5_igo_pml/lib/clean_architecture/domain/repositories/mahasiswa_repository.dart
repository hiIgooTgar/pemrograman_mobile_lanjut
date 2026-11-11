import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';

abstract class MahasiswaRepository {
  Future<List<Mahasiswa>> getAllMahasiswa();
  Future<List<Mahasiswa>> searchMahasiswa(String query);
  Future<void> addMahasiswa(Mahasiswa mahasiswa);
  Future<void> updateMahasiswa(String nim, Mahasiswa mahasiswa);
  Future<void> deleteMahasiswa(String nim);
}
