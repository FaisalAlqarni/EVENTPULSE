//  the main class where it will call the home page
//  no need to modify this class
import 'package:flutter/material.dart';
import './Pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Event Discoverer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage()
      },
    );
  }//build
}
