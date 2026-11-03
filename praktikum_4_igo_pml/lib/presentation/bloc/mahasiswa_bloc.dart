import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/add_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/delete_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/get_all_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/search_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/domain/usecases/update_mahasiswa.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_4_igo_pml/presentation/bloc/mahasiswa_state.dart';

class MahasiswaBloc extends Bloc<MahasiswaEvent, MahasiswaState> {
  final GetAllMahasiswa getAllMahasiswa;
  final AddMahasiswa addMahasiswa;
  final UpdateMahasiswa updateMahasiswa;
  final DeleteMahasiswa deleteMahasiswa;
  final SearchMahasiswa searchMahasiswa;

  MahasiswaBloc({
    required this.getAllMahasiswa,
    required this.addMahasiswa,
    required this.updateMahasiswa,
    required this.deleteMahasiswa,
    required this.searchMahasiswa,
  }) : super(MahasiswaInitial()) {
    on<LoadMahasiswaEvent>((event, emit) {
      emit(MahasiswaLoaded(getAllMahasiswa()));
    });
    on<AddMahasiswaEvent>((event, emit) {
      addMahasiswa(event.mahasiswa);
      emit(MahasiswaLoaded(getAllMahasiswa()));
    });
    on<UpdateMahasiswaEvent>((event, emit) {
      updateMahasiswa(event.nim, event.mahasiswa);
      emit(MahasiswaLoaded(getAllMahasiswa()));
    });
    on<DeleteMahasiswaEvent>((event, emit) {
      deleteMahasiswa(event.nim);
      emit(MahasiswaLoaded(getAllMahasiswa()));
    });
    on<SearchMahasiswaEvent>((event, emit) {
      final result = searchMahasiswa(event.query);
      emit(MahasiswaLoaded(result));
    });
  }
}
