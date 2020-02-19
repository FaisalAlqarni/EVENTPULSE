import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Navigation/navigation_controler.dart';
import 'package:EventPulse/Pages/Profile/footer/UserShowcase.dart';
import 'package:EventPulse/Pages/Profile/header/friend_detail_header.dart';
import 'package:EventPulse/Pages/Profile/user_detail_body.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:EventPulse/pages/Profile/edit/EditProfie.dart';

class ProfilePage extends StatefulWidget {
    const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  void _showDialog(Text ttl, Text cntnt) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: ttl,
          content: cntnt,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFFf0f4f8),
          const Color(0xFFf0f4f8),
        ],
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        leading: new Container(),
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Profile",
          style: TextStyle(color:Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new EditProfile();
                  },
                ),
              );
              //_showDialog(new Text("I can't see you now"),
              //    new Text("logged out successfully"));
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              UserInstance().distroyUser();
              if (UserInstance().token == null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NavigationBarController()));
                _showDialog(new Text("I can't see you now"),
                    new Text("logged out successfully"));
              } else {
                _showDialog(
                    new Text("Failed!"), new Text("couldn't nullfiy user"));
              }
            },
          )
        ],
      ),
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new UserDetailHeader(),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new UserDetailBody(),
              ),
              new UserShowcase(),
            ],
          ),
        ),
      ),
    );
  }
}
