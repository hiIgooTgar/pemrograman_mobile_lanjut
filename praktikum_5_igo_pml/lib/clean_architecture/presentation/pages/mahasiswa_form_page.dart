import 'package:flutter/material.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/entities/mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_bloc.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_event.dart';

class MahasiswaFormPage extends StatefulWidget {
  final MahasiswaBloc bloc;
  final Mahasiswa? mhs;

  const MahasiswaFormPage({super.key, required this.bloc, this.mhs});

  @override
  State<MahasiswaFormPage> createState() => _MahasiswaFormPageState();
}

class _MahasiswaFormPageState extends State<MahasiswaFormPage> {
  static const Color primaryNavy = Color(0xFF0A2481);

  late final TextEditingController nimCtrl;
  late final TextEditingController namaCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController prodiCtrl;
  late final TextEditingController semesterCtrl;
  late final TextEditingController nomorHpCtrl;
  late final TextEditingController alamatCtrl;
  late final TextEditingController ipkCtrl;

  @override
  void initState() {
    super.initState();
    nimCtrl = TextEditingController(text: widget.mhs?.nim ?? '');
    namaCtrl = TextEditingController(text: widget.mhs?.nama ?? '');
    emailCtrl = TextEditingController(text: widget.mhs?.email ?? '');
    prodiCtrl = TextEditingController(text: widget.mhs?.prodi ?? '');
    semesterCtrl = TextEditingController(
      text: widget.mhs?.semester.toString() ?? '',
    );
    nomorHpCtrl = TextEditingController(text: widget.mhs?.nomorHp ?? '');
    alamatCtrl = TextEditingController(text: widget.mhs?.alamat ?? '');
    ipkCtrl = TextEditingController(text: widget.mhs?.ipk.toString() ?? '');
  }

  @override
  void dispose() {
    nimCtrl.dispose();
    namaCtrl.dispose();
    emailCtrl.dispose();
    prodiCtrl.dispose();
    semesterCtrl.dispose();
    nomorHpCtrl.dispose();
    alamatCtrl.dispose();
    ipkCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final ipkVal = double.tryParse(ipkCtrl.text) ?? 0.0;
    if (ipkVal < 0.0 || ipkVal > 4.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Validasi Gagal: Nilai IPK harus berada di antara 0.0 dan 4.0!',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final mahasiswa = Mahasiswa(
      nim: nimCtrl.text,
      nama: namaCtrl.text,
      email: emailCtrl.text,
      prodi: prodiCtrl.text,
      semester: int.tryParse(semesterCtrl.text) ?? 1,
      nomorHp: nomorHpCtrl.text,
      alamat: alamatCtrl.text,
      ipk: ipkVal,
    );

    if (widget.mhs == null) {
      widget.bloc.add(AddMahasiswaEvent(mahasiswa));
    } else {
      widget.bloc.add(UpdateMahasiswaEvent(widget.mhs!.nim, mahasiswa));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.mhs != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Mahasiswa" : "Tambah Mahasiswa",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nimCtrl,
              decoration: const InputDecoration(labelText: "NIM"),
              enabled: !isEdit,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: namaCtrl,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: prodiCtrl,
              decoration: const InputDecoration(labelText: "Prodi"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: semesterCtrl,
              decoration: const InputDecoration(labelText: "Semester"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nomorHpCtrl,
              decoration: const InputDecoration(labelText: "Nomor HP"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: alamatCtrl,
              decoration: const InputDecoration(labelText: "Alamat"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ipkCtrl,
              decoration: const InputDecoration(labelText: "IPK"),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
