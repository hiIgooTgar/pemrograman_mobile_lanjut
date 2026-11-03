import 'package:praktikum_4_igo_pml/data/data_sources/mahasiswa_local_data_source.dart';
import 'package:praktikum_4_igo_pml/data/models/mahasiswa_model.dart';
import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/repositories/mahasiswa_repository.dart';

class MahasiswaRepositoryImpl implements MahasiswaRepository {
  final MahasiswaLocalDataSource localDataSource;

  MahasiswaRepositoryImpl({MahasiswaLocalDataSource? localDataSource})
    : localDataSource = localDataSource ?? MahasiswaLocalDataSourceImpl();

  @override
  List<Mahasiswa> getAllMahasiswa() {
    return localDataSource.getAllMahasiswa();
  }

  @override
  void addMahasiswa(Mahasiswa mahasiswa) {
    localDataSource.addMahasiswa(MahasiswaModel.fromEntity(mahasiswa));
  }

  @override
  void updateMahasiswa(String nim, Mahasiswa mahasiswa) {
    localDataSource.updateMahasiswa(nim, MahasiswaModel.fromEntity(mahasiswa));
  }

  @override
  void deleteMahasiswa(String nim) {
    localDataSource.deleteMahasiswa(nim);
  }

  @override
  List<Mahasiswa> searchMahasiswa(String query) {
    final resultModels = localDataSource.searchMahasiswa(query);
    return resultModels.map((model) => model.toEntity()).toList();
  }
}
