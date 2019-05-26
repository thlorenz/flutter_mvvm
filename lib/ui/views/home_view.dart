import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              ViewSquare(
                label: 'Add Number',
                icon: Icons.add,
                onTap: () => Navigator.pushNamed(context, '/add-number'),
              ),
              ViewSquare(
                label: 'Numbers',
                icon: Icons.list,
                onTap: () => Navigator.pushNamed(context, '/numbers'),
              ),
              ViewSquare(
                label: 'Aggregates',
                icon: Icons.computer,
                onTap: () => Navigator.pushNamed(context, '/aggregate'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ViewSquare extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  const ViewSquare({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: onTap,
        child: Column(
          children: <Widget>[Text(label), Icon(icon, size: 55)],
        ),
      ),
    );
  }
}
