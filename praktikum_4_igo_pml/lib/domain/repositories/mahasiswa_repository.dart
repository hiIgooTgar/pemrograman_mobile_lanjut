import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';

abstract class MahasiswaRepository {
  List<Mahasiswa> getAllMahasiswa();
  List<Mahasiswa> searchMahasiswa(String query);
  void addMahasiswa(Mahasiswa mahasiswa);
  void updateMahasiswa(String nim, Mahasiswa mahasiswa);
  void deleteMahasiswa(String nim);
}
