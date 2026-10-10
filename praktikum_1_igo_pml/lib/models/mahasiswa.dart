import 'pencapaian.dart';

class Mahasiswa {
  final String nim;
  final String nama;
  final String programStudi;
  final int angkatan;
  final String email;
  final String profileUrl;
  final List<Pencapaian> daftarPencapaian;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.programStudi,
    required this.angkatan,
    required this.email,
    required this.profileUrl,
    required this.daftarPencapaian,
  });

  double get ipk {
    if (daftarPencapaian.isEmpty) return 0.0;
    double totalNilai = 0;
    int totalSks = 0;
    for (var item in daftarPencapaian) {
      totalNilai += (item.bobot * item.sks);
      totalSks += item.sks;
    }
    return totalSks == 0 ? 0.0 : totalNilai / totalSks;
  }
}
