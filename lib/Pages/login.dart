import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/Pages/choose_type.dart';

import 'home_page.dart';

class Login extends StatefulWidget {
  @override
  State createState() => new LoginState();
}

class LoginState extends State<Login>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 300));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
        new Theme(
          data: new ThemeData(
              inputDecorationTheme: new InputDecorationTheme(
                // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                    new TextStyle(color: Colors.black, fontSize: 25.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Container(
            margin: EdgeInsets.only(top: 40),
             width: 100000,
            height: 90,
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
                ))),

              new Container(
                padding: const EdgeInsets.all( 40),
                child: new Form(
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText: "Email", fillColor: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Password",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                      ),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.green,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: new Icon(FontAwesomeIcons.signInAlt),
                        onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Signed-In seccussfully"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("go to home screen"),
                                        onPressed: () {
                                          Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyHomePage()),
                                  );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                        },
                      ),
                      new Text(''),
                      new MaterialButton(
                        splashColor: Colors.teal,
                        textColor: Colors.blue,
                        child: new Text("click here to Sign-UP"),
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChooseType()),
                        );
                        },

                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

/*
class Login extends StatelessWidget {

  final String title= "login";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}*/