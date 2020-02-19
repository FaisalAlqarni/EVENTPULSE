import 'package:flutter/material.dart';

class REVIEWSShowcaseOthers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'REVIEWS',
        style: textTheme.title.copyWith(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
