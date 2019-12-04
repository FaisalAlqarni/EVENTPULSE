import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Reviews/review.dart';
import 'package:senior_project/navigation_bar.dart';
import 'package:senior_project/topBar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:senior_project/Pages/Reviews/CommentList.dart';

class ReviewView extends StatefulWidget {
  final Review rootReview;

  const ReviewView({Key key, this.rootReview}) : super(key: key);

  @override
  createState() => _MyViewScreenState();
}

class _MyViewScreenState extends State<ReviewView> {
  List images = [
    'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'
  ];
  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    double s_width = MediaQuery.of(context).size.width;

    final children = <Widget>[];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Review",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new CommentList(comments: widget.rootReview.comments);
                  },
                ),
              );
            },
          ),

          Text('Comments   ', style: TextStyle(color: Colors.black, height: 3, ),),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (v) {
                      var rating = v;
                      setState(() {});
                    },
                    starCount: 5,
                    size: 20.0,
                    color: Colors.deepPurple,
                    borderColor: Colors.deepPurple,
                    spacing: 0.0),
                onTap: () {
                  /// what to do?
                },
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                ),
                //leading: Text('THIS IS THE TITLE\n', style: TextStyle(fontSize: 15),),
                title: Text(widget.rootReview.title, style: TextStyle(fontSize: 24)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.rootReview.user_id.toString() + "\n", style: TextStyle(fontSize: 14)),
                    Text(
                      widget.rootReview.meat,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),

                // subtitle: ,
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            widget.rootReview.image.toString(),
                            width: s_width - 30,
                          )
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
