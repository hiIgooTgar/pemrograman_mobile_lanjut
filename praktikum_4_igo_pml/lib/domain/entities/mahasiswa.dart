class Mahasiswa {
  final String nim;
  final String nama;
  final String email;
  final String prodi;
  final double ipk;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.email,
    required this.prodi,
    required this.ipk,
  });

  Mahasiswa copyWith({
    String? nim,
    String? nama,
    String? email,
    String? prodi,
    double? ipk,
  }) {
    return Mahasiswa(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      prodi: prodi ?? this.prodi,
      ipk: ipk ?? this.ipk,
    );
  }
}
