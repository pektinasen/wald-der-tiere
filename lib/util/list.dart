import 'package:tuple/tuple.dart';

extension ListExtension<A> on List<A> {
  List<Tuple2<A, B>> zip<B>(List<B> bs) {
    final list = List<Tuple2<A, B>>();
    final smallerListCount = this.length <= bs.length ? this.length : bs.length;
    for (int i = 0; i <= smallerListCount - 1; i++) {
      list.add(Tuple2(this[i], bs[i]));
    }
    return list;
  }

}

extension IterableExtension<A> on Iterable<A> {
  Iterable<MapEntry<int, A>> withIndex() sync* {
    int index = 0;
    for (A item in this) {
      yield MapEntry<int, A>(index, item);
      index = index + 1;
    }
  } 
}
