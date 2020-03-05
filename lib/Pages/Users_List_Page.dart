import 'package:EventPulse/Pages/ProfileOthers/user_details_page.dart';
import 'package:EventPulse/Pages/user_others.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

//void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Users'),
//     );
//   }
// }

class Users_List extends StatefulWidget {
  Users_List({Key key, this.title, this.eventid, this.userid}) : super(key: key);

  final String title;
  final int userid ; 
  final int eventid ; 

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Users_List> {

  Future<List<UserOthers>> _getUsers() async {
      int eventid = widget.eventid ;
      int userid = widget.userid ;  

    var data = await http.get("http://event-discoverer-backend.herokuapp.com/api/event_interests/by_following?user_id=$userid&event_id=$eventid");

    var jsonData = json.decode(data.body);

    List<UserOthers> users = [];

    for(var u in jsonData){

      UserOthers user = UserOthers(u["id"], u["name"], u["avatar"],u["email"]);
      
      users.add(user);
      //users.add(UserOthers(0, "cooper","https://m.media-amazon.com/images/M/MV5BNGZjNDk4MTEtNGNkMi00MTYzLThlMTQtMmFjM2YwMzdmNWE4XkEyXkFqcGdeQXVyNzgxMzc3OTc@._V1_SX1777_CR0,0,1777,744_AL_.jpg", "jondoe@something"));

    }

    print(users.length);

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].avatar
                        ),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: (){
                                              Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                  builder: (c) {
                                                    return new ProfilePageOthers(
                                                      rootUserid: snapshot.data[index].id,
                                                    );
                                                  },
                                                ),
                                              );
                                              //null;
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





