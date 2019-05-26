import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/models/number.dart';
import 'package:flutter_mvvm/services/number_service.dart';
import 'package:rxdart/rxdart.dart';

class NumbersViewModel extends ChangeNotifier {
  final INumberService _numberService;
  StreamSubscription<List<Number>> _numbersSubscription;

  List<Number> _numbers = List<Number>();

  @protected
  set numbers(List<Number> value) {
    _numbers = value;
    notifyListeners();
  }

  int get numbersLength => _numbers.length;

  NumbersViewModel({numberService}) : this._numberService = numberService {
    _numbersSubscription = this._numberService.numbers$.listen(_update);
  }

  _update(List<Number> numbers) {
    this.numbers = numbers;
  }

  NumberViewModel numberViewModelFor(int idx) {
    return NumberViewModel(
      number: _numbers[idx],
      index: idx,
      remove: _removeNumber,
      selectToggled: _toggleNumberSelected,
      numberToggled$: _numberService.numberToggled$,
    );
  }

  void _removeNumber(int index) {
    this._numberService.removeNumberAt(index);
  }

  void _toggleNumberSelected(Number number) {
    this._numberService.toggleNumber(number);
  }

  void removeSelected() {
    this._numberService.removeSelectedNumbers();
  }

  @override
  void dispose() {
    _numbersSubscription.cancel();
    super.dispose();
  }
}

class NumberViewModel extends ChangeNotifier {
  final Number _number;
  final int _index;
  final Function(int) _remove;
  final Function(Number) _selectToggled;
  StreamSubscription<Number> _numberToggledSub;

  int get number => _number.value;
  bool get selected => _number.selected;

  NumberViewModel({
    @required Number number,
    @required int index,
    @required Function(int) remove,
    @required Function(Number) selectToggled,
    @required Observable<Number> numberToggled$,
  })  : this._number = number,
        this._index = index,
        this._remove = remove,
        this._selectToggled = selectToggled {
    _numberToggledSub = numberToggled$.listen(onNumberToggled);
  }

  void delete() {
    _remove(this._index);
  }

  void toggleSelected() {
    this._selectToggled(this._number);
  }

  @override
  String toString() {
    return '{ number: ${_number.value}, index: $_index }';
  }

  void onNumberToggled(Number number) {
    if (_number == number) notifyListeners();
  }

  void dispose() {
    _numberToggledSub.cancel();
    super.dispose();
  }
}
