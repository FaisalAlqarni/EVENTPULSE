import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_project/Pages/home_page.dart';

class UserSignUp extends StatefulWidget {
  static get usernameController => null;

  static get emailController => MyHomePage;

  @override
  State createState() => new UserSignUpState();
}

class UserSignUpState extends State<UserSignUp>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  //these to pass user input values
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
            
              new Container(
                padding: const EdgeInsets.all( 20),
                child: new Form(
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        controller: firstNameController,
                        decoration: new InputDecoration(
                            labelText: "First Name", fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                      ),
                      new TextFormField(
                        controller: lastNameController,
                        decoration: new InputDecoration(
                            labelText: "Last Name", fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                      ),
                      new TextFormField(
                        controller: usernameController,
                        decoration: new InputDecoration(
                            labelText: "Username", fillColor: Colors.white),
                        keyboardType: TextInputType.text,
                      ),
                      new TextFormField(
                        controller: emailController,
                        decoration: new InputDecoration(
                            labelText: "Email", fillColor: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      new TextFormField(
                        controller: passwordController,
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
                        child: new Text('Sign-UP', style: TextStyle(fontSize: 25),),
                        onPressed: performSignup,
                      ),
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
                        
  void performSignup() {
    String username = usernameController.text;
    String password = passwordController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Signed-Ip seccussfully"),
          content: new Text("login attempt:\n username:$username \n password $password"),
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