import 'package:flutter/material.dart';

class REVIEWSShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'REVIEWS',
        style: textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}
