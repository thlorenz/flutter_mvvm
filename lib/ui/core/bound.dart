import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final VoidCallback noop = () {};

abstract class BoundState<TState extends StatefulWidget,
    TViewModel extends ChangeNotifier> extends State<TState> {
  final TViewModel viewModel;

  BoundState(this.viewModel) {
    viewModel.addListener(() {
      this.setState(noop);
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}

abstract class BoundWidget<TViewModel extends ChangeNotifier>
    extends StatefulWidget {
  final TViewModel Function() createViewModel;
  BoundWidget(this.createViewModel, {Key key}) : super(key: key);
}
