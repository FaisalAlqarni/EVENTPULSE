/*
the home page class
it is the main page 
it contain the navigation bar and call the other classes
*/

//import the necessary classes
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Side_Bar.dart';

//no need to modify this
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//the home page state, it has all the configration for UI
class _MyHomePageState extends State<MyHomePage>{
  //List of varibles
  String projectTitle = 'Social Event Discoverer';
  String unDiscover = 'this is discver page \nNOT YET IMPLEMENTED';
  String unTimeline = 'this is Timeline page \nNOT YET IMPLEMENTED';
  String unMap = 'this is Map View \nNOT YET IMPLEMENTED';
  String theText = 'this is discver page \nNOT YET IMPLEMENTED';
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //the Scaffold, the main widget to display the navigation bar and the side bar
    return Scaffold(
      //the upper bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(projectTitle, style: TextStyle(color: Colors.black),),
         iconTheme: new IconThemeData(color: Colors.black),
      ),
      //the side bar (calling Side_Bar.dart class)
      drawer: AppDrawer(),
      
      //container to configrate what between the upper bar and navigation bar
      body: Container(
        //background color
        color: Colors.deepPurple,
        //get the phone size
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //center the contents
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //show the text
            Text(theText, textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0),
            )
          ],
        ),
      ),
      
      //the navigation bar (used widget package called curved_navigation_bar)
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        height: 50,
        items: <Widget>[
          //the most left icon, index 0 (the timeline)
          Icon(Icons.adjust, size: 30.0, color: Colors.black),
          //the second icon, index 1 (the discover page)
          Icon(Icons.search, size: 30.0),
          //the last icon, index 2 (map view)
          Icon(Icons.location_on, size: 30.0, color: Colors.black),
        ],
        //animation speed
        animationDuration: Duration(milliseconds: 200),
        //the defult page (index 1 = discover page)
        index: 1,
        // what happen when click to the icon
        onTap: (index){
          setState(() {
            if (index == 0){
              theText = unTimeline;
            } else if (index == 1){
              theText = unDiscover;
            } else{
              theText = unMap;
            }
          });
        },
      ),
      );
  }


}