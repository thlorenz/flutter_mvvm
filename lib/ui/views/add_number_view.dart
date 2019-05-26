import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/core/bound.dart';
import 'package:flutter_mvvm/ui/viewmodels/add_number_view_model.dart';

class AddNumberView extends BoundWidget<AddNumberViewModel> {
  AddNumberView(createViewModel) : super(createViewModel);

  @override
  _AddNumberViewState createState() => _AddNumberViewState(createViewModel());
}

class _AddNumberViewState
    extends BoundState<AddNumberView, AddNumberViewModel> {
  _AddNumberViewState(AddNumberViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            NumbersRow(
              numbers: [1, 2, 3],
              onNumberSelected: _onNumberSelected,
            ),
            NumbersRow(
              numbers: [4, 5, 6],
              onNumberSelected: _onNumberSelected,
            ),
            NumbersRow(
              numbers: [7, 8, 9],
              onNumberSelected: _onNumberSelected,
            ),
            LastAddedNumber(lastAddedNumber: viewModel.lastAddedNumber)
          ],
        ),
      ),
    );
  }

  _onNumberSelected(int n) {
    viewModel.addNumber(n);
  }
}

class NumbersRow extends StatelessWidget {
  const NumbersRow({
    Key key,
    @required this.numbers,
    @required this.onNumberSelected,
  }) : super(key: key);

  final List<int> numbers;
  final Function(int) onNumberSelected;

  factory NumbersRow.forDesignTime() {
    return NumbersRow(
      numbers: [1, 2, 3],
      onNumberSelected: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NumberCell(
          number: numbers[0],
          onPressed: () => onNumberSelected(numbers[0]),
        ),
        NumberCell(
          number: numbers[1],
          onPressed: () => onNumberSelected(numbers[1]),
        ),
        NumberCell(
          number: numbers[2],
          onPressed: () => onNumberSelected(numbers[2]),
        ),
      ],
    );
  }
}

class NumberCell extends StatelessWidget {
  const NumberCell({
    Key key,
    @required this.number,
    @required this.onPressed,
  }) : super(key: key);

  final int number;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      child: Center(
        child: Text(this.number.toString(),
            style: TextStyle(
              fontSize: 85,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

class LastAddedNumber extends StatelessWidget {
  const LastAddedNumber({
    Key key,
    @required this.lastAddedNumber,
  }) : super(key: key);

  final int lastAddedNumber;

  factory LastAddedNumber.forDesignTime() {
    return new LastAddedNumber(lastAddedNumber: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Last added number: $lastAddedNumber',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
