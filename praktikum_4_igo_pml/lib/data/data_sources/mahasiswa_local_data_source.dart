import 'package:praktikum_4_igo_pml/data/models/mahasiswa_model.dart';

abstract class MahasiswaLocalDataSource {
  List<MahasiswaModel> getAllMahasiswa();
  List<MahasiswaModel> searchMahasiswa(String query);
  void addMahasiswa(MahasiswaModel mahasiswa);
  void updateMahasiswa(String nim, MahasiswaModel mahasiswa);
  void deleteMahasiswa(String nim);
}

class MahasiswaLocalDataSourceImpl implements MahasiswaLocalDataSource {
  final List<MahasiswaModel> _storage = [];

  @override
  List<MahasiswaModel> getAllMahasiswa() {
    return List.unmodifiable(_storage);
  }

  @override
  void addMahasiswa(MahasiswaModel mahasiswa) {
    _storage.add(mahasiswa);
  }

  @override
  void updateMahasiswa(String nim, MahasiswaModel mahasiswa) {
    final index = _storage.indexWhere((m) => m.nim == nim);
    if (index != -1) {
      _storage[index] = mahasiswa;
    }
  }

  @override
  void deleteMahasiswa(String nim) {
    _storage.removeWhere((m) => m.nim == nim);
  }

  @override
  List<MahasiswaModel> searchMahasiswa(String query) {
    if (query.isEmpty) {
      return _storage;
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
