/*
the home page class
it is the main page 
it contain the navigation bar and call the other classes
*/

//import the necessary classes
import 'package:flutter/material.dart';
import 'package:senior_project/navigation_bar.dart';
import 'package:senior_project/topBar.dart';

//no need to modify this
class MapPage extends StatefulWidget {

  const MapPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//the home page state, it has all the configration for UI
class _MyHomePageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //the Scaffold, the main widget to display the navigation bar and the side bar
    return Scaffold(
      //the upper bar
      appBar: TopBar(height: 60, pageTitle: 'Map'),
      //container to configrate what between the upper bar and navigation bar
      body: Container(
        //background color
        //color: Colors.deepPurple,
        //get the phone size
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //center the contents
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //show the text
            Text(
              "not yet implmented",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}