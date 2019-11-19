
import 'package:flutter/material.dart';
import 'MainLogin.dart';
//import 'create_event.dart';
import 'event_manager.dart';

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
                         image: AssetImage('assets/images/user.png'),
                         fit: BoxFit.fill
                         ),
                     ),
                   ),
                   Text(username, style: TextStyle(fontSize: 22,color: Colors.white),),
                   Text(email, style: TextStyle(color: Colors.white),),
                 ],
               ),)
           ),
           new Container(
            color: Colors.white,
            child:  Column(
              children: <Widget>[
                ListTile(
                title: Text('LOGIN & REGISTRATION'),
                trailing: new Icon(Icons.person),
                onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MainLogin()));
                }
              ),
              ListTile(
                  title: new Text("EVENT MANAGER"),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => EventManager()));
                  }
                ),
              ] 
            ),
           ),
         ],
        ),
      );
  }
  
}