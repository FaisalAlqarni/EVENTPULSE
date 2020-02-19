import 'package:EventPulse/Pages/Discover/discoverpage.old.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/MainLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BeforeLogin/Map.dart';
import '../BeforeLogin/timeline.dart';
import '../Discover/discoverpage.dart';
import '../Profile/user_details_page.dart';
import '../event_coordinator.dart';
import '../user_instance.dart';

class NavigationBarController extends StatefulWidget {
  @override
  _NavigationBarControllerState createState() =>
      _NavigationBarControllerState();
}

const String spKey = 'myBool';

class _NavigationBarControllerState extends State<NavigationBarController> {
  List<Widget> pages;
  final PageStorageBucket bucket = PageStorageBucket();
  SharedPreferences sharedPreferences;
  bool _testValue;
  EventCoordinator coordinator = new EventCoordinator();

  int _selectedIndex = 1;

  prepareUser() async {
    await UserInstance().assignUserFromDefaults();
    this.pages = setpages();
  }

  List<Widget> setpages() {
    if (UserInstance().token == null) {
      List<Widget> pages = [
        TimelinePage(
          key: PageStorageKey('TimelinePage'),
        ),
        NewDiscover(
          key: PageStorageKey('DiscoverPage'),
        ),
        DiscoverPageNew(
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
        DiscoverPageNew(
          key: PageStorageKey('MapPage'),
        ),
        ProfilePage(
          key: PageStorageKey('ProfilePage'),
        ),
      ];
      return pages;
    }
  }

  initState() {
    prepareUser();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      _testValue = sharedPreferences.getBool(spKey);
      // will be null if never previously saved
      if (_testValue == null) {
        _testValue = false;
        //persist(_testValue); // set an initial value
      }
      setState(() {});
    });
    this.pages = setpages();
  }

  // void persist(bool value) {
  //   setState(() {
  //     _testValue = value;
  //   });
  //   sharedPreferences?.setBool(spKey, value);
  // }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline), title: Text('Timeline'), backgroundColor: Color(0xff486581)),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Discover'), backgroundColor: Color(0xff486581)),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map'), backgroundColor: Color(0xff486581)),
          BottomNavigationBarItem(
              icon: Icon(Icons.face), title: Text('Profile'), backgroundColor: Color(0xff486581)),
        ],
        backgroundColor: Color(0xff486581)      );
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
