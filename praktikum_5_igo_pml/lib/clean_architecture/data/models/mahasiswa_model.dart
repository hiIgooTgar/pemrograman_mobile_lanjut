import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';

class MahasiswaModel extends Mahasiswa {
  const MahasiswaModel({
    required super.nim,
    required super.nama,
    required super.email,
    required super.prodi,
    required super.semester,
    required super.nomorHp,
    required super.alamat,
    required super.ipk,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nim: json["nim"]?.toString() ?? '',
      nama: json["nama"]?.toString() ?? '',
      email: json["email"]?.toString() ?? '',
      prodi: json["prodi"]?.toString() ?? '',
      semester: (json["semester"] as num?)?.toInt() ?? 1,
      nomorHp:
          json["nomor_hp"]?.toString() ?? json["nomorHp"]?.toString() ?? '',
      alamat: json["alamat"]?.toString() ?? '',
      ipk: json["ipk"] is num
          ? (json["ipk"] as num).toDouble()
          : double.tryParse(json["ipk"]?.toString() ?? '0') ?? 0.0,
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
      'nomor_hp': nomorHp,
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
