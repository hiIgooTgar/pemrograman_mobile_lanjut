import 'package:equatable/equatable.dart';

class Mahasiswa extends Equatable {
  final String nim;
  final String nama;
  final String email;
  final String prodi;
  final int semester;
  final String nomorHp;
  final String alamat;
  final double ipk;

  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.email,
    required this.prodi,
    required this.semester,
    required this.nomorHp,
    required this.alamat,
    required this.ipk,
  });

  Mahasiswa copyWith({
    String? nim,
    String? nama,
    String? email,
    String? prodi,
    int? semester,
    String? nomorHp,
    String? alamat,
    double? ipk,
  }) {
    return Mahasiswa(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      prodi: prodi ?? this.prodi,
      semester: semester ?? this.semester,
      nomorHp: nomorHp ?? this.nomorHp,
      alamat: alamat ?? this.alamat,
      ipk: ipk ?? this.ipk,
    );
  }

  @override
  List<Object?> get props => [
    nim,
    nama,
    email,
    prodi,
    semester,
    nomorHp,
    alamat,
    ipk,
  ];
}
