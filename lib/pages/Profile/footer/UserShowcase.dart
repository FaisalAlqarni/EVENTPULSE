import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Profile/footer/HistoryShowcase.dart';
import 'package:senior_project/Pages/Profile/footer/REVIEWSShowcase.dart';

import '../../user_instance.dart';

class UserShowcase extends StatefulWidget {

  UserInstance user = UserInstance();

  @override
  _UserShowcaseState createState() => new _UserShowcaseState();
}

class _UserShowcaseState extends State<UserShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'History'),
      new Tab(text: 'Reviews'),
    ];
    _pages = [
      new HistoryShowcase(),
      new REVIEWSShowcase(),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        right: 16.0,
        left: 16.0,
      ),
      child: new Column(
        children: <Widget>[
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(390.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
