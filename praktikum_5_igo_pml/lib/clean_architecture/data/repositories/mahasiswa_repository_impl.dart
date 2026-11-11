import 'package:praktikum_5_igo_pml/clean_architecture/data/data_sources/mahasiswa_data_source.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/data/models/mahasiswa_model.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/repositories/mahasiswa_repository.dart';

class MahasiswaRepositoryImpl implements MahasiswaRepository {
  final MahasiswaDataSource dataSource;

  MahasiswaRepositoryImpl({required this.dataSource});

  @override
  Future<List<Mahasiswa>> getAllMahasiswa() async {
    final models = await dataSource.getAllMahasiswa();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addMahasiswa(Mahasiswa mahasiswa) async {
    await dataSource.addMahasiswa(MahasiswaModel.fromEntity(mahasiswa));
  }

  @override
  Future<void> updateMahasiswa(String nim, Mahasiswa mahasiswa) async {
    await dataSource.updateMahasiswa(nim, MahasiswaModel.fromEntity(mahasiswa));
  }

  @override
  Future<void> deleteMahasiswa(String nim) async {
    await dataSource.deleteMahasiswa(nim);
  }

  @override
  Future<List<Mahasiswa>> searchMahasiswa(String query) async {
    final resultModels = await dataSource.searchMahasiswa(query);
    return resultModels.map((model) => model.toEntity()).toList();
  }
}
