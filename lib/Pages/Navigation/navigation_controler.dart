import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:senior_project/Pages/MainLogin.dart';
import '../BeforeLogin/Map.dart';
import '../BeforeLogin/timeline.dart';
import '../Discover/discoverpage.dart';
import '../Profile/user_details_page.dart';
import '../user_instance.dart';

class NavigationBarController extends StatefulWidget {
  @override
  _NavigationBarControllerState createState() =>
      _NavigationBarControllerState();
}

class _NavigationBarControllerState extends State<NavigationBarController> {
  List<Widget> pages;
  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 1;

  List<Widget> setpages() {
    if (UserInstance().token == null) {
      List<Widget> pages = [
        TimelinePage(
          key: PageStorageKey('TimelinePage'),
        ),
        NewDiscover(
          key: PageStorageKey('DiscoverPage'),
        ),
        MapPage(
          key: PageStorageKey('MapPage'),
        ),
        MainLogin(
          key: PageStorageKey('LoginPage'),
        ),
      ];
      return pages;
    } else {
      List<Widget> pages = [
        TimelinePage(
          key: PageStorageKey('TimelinePage'),
        ),
        NewDiscover(
          key: PageStorageKey('DiscoverPage'),
        ),
        MapPage(
          key: PageStorageKey('MapPage'),
        ),
        ProfilePage(
          key: PageStorageKey('ProfilePage'),
        ),
      ];
      return pages;
    }
  }

  initState(){
     this.pages = setpages();
  }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline), title: Text('Timeline')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Discover')),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
          BottomNavigationBarItem(
              icon: Icon(Icons.face), title: Text('Profile')),
        ],
        backgroundColor: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
