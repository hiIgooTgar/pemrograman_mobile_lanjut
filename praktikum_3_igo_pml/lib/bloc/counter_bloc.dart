import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_3_igo_pml/bloc/counter_event.dart';
import 'package:praktikum_3_igo_pml/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<TambahEvent>((event, emit) {
      emit(CounterState(state.bilangan + event.nilai));
    });

    on<KurangEvent>((event, emit) {
      emit(CounterState(state.bilangan - event.nilai));
    });

    on<ResetEvent>((event, emit) {
      emit(CounterState(0));
    });
  }
}
