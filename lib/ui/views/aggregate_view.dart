import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/core/bound.dart';
import 'package:flutter_mvvm/ui/viewmodels/aggregate_view_model.dart';

class AggregateView extends BoundWidget<AggregateViewModel> {
  AggregateView(createViewModel) : super(createViewModel);

  @override
  _AggregateViewState createState() => _AggregateViewState(createViewModel());
}

class _AggregateViewState
    extends BoundState<AggregateView, AggregateViewModel> {
  _AggregateViewState(AggregateViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Aggregate(
              aggregate: viewModel.sum,
              title: 'Sum',
              icon: Icons.add,
            ),
            Aggregate(
              aggregate: viewModel.product,
              title: 'Product',
              icon: Icons.star,
            )
          ],
        ),
      ),
    );
  }
}

class Aggregate extends StatelessWidget {
  final int aggregate;
  final String title;
  final IconData icon;

  const Aggregate({Key key, this.aggregate, this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(this.icon),
        Column(
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              this.aggregate.toString(),
              style: TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
