import 'dart:io';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'API.dart';
import 'Navigation/navigation_controler.dart';

// Create a Form widget.
class PostReviewPage extends StatefulWidget {
  final int rootEventid;

  const PostReviewPage({Key key, this.rootEventid}) : super(key: key);

  @override
  ReviewFormState createState() {
    return ReviewFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ReviewFormState extends State<PostReviewPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<ReviewFormState>.
  final _formKey = GlobalKey<FormState>();
  File _image;
  TextEditingController _title = new TextEditingController();
  TextEditingController _meat = new TextEditingController();
  double _rating = 0;

  Widget review_title() {
    return Container(
        padding: EdgeInsets.only(left: 1, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              '\n\nReview title',
              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            TextFormField(
              controller: _title,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ));
  }

  Widget review_meat() {
    return Container(
        padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              '\nReview',
              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColorDark),
              controller: _meat,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null),
          ],
        ));
  }

  Widget review_pictures() {
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

  Widget review_rating() {
    return Container(
        padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              '\n\n Rate',
              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (v) {
                  _rating = v;
                  setState(() {});
                },
                starCount: 5,
                rating: _rating,
                size: 40.0,
                color: Theme.of(context).primaryColorDark,
                borderColor: Theme.of(context).primaryColorDark,
                spacing: 0.0),
          ],
        ));
  }

   //login and register fuctions
    void _postReview() async {
      var title = _title.text;
      var meat = _meat.text;

      var review = await API.postReview(context, title, meat, _rating, widget.rootEventid,UserInstance().id);

      if (review == null) {
        _showDialog(new Text("no go :("), new Text("Something went wrong!"));
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => NavigationBarController()));
      }
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
          title: Text("             Review page", textAlign: TextAlign.center),
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
                  review_title(),
                  review_meat(),
                  //review_pictures(),
                  review_rating(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          _postReview();
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
