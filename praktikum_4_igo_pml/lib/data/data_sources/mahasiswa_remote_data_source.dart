import 'package:praktikum_4_igo_pml/data/models/mahasiswa_model.dart';

abstract class MahasiswaRemoteDataSource {
  Future<List<MahasiswaModel>> getAllMahasiswa();
  Future<void> addMahasiswa(MahasiswaModel mahasiswa);
  Future<void> updateMahasiswa(String nim, MahasiswaModel mahasiswa);
  Future<void> deleteMahasiswa(String nim);
}

class MahasiswaRemoteDataSourceImpl implements MahasiswaRemoteDataSource {
  @override
  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    throw UnimplementedError('Akan diimplementasikan pada Pertemuan 6');
  }

  @override
  Future<void> addMahasiswa(MahasiswaModel mahasiswa) async {
    throw UnimplementedError('Akan diimplementasikan pada Pertemuan 6');
  }

  @override
  Future<void> updateMahasiswa(String nim, MahasiswaModel mahasiswa) async {
    throw UnimplementedError('Akan diimplementasikan pada Pertemuan 6');
  }

  @override
  Future<void> deleteMahasiswa(String nim) async {
    throw UnimplementedError('Akan diimplementasikan pada Pertemuan 6');
  }
}
