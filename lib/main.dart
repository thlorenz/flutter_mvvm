import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(primarySwatch: Colors.blue);

    final app = MaterialApp(
      title: 'MVVM + Demo',
      theme: theme,
      onGenerateRoute: Router.generateRoute,
      initialRoute: '/',
    );
    return app;
  }
}
