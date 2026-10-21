import 'dart:math';

final Random _random = Random();

class Nilai {
  final String kodeMatakuliah;
  final String namaMatakuliah;
  final int sks;
  final double nilaiUts;
  final double nilaiUas;
  final double nilaiTugas;
  final double nilaiPresensi;
  Nilai({
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
    required this.sks,
    required this.nilaiUts,
    required this.nilaiUas,
    required this.nilaiTugas,
    required this.nilaiPresensi,
  });
}

class Mahasiswa {
  final String nim;
  final String nama;
  final String email;
  final String prodi;
  final String foto;
  final List<Nilai> nilai;
  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.email,
    required this.prodi,
    required this.foto,
    required this.nilai,
  });
}

final List<String> prodiList = [
  'Informatika',
  'Sistem Informasi',
  'Teknologi Informasi',
];
List<Mahasiswa> mahasiswaList = List.generate(15, (i) {
  int nimNumber = 201 + i;
  return Mahasiswa(
    nim: '24SA2024$nimNumber',
    nama: 'Mahasiswa ${i + 1}',
    email: 'mahasiswa${i + 1}@student_amikom.com',
    prodi: prodiList[_random.nextInt(prodiList.length)],
    foto: 'https://picsum.photos/$nimNumber',
    nilai: List.generate(10, (j) {
      return Nilai(
        kodeMatakuliah: 'KMK${100 + j}',
        namaMatakuliah: 'Matakuliah ${j + 1}',
        sks: 3,
        nilaiUts: double.parse((_random.nextDouble() * 100).toStringAsFixed(2)),
        nilaiUas: double.parse((_random.nextDouble() * 100).toStringAsFixed(2)),
        nilaiTugas: double.parse(
          (_random.nextDouble() * 100).toStringAsFixed(2),
        ),
        nilaiPresensi: double.parse(
          (_random.nextDouble() * 100).toStringAsFixed(2),
        ),
      );
    }),
  );
});
