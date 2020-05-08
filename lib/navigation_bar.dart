import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Pages/MainLogin.dart';
import 'Pages/Map/MapView.dart';
import 'Pages/Reviews/ReviewList.dart';
import 'Pages/BeforeLogin/timeline.dart';
import 'Pages/Discover/discoverpage.dart';
import 'Pages/Profile/user_details_page.dart';
import 'Pages/user_instance.dart';

class NavigationBar extends StatefulWidget {
  final int currindx;

  const NavigationBar({Key key, this.currindx}) : super(key: key);
  

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavigationBar> {

  String unDiscover = 'this is discver page \nNOT YET IMPLEMENTED';
  String unTimeline = 'this is Timeline page \nNOT YET IMPLEMENTED';
  String unMap = 'this is Map View \nNOT YET IMPLEMENTED';
  String unProfile = 'this is profile page \nNOT YET IMPLEMENTED';
  String theText = 'this is discver page \nNOT YET IMPLEMENTED';
  
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(  backgroundColor: Colors.deepPurple,
        height: 50,

        items: <Widget>[
          //the most left icon, index 0 (the timeline)
          Icon(Icons.adjust, size: 30.0, color: Theme.of(context).primaryColorLight),
          //the second icon, index 1 (the discover page)
          Icon(Icons.search, size: 30.0, color: Theme.of(context).primaryColorLight),
          //the third icon, index 2 (map view)
          Icon(Icons.location_on, size: 30.0, color: Theme.of(context).primaryColorLight),
          //the last icon, index 3 (profile view)
          Icon(Icons.beach_access, size: 30.0, color: Theme.of(context).primaryColorLight),
        ],
        //animation speed
        animationDuration: Duration(milliseconds: 200),
        //the defult page (index 1 = discover page)
        index: widget.currindx,
        // what happen when click to the icon
        onTap: (index) {
          setState(() {
            if (index == 0) {
               Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new TimelinePage();
                    },
                  ),
                );
            } else if (index == 1) {
              Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new NewDiscover();
                    },
                  ),
                );
            } else if (index == 2) {
              Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new MapView();
                    },
                  ),
                );
            } else if (index == 3) {
              if (UserInstance().token == null) {
                 Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new MainLogin();
                    },
                  ),
                );
              } else {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new ProfilePage();
                    },
                  ),
                );
              }
             
            }
          });
        },);
  }
}