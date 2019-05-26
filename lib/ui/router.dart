import 'package:flutter/material.dart';
import 'package:flutter_mvvm/locator.dart';
import 'package:flutter_mvvm/ui/views/add_number_view.dart';
import 'package:flutter_mvvm/ui/views/aggregate_view.dart';
import 'package:flutter_mvvm/ui/views/home_view.dart';
import 'package:flutter_mvvm/ui/views/numbers_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/add-number':
        return MaterialPageRoute(builder: (_) => loc.get<AddNumberView>());
      case '/numbers':
        return MaterialPageRoute(builder: (_) => loc.get<NumbersView>());
      case '/aggregate':
        return MaterialPageRoute(builder: (_) => loc.get<AggregateView>());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
