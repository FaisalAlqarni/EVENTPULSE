import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Reviews/ReviewView.dart';
import 'package:senior_project/Pages/Reviews/review.dart';
import 'package:senior_project/topBar.dart';
import 'package:senior_project/Pages/API.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  @override
  build(context) {
    return Scaffold(
      appBar: TopBar(pageTitle: "Review list", height: 60),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    onTap: (){

                 Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new ReviewView(rootReview: reviews[index]);
                    },
                  ), ) ;                },
                    isThreeLine: true,
                    //leading: Text('THIS IS THE TITLE\n', style: TextStyle(fontSize: 15),),
                    title:
                        Text(reviews[index].title, style: TextStyle(fontSize: 24)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(reviews[index].user_id.toString() + "\n", style: TextStyle(fontSize: 14)),
                        Text(reviews[index].meat, style: TextStyle(fontSize: 20), maxLines: 2,)
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
                            color: Colors.deepPurple,
                            borderColor: Colors.deepPurple,
                            spacing: 0.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
