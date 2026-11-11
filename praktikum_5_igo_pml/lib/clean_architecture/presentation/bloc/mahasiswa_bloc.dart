import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/add_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/delete_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/get_all_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/search_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/domain/usecases/update_mahasiswa.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_event.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/presentation/bloc/mahasiswa_state.dart';

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
    on<LoadMahasiswaEvent>((event, emit) async {
      emit(MahasiswaLoading());
      try {
        final data = await getAllMahasiswa();
        emit(MahasiswaLoaded(data));
      } catch (e) {
        emit(MahasiswaError(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<AddMahasiswaEvent>((event, emit) async {
      emit(MahasiswaLoading());
      try {
        await addMahasiswa(event.mahasiswa);
        final data = await getAllMahasiswa();
        emit(MahasiswaLoaded(data));
      } catch (e) {
        emit(MahasiswaError(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<UpdateMahasiswaEvent>((event, emit) async {
      emit(MahasiswaLoading());
      try {
        await updateMahasiswa(event.nim, event.mahasiswa);
        final data = await getAllMahasiswa();
        emit(MahasiswaLoaded(data));
      } catch (e) {
        emit(MahasiswaError(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<DeleteMahasiswaEvent>((event, emit) async {
      emit(MahasiswaLoading());
      try {
        await deleteMahasiswa(event.nim);
        final data = await getAllMahasiswa();
        emit(MahasiswaLoaded(data));
      } catch (e) {
        emit(MahasiswaError(e.toString().replaceAll("Exception: ", "")));
      }
    });

    on<SearchMahasiswaEvent>((event, emit) async {
      try {
        final data = await searchMahasiswa(event.query);
        emit(MahasiswaLoaded(data));
      } catch (e) {
        emit(MahasiswaError(e.toString().replaceAll("Exception: ", "")));
      }
    });
  }
}
