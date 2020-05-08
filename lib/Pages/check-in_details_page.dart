import 'dart:io';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'API.dart';
import 'Navigation/navigation_controler.dart';

// Create a Form widget.
class CheckInDetails extends StatefulWidget {
  final int rootEventid;

  const CheckInDetails({Key key, this.rootEventid}) : super(key: key);

  @override
  CheckInDetailsState createState() {
    return CheckInDetailsState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CheckInDetailsState extends State<CheckInDetails> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<CheckInDetailsState>.
  final _formKey = GlobalKey<FormState>();
  File _image;
  TextEditingController _description = new TextEditingController();

  
  Future check(int userId, int eventId) async {
    await API.checkinNOW(userId.toString(), eventId.toString());

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NavigationBarController()));
  }

  Widget check_in_description() {
    return Container(
        padding: EdgeInsets.only(left: 1, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              '\n\nDescription',
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            TextFormField(
              controller: _description,
            ),
          ],
        ));
  }

  Widget check_in_pictures() {
    return Container(
        padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              'Pictures',
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            Padding(
              child: FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              padding: EdgeInsets.only(top: 4),
            ),
          ],
        ));
  }

  Future getImage() async {
    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      //_image = image;
    });
  }

  //login and register fuctions
  void _checkIn() async {
    var title = _description.text;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NavigationBarController()));

    //var review = await API.postReview(context, title, meat, _rating, widget.rootEventid,UserInstance().id);

    // if (review == null) {
    //   _showDialog(new Text("no go :("), new Text("Something went wrong!"));
    // } else {
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (BuildContext context) => NavigationBarController()));
    // }
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
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color:  Theme.of(context).primaryColorDark,
          onPressed: () {Navigator.pop(context);
          },
        ),
        title:
            Text("             Check in details", textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                check_in_description(),
                check_in_pictures(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        _checkIn();
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
