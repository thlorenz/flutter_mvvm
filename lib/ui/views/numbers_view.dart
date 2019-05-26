import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/core/bound.dart';
import 'package:flutter_mvvm/ui/viewmodels/numbers_view_model.dart';

class NumbersView extends BoundWidget<NumbersViewModel> {
  NumbersView(createViewModel) : super(createViewModel);

  @override
  BoundState<StatefulWidget, ChangeNotifier> createState() =>
      _NumbersViewState(createViewModel());
}

class _NumbersViewState extends BoundState<NumbersView, NumbersViewModel> {
  _NumbersViewState(NumbersViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.numbersLength,
                itemBuilder: (_, int idx) =>
                    NumberView(() => viewModel.numberViewModelFor(idx)),
                key: UniqueKey(),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: viewModel.removeSelected,
                child: Text('Remove Selected',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NumberView extends BoundWidget {
  NumberView(createViewModel) : super(createViewModel);

  @override
  BoundState<StatefulWidget, ChangeNotifier> createState() =>
      _NumberViewState(createViewModel());
}

class _NumberViewState extends BoundState<NumberView, NumberViewModel> {
  _NumberViewState(NumberViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: (_) => viewModel.toggleSelected(),
        value: viewModel.selected,
      ),
      title: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(viewModel.number.toString()),
        ),
      ),
      trailing:
          FlatButton(onPressed: viewModel.delete, child: Icon(Icons.delete)),
    );
  }
}
