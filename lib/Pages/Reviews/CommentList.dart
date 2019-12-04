import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Reviews/ReviewView.dart';
import 'package:senior_project/Pages/comment.dart';
import 'package:senior_project/Pages/user_instance.dart';
import 'package:senior_project/Pages/API.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CommentList extends StatefulWidget {
  final List<Comment> comments;

  const CommentList({Key key, this.comments}) : super(key: key);

  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State<CommentList> {
  TextEditingController _textFieldController = TextEditingController();
  String textfiel;
  int userId = UserInstance().id;
  get rating => 4.0;

  _getComments() {
    print(widget.comments[0]);
  }

  initState() {
    super.initState();
    _getComments();
  }

  dispose() {
    super.dispose();
  }

  _displayDialog(BuildContext context) async {
    //print(UserInstance().id);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Type a comment'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: ""),
            ),
            actions: <Widget>[
              new FlatButton(
                child: Text('post'),
                onPressed: () {
                  API.postComment(context, UserInstance().id,
                      _textFieldController.text.toString());
                  print(UserInstance().id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Comments List",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Type a comment'),
                      content: TextField(
                        controller: _textFieldController,
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: Text('post'),
                          onPressed: () {
                            textfiel = _textFieldController.text;
                            print(_textFieldController.text.toString());
                            API.postComment(context, userId, textfiel);
                            print(UserInstance().id);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
          Text(
            'create   ',
            style: TextStyle(
              color: Colors.black,
              height: 3,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: new NetworkImage(
                          'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                    ),
                    title: Text(widget.comments[index].user_id.toString(),
                        style: TextStyle(fontSize: 24)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.comments[index].body,
                          style: TextStyle(fontSize: 20),
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
