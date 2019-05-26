import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/services/number_service.dart';

class AggregateViewModel with ChangeNotifier {
  final INumberService _numberService;
  StreamSubscription<int> _sumSubs;
  StreamSubscription<int> _productSub;

  int _sum;
  int _product;

  int get sum => _sum;
  int get product => _product;

  set product(int value) {
    _product = value;
    notifyListeners();
  }

  set sum(int value) {
    _sum = value;
    notifyListeners();
  }

  AggregateViewModel({@required INumberService numberService})
      : _numberService = numberService,
        _sum = 0,
        _product = 0 {
    _sumSubs = _numberService.sum$.listen(_onSumChanged);
    _productSub = _numberService.product$.listen(_onProductChanged);
  }

  void _onSumChanged(int sum) => this.sum = sum;
  void _onProductChanged(int product) => this.product = product;

  @override
  void dispose() {
    _sumSubs.cancel();
    _productSub.cancel();
    super.dispose();
  }
}
