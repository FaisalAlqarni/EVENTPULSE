import 'package:EventPulse/Pages/user_others.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/ProfileOthers/footer/HistoryShowcase.dart';
import 'package:EventPulse/Pages/ProfileOthers/footer/REVIEWSShowcase.dart';


class UserShowcaseOthers extends StatefulWidget {

    final UserOthers rootUser;
    const UserShowcaseOthers({Key key, this.rootUser}) : super(key: key);

  @override
  _UserShowcaseStateOthers createState() => new _UserShowcaseStateOthers();
}

class _UserShowcaseStateOthers extends State<UserShowcaseOthers>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'History'.toUpperCase()),
      new Tab(text: 'Reviews'.toUpperCase()),
    ];
    _pages = [
      new HistoryShowcaseOthers(),
      new REVIEWSShowcaseOthers(),
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
            indicatorColor: Theme.of(context).primaryColorDark,
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
