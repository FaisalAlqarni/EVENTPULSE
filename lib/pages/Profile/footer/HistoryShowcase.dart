import 'package:flutter/material.dart';

class HistoryShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'HISTORY LIST',
        style: textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}