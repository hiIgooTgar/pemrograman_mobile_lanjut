import 'package:praktikum_5_igo_pml/clean_architecture/data/data_sources/mahasiswa_data_source.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/data/models/mahasiswa_model.dart';

abstract class MahasiswaLocalDataSource implements MahasiswaDataSource {}

class MahasiswaLocalDataSourceImpl implements MahasiswaLocalDataSource {
  final List<MahasiswaModel> _storage = [
    MahasiswaModel(
      nim: "24SA11A159",
      nama: "Igo Tegar Prambudhy",
      email: "igo@gmail.com",
      prodi: "Informatika",
      semester: 5,
      nomorHp: "089348384873",
      alamat: "Banyumas",
      ipk: 3.8,
    ),
    MahasiswaModel(
      nim: "24SA11A200",
      nama: "Edward Alseon",
      email: "edward@gmail.com",
      prodi: "Informatika",
      semester: 5,
      nomorHp: "089348384873",
      alamat: "Banyumas",
      ipk: 3.8,
    ),
  ];

  @override
  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return List.unmodifiable(_storage);
  }

  @override
  Future<void> addMahasiswa(MahasiswaModel mahasiswa) async {
    _storage.add(mahasiswa);
  }

  @override
  Future<void> updateMahasiswa(String nim, MahasiswaModel mahasiswa) async {
    final index = _storage.indexWhere((m) => m.nim == nim);
    if (index != -1) {
      _storage[index] = mahasiswa;
    }
  }

  @override
  Future<void> deleteMahasiswa(String nim) async {
    _storage.removeWhere((m) => m.nim == nim);
  }

  @override
  Future<List<MahasiswaModel>> searchMahasiswa(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) {
      return List.unmodifiable(_storage);
    }
    return _storage
        .where(
          (m) =>
              m.nama.toLowerCase().contains(query.toLowerCase()) ||
              m.nim.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
