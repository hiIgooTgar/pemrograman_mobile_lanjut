import 'package:praktikum_4_igo_pml/domain/entities/mahasiswa.dart';

class MahasiswaModel extends Mahasiswa {
  MahasiswaModel({
    required super.nim,
    required super.nama,
    required super.email,
    required super.prodi,
    required super.semester,
    required super.nomorHp,
    required super.alamat,
    required super.ipk,
  });

  factory MahasiswaModel.formJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nim: json["nim"].toString(),
      nama: json["nama"].toString(),
      email: json["email"].toString(),
      prodi: json["prodi"].toString(),
      semester: (json["semester"] as num?)?.toInt() ?? 1,
      nomorHp: json["nomorHp"]?.toString() ?? '',
      alamat: json["alamat"]?.toString() ?? '',
      ipk: (json["ipk"] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'nama': nama,
      'email': email,
      'prodi': prodi,
      'semester': semester,
      'nomorHp': nomorHp,
      'alamat': alamat,
      'ipk': ipk,
    };
  }

  factory MahasiswaModel.fromEntity(Mahasiswa entity) {
    return MahasiswaModel(
      nim: entity.nim,
      nama: entity.nama,
      email: entity.email,
      prodi: entity.prodi,
      semester: entity.semester,
      nomorHp: entity.nomorHp,
      alamat: entity.alamat,
      ipk: entity.ipk,
    );
  }

  @override
  Mahasiswa toEntity() {
    return Mahasiswa(
      nim: nim,
      nama: nama,
      email: email,
      prodi: prodi,
      semester: semester,
      nomorHp: nomorHp,
      alamat: alamat,
      ipk: ipk,
    );
  }
}
