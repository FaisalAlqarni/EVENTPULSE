import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Discover/discoverpage.dart';
import 'package:senior_project/Pages/Navigation/navigation_controler.dart';
import 'package:senior_project/Pages/Profile/footer/UserShowcase.dart';
import 'package:senior_project/Pages/Profile/header/friend_detail_header.dart';
import 'package:senior_project/Pages/Profile/user_detail_body.dart';
import 'package:senior_project/Pages/user_instance.dart';
import 'package:senior_project/pages/Profile/edit/EditProfie.dart';
import '../../navigation_bar.dart';

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
          const Color(0xFF673ab7),
          const Color(0xFF673ab7),
        ],
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
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
