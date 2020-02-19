import 'dart:convert';
import 'dart:core' ;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:EventPulse/Pages/API.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:email_validator/email_validator.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
      final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _status = true;
  FocusNode myFocusNode = FocusNode();
  //UserInstance user = UserInstance();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  String _email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  File file;
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
  void _choose() async {
    //file = await ImagePicker.pickImage(source: ImageSource.camera);
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
 }

 _upload(File imageFile) async {    
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse('http://event-discoverer-backend.herokuapp.com/api/users/edit');
    Map<String, String> headers = { "Accesstoken": "access_token"};

     var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: path.basename(imageFile.path));
          //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
    void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _updateUser();
    }
    else{
      setState(() {
          _status = false;
        });
      print('error');
      AlertDialog(
        title: Text('ERROR'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('THE EMAIL IS IN WRONG FORMAT'),
            ],
          ),
        ));
    }
  }
    _updateUser() async {
      String email = _email; //_emailController.text;
      String name = _nameController.text;
      String token = UserInstance().token;
      await API.requestUpdateUser(context, email, name, token);
      setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
/*       if (x == null) {
        _showDialog(new Text("no go :("), new Text("Something went wrong!"));
      } else {

      } */
    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             new CircleAvatar(
                              backgroundImage: new NetworkImage(UserInstance().avatar) ?? 'https://blogs.aca-it.be/wp-content/uploads/2019/03/user-300x300.png'
                              ,radius: 75.0,
                            ), 

                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColorDark,
                                  radius: 25.0,
                                  child: new IconButton(
                                    icon: Icon(Icons.camera_alt, color: Colors.white,),
                                    onPressed: (){
                                      _choose();
                                    },
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColorDark),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColorDark),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    focusColor: Colors.white,
                                    hintText: UserInstance().name,
                                    hintStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold)
                                  
                                  
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                  
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                        ,color: Theme.of(context).primaryColorDark),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: Form(
                                  key: formKey,
                                  child: new TextFormField(
                                  //controller: _emailController,
                                  decoration:
                                      InputDecoration(
                                        hintText: UserInstance().email,
                                        hintStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold)

                                        ),
                                  enabled: !_status,
                                  validator: (val) => !EmailValidator.validate(val, true)
                                    ? 'Not a valid email.'
                                    : null,
                                onSaved: (val) => _email = val,
                                ),
                                )
                                
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save",style: TextStyle(fontWeight: FontWeight.bold),),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  //_upload(file);
                  //_updateUser();
                  _submitCommand();
                  /* setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }); */
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _nameController.clear();
                    _emailController.clear();
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Theme.of(context).primaryColorDark,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
