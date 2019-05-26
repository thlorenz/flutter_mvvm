import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/models/number.dart';
import 'package:flutter_mvvm/services/number_service.dart';

class AddNumberViewModel with ChangeNotifier {
  final INumberService _numberService;
  int _lastAddedNumber;
  StreamSubscription<List<Number>> _numbersSub;

  int get lastAddedNumber => _lastAddedNumber == null ? 0 : _lastAddedNumber;

  AddNumberViewModel({@required INumberService numberService})
      : _numberService = numberService {
    _numbersSub = _numberService.numbers$.listen(_onNumbersChanged);
  }

  void addNumber(int n) {
    _numberService.addNumber(Number(n));
  }

  void _onNumbersChanged(List<Number> numbers) {
    _lastAddedNumber = numbers.length == 0 ? 0 : numbers.last.value;
    notifyListeners();
  }

  void dispose() {
    _numbersSub.cancel();
    super.dispose();
  }
}
