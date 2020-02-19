import 'dart:convert';

import 'package:EventPulse/Pages/API.dart';
import 'package:EventPulse/Pages/ProfileOthers/edit/EditProfie.dart';
import 'package:EventPulse/Pages/ProfileOthers/footer/UserShowcase.dart';
import 'package:EventPulse/Pages/ProfileOthers/header/friend_detail_header.dart';
import 'package:EventPulse/Pages/ProfileOthers/user_detail_body.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Navigation/navigation_controler.dart';
import 'package:EventPulse/Pages/user_others.dart';

class ProfilePageOthers extends StatefulWidget {
  final int rootUserid;
  const ProfilePageOthers({Key key, this.rootUserid}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<ProfilePageOthers> {
  UserOthers rootuser;
/*   Future<UserOthers> getUserr(int rootUser) async {
    await API.getUser(rootUser).then((response) {
      print(response);
      setState(() {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        print(response.body);
        rootuser = UserOthers.fromJson(parsedJson);

        print('//////////////////////////////////////////');
        print(rootuser.name);
        return rootuser;
      });
    });
  } */

  initState() {
    super.initState();
    //getUserr(widget.rootUserid);
  }

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
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                future: API.getUser(widget.rootUserid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    rootuser = UserOthers.fromJson(snapshot.data);
                    return new UserDetailHeaderOthers(rootUser: rootuser);
                  } else {
                    return null;
                  }
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: FutureBuilder(
                  future: API.getUser(widget.rootUserid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      rootuser = UserOthers.fromJson(snapshot.data);
                      return new UserDetailBodyOthers(rootUser: rootuser);
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              FutureBuilder(
                future: API.getUser(widget.rootUserid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    rootuser = UserOthers.fromJson(snapshot.data);
                    return new UserShowcaseOthers(rootUser: rootuser);
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
