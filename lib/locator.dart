import 'package:flutter/material.dart';
import 'package:flutter_mvvm/services/number_service.dart';
import 'package:flutter_mvvm/ui/viewmodels/add_number_view_model.dart';
import 'package:flutter_mvvm/ui/viewmodels/aggregate_view_model.dart';
import 'package:flutter_mvvm/ui/viewmodels/numbers_view_model.dart';
import 'package:flutter_mvvm/ui/views/add_number_view.dart';
import 'package:flutter_mvvm/ui/views/aggregate_view.dart';
import 'package:flutter_mvvm/ui/views/numbers_view.dart';
import 'package:get_it/get_it.dart';

class _Locator {
  final GetIt _getit;

  _Locator({@required INumberService numberService}) : _getit = new GetIt() {
    _registerServices(numberService);
    _registerViewModels();
    _registerViews();
  }

  void _registerServices(INumberService numberService) {
    _getit.registerLazySingleton<INumberService>(() => numberService);
  }

  void _registerViewModels() {
    _getit
      ..registerFactory(
          () => AddNumberViewModel(numberService: this.get<INumberService>()))
      ..registerFactory(
          () => NumbersViewModel(numberService: this.get<INumberService>()))
      ..registerFactory(
          () => AggregateViewModel(numberService: this.get<INumberService>()));
  }

  void _registerViews() {
    _getit
      ..registerFactory<AddNumberView>(
          () => AddNumberView(() => this.get<AddNumberViewModel>()))
      ..registerFactory<NumbersView>(
          () => NumbersView(() => this.get<NumbersViewModel>()))
      ..registerFactory<AggregateView>(
          () => AggregateView(() => this.get<AggregateViewModel>()));
  }

  T get<T>() {
    return _getit.get<T>();
  }
}

final loc = new _Locator(numberService: NumberService());
