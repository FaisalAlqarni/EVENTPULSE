//  the main class where it will call the home page
//  no need to modify this class
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Pages/Navigation/navigation_controler.dart';

void main() {
  runApp(
    /// 1. Wrap your App widget in the Phoenix widget
    Phoenix(
      child: MyApp(),
    ),
  );
}

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
          title: 'EVENTPULSE',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              hintColor: Color(0xff486581),
              primaryColor: Color(0xffD9E2EC),
              fontFamily: "Montserrat",
              canvasColor: Color(0xffF0F4F8),
              primaryColorDark: Color(0xff486581)
              //backgroundColor: ,
              ),
          initialRoute: '/',
          routes: {'/': (context) => NavigationBarController()},
        ));
  } //build
}
