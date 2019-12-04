//  the main class where it will call the home page
//  no need to modify this class
import 'package:flutter/material.dart';
import 'Pages/Navigation/navigation_controler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Social Event Discoverer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              hintColor: Colors.deepPurple,
              primaryColor: Colors.deepPurple,
              fontFamily: "Montserrat",
              canvasColor: Colors.deepPurple),
          initialRoute: '/',
          routes: {'/': (context) => NavigationBarController()},
        ));
  } //build
}
