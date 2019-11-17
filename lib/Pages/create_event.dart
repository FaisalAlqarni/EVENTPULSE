import 'package:flutter/material.dart';

class CreateEvent extends StatelessWidget {

  final String title= "create event";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}