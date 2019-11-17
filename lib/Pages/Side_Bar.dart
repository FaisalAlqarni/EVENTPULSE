
import 'package:flutter/material.dart';
import 'create_event.dart';
import 'login.dart';
import 'user_signup.dart';

class AppDrawer extends StatelessWidget{
  String username = 'guest';
  String email = 'email';
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
         children: <Widget>[
           Container(
             width: double.infinity,
             padding: EdgeInsets.all(20),
             color: Colors.deepPurple,
             child: Center(
               child: Column(
                 children: <Widget>[
                   Container(
                     width: 140,
                     height: 140,
                     margin: EdgeInsets.only(top: 25, bottom: 20),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: NetworkImage('https://png.pngtree.com/png-clipart/20190520/original/pngtree-business-male-icon-vector-png-image_4187852.jpg'),
                         fit: BoxFit.fill
                         ),
                     ),
                   ),
                   Text(username, style: TextStyle(fontSize: 22,color: Colors.white),),
                   Text(email, style: TextStyle(color: Colors.white),),
                 ],
               ),)
           ),
            ListTile(
             title: Text('Login'),
             trailing: new Icon(Icons.person),
             onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Login()));
             }
           ),
           ListTile(
              title: new Text("Create Event"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => CreateEvent()));
              }
            ),
         ],
        ),
      );
  }
  
}