abstract class CounterEvent {}

class TambahEvent extends CounterEvent {
  final int nilai;
  TambahEvent(this.nilai);
}

class KurangEvent extends CounterEvent {
  final int nilai;
  KurangEvent(this.nilai);
}

class ResetEvent extends CounterEvent {}
