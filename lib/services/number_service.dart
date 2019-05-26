import 'package:flutter_mvvm/models/number.dart';
import 'package:rxdart/rxdart.dart';

abstract class INumberService {
  Observable<int> get sum$;
  Observable<int> get product$;
  Observable<List<Number>> get numbers$;
  Observable<Number> get numberToggled$;

  void addNumber(Number n);

  void removeNumberAt(int index);

  void toggleNumber(Number number);

  void removeSelectedNumbers();

  void dispose();
}

int summarize(List<Number> numbers) {
  return numbers.reduce((sum, n) => Number(sum.value + n.value)).value;
}

int productize(List<Number> numbers) {
  return numbers.reduce((prod, n) => Number(prod.value * n.value)).value;
}

class NumberService extends INumberService {
  final List<Number> _numbers = List<Number>();
  final Subject<List<Number>> _numbers$ = BehaviorSubject<List<Number>>();
  final Subject<Number> _numberToggled$ = BehaviorSubject<Number>();

  @override
  Observable<List<Number>> get numbers$ => _numbers$;

  @override
  Observable<int> get product$ => _numbers$.map(productize);

  @override
  Observable<int> get sum$ => _numbers$.map(summarize);

  @override
  Observable<Number> get numberToggled$ => _numberToggled$;

  @override
  void addNumber(Number n) {
    _numbers.add(n);
    _numbers$.add(_numbers);
  }

  @override
  void removeNumberAt(int index) {
    _numbers.removeAt(index);
    _numbers$.add(_numbers);
  }

  @override
  void toggleNumber(Number number) {
    number.selected = !number.selected;
    _numberToggled$.add(number);
  }

  @override
  void removeSelectedNumbers() {
    _numbers.removeWhere((x) => x.selected);
    _numbers$.add(_numbers);
  }

  @override
  void dispose() {
    _numbers$.close();
    _numberToggled$.close();
  }
}
