import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Reviews/ReviewView.dart';
import 'package:EventPulse/Pages/Reviews/review.dart';
import 'package:EventPulse/topBar.dart';
import 'package:EventPulse/Pages/API.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../post_review_page.dart';
import '../user_instance.dart';

class ReviewList extends StatefulWidget {
  final int event_id;

  const ReviewList({Key key, this.event_id}) : super(key: key);
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State<ReviewList> {
  var reviews = List<Review>();
  get rating => 4.0;

  _getReviews() async {
    API.getEventReviewss(widget.event_id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        reviews = list.map((model) => Review.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getReviews();
  }

  dispose() {
    super.dispose();
  }

  Widget addReview(context, widget) {
    return Row(children: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (c) {
                return new PostReviewPage(rootEventid: widget.event_id);
              },
            ),
          );
        },
      ),
      Text(
        'create   ',
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          //height: 3,
        ),
      )
    ]);
  }

  Widget nilChild() {
    return Container();
  }

  _setAddReviewButton(context, widget) {
    if (UserInstance().token == null) {
      return nilChild();
    } else {
      return addReview(context, widget);
    }
  }
Widget noReviews() {
    return Column(
      children: <Widget>[
        Text('\n', style: TextStyle(fontSize: 2),),
          Divider(color: Theme.of(context).primaryColorDark,thickness: 2,),
          Text('NO REVIEWS', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),),
          Divider(color: Theme.of(context).primaryColorDark,thickness: 2,),
          Text('\n', style: TextStyle(fontSize: 2),),        
          Text('\nTHERE ARE NO REVIEWS YET!\nBE THE FIRST TO REVIEW'.toUpperCase(), textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),),
 
      ],
    );
  }

 Widget buildreview(int n){
    if (n < 1) {
      return noReviews();
    } else {
      return ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (c) {
                            return new ReviewView(rootReview: reviews[index]);
                          },
                        ),
                      );
                    },
                    isThreeLine: true,
                    //leading: Text('THIS IS THE TITLE\n', style: TextStyle(fontSize: 15),),
                    title: Text(reviews[index].title,
                        style: TextStyle(fontSize: 24,color: Theme.of(context).primaryColorDark),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(reviews[index].user_name.toString() + "\n",
                            style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColorDark)),
                        Text(
                          reviews[index].meat,
                          style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColorDark),
                          maxLines: 2,
                        )
                      ],
                    ),

                    // subtitle: ,
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        SmoothStarRating(
                            allowHalfRating: true,
                            onRatingChanged: (v) {
                              var rating = v;
                              setState(() {});
                            },
                            starCount: 5,
                            rating: rating,
                            size: 20.0,
                            color: Theme.of(context).primaryColorDark,
                            borderColor: Theme.of(context).primaryColorDark,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Review List",
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Theme.of(context).primaryColorDark),
        actions: <Widget>[_setAddReviewButton(context, widget)],
      ),
      body: buildreview(reviews.length)
      /* ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (c) {
                            return new ReviewView(rootReview: reviews[index]);
                          },
                        ),
                      );
                    },
                    isThreeLine: true,
                    //leading: Text('THIS IS THE TITLE\n', style: TextStyle(fontSize: 15),),
                    title: Text(reviews[index].title,
                        style: TextStyle(fontSize: 24,color: Theme.of(context).primaryColorDark),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(reviews[index].user_name.toString() + "\n",
                            style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColorDark)),
                        Text(
                          reviews[index].meat,
                          style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColorDark),
                          maxLines: 2,
                        )
                      ],
                    ),

                    // subtitle: ,
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        SmoothStarRating(
                            allowHalfRating: true,
                            onRatingChanged: (v) {
                              var rating = v;
                              setState(() {});
                            },
                            starCount: 5,
                            rating: rating,
                            size: 20.0,
                            color: Theme.of(context).primaryColorDark,
                            borderColor: Theme.of(context).primaryColorDark,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ), */
    );
  }
}
