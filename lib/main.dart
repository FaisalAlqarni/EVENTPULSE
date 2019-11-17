//  the main class where it will call the home page
//  no need to modify this class
import 'package:flutter/material.dart';
import './Pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Social Event Discoverer',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage()
      },
    );
  }//build
}
