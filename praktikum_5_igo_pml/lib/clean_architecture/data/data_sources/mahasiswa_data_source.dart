import 'package:praktikum_5_igo_pml/clean_architecture/data/models/mahasiswa_model.dart';

abstract class MahasiswaDataSource {
  Future<List<MahasiswaModel>> getAllMahasiswa();
  Future<List<MahasiswaModel>> searchMahasiswa(String query);
  Future<void> addMahasiswa(MahasiswaModel mahasiswa);
  Future<void> updateMahasiswa(String nim, MahasiswaModel mahasiswa);
  Future<void> deleteMahasiswa(String nim);
}
