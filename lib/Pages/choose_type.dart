import 'package:flutter/material.dart';
import 'user_signup.dart';

class ChooseType extends StatelessWidget {

  final String title= "type";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: new Container(
        margin: EdgeInsets.only(left: 55),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Choose user type:', style: TextStyle(color: Colors.black, fontSize: 40),),
              new Text(''),
              new Text(''),
              new Text(''),
              new Text(''),
              new MaterialButton(
                minWidth: 300,
                color: Colors.green,
                splashColor: Colors.teal,
                textColor: Colors.white,
                child: new Text('User', style: TextStyle(fontSize: 50),),
                onPressed: () {
                  Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => UserSignUp()),
                  );
                },
              ),
              new Text(''),
              new Text(''),
              new Text(''),
              new MaterialButton(
                minWidth: 300,
                color: Colors.green,
                splashColor: Colors.teal,
                textColor: Colors.white,
                child: new Text('Orgnaizer', style: TextStyle(fontSize: 50),),
                onPressed: () {

                },
              ),
          ],
          ),
      ),
    );
  }
}