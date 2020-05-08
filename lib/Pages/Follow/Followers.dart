import 'package:EventPulse/Pages/ProfileOthers/user_details_page.dart';
import 'package:flutter/material.dart';
import '../API.dart';

class Followers extends StatefulWidget {
  final int userId;
  const Followers({Key key, this.title, this.userId}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color:  Theme.of(context).primaryColorDark,
          onPressed: () {Navigator.pop(context);
          },
        ),
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: API.getFollowers(widget.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].avatar.toString()),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (c) {
                            return new ProfilePageOthers(
                              rootUserid: 1,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
