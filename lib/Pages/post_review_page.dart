import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../navigation_bar.dart';
import '../topBar.dart';
import 'API.dart';
import 'Discover/discoverpage.dart';

// Create a Form widget.
class PostReviewPage extends StatefulWidget {
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
        padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          children: <Widget>[
            Text(
              'Review title',
              style: TextStyle(color: Colors.deepPurple),
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
              'Review',
              style: TextStyle(color: Colors.deepPurple),
            ),
            TextFormField(
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
              style: TextStyle(color: Colors.deepPurple),
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
                backgroundColor: Colors.deepPurple,
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
              'Rate',
              style: TextStyle(color: Colors.deepPurple),
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
                color: Colors.yellowAccent,
                borderColor: Colors.yellow,
                spacing: 0.0),
          ],
        ));
  }

   //login and register fuctions
    void _postReview() async {
      var title = _title.text;
      var meat = _meat.text;

      var review = await API.postReview(context, title, meat, _rating, _image);

      if (review == null) {
        _showDialog(new Text("no go :("), new Text("Something went wrong!"));
      } else {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => NewDiscover()));
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
        backgroundColor: Colors.white,
        appBar: TopBar(
          pageTitle: "Review page",
          height: 60,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  review_title(),
                  review_meat(),
                  review_pictures(),
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
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          currindx: 1,
        ));
  }
}
