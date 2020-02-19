import 'package:EventPulse/Pages/Profile/user_details_page.dart';
import 'package:EventPulse/Pages/ProfileOthers/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Reviews/review.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:EventPulse/Pages/Reviews/CommentList.dart';
import '../API.dart';
import '../comment.dart';
class ReviewView extends StatefulWidget {
  final Review rootReview;
  const ReviewView({Key key, this.rootReview}) : super(key: key);

  @override
  createState() => _MyViewScreenState();
}
UserInstance userInstance = UserInstance();

class _MyViewScreenState extends State<ReviewView> {
  List images = [
    'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'
  ];

  List<Comment> comments = [];
  TextEditingController _textFieldController = TextEditingController();
  String textfiel;

  initState() {
    super.initState();
    _getComments();
  }

  dispose() {
    super.dispose();
  }

  Widget likeButton(context, widget) {
    return IconButton(
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
    );
  }

  Widget nilChild() {
    return Container();
  }

  Widget noComments() {
    return Text(
      '\nTHERE ARE NO COMMENTS!'.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold),
    );
  }

  /* _setLikeButton(context, widget) {
    if (widget.rootReview.comments.count > 0) {
      return nilChild();
    } else {
      return likeButton(context, widget);
    }
  } */

  Widget _buildChild(context, widget) {
    return Row(children: <Widget>[
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
                    new IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        textfiel = _textFieldController.text;
                        print(_textFieldController.text.toString());
                        API.postComment(context, UserInstance().id, textfiel);
                        print(UserInstance().id);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
      ),
    ]);
    //Text('Comments   ', style: TextStyle(color: Colors.black, height: 3, ),),
  }

  Widget _buildcommentsChild(context, widget) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.rootReview.comments.length,
      itemBuilder: (context, index) {
        return Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              print(userInstance.id);
                              if(userInstance.id == comments[index].user_id){
                                return ProfilePage();
                              }else{
                                return new ProfilePageOthers(rootUserid: comments[index].user_id);
                              }
                              
                            },
                          ),
                        );
                      },
                    );
                    
                  },
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundImage: new NetworkImage(
                        'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                  ),
                  trailing: _setEditButton(comments[index]),
                  title: Text(comments[index].user_id.toString(),
                      style: TextStyle(fontSize: 24)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        comments[index].body,
                        style: TextStyle(fontSize: 20),
                        maxLines: 2,
                      )
                    ],
                  ),

                  // subtitle: ,
                ),
              ],
            ),
          ),
        );
      },
    );
    //Text('Comments   ', style: TextStyle(color: Colors.black, height: 3, ),),
  }

  _setW(context, widget) {
    print('88888888888888888');
    print(UserInstance().name);
    if (UserInstance().name == null) {
      return nilChild();
    } else {
      return _buildChild(context, widget);
    }
  }

  _setComments(context, widget) {
    if (comments.length < 1) {
      return noComments();
    } else {
      return _buildcommentsChild(context, widget);
    }
  }

  _getComments() {
    comments = widget.rootReview.comments;
    print("NILLLLLLLLLLLL");
    print(widget.rootReview.comments.length);
    print(comments.length);
  }

  _setEditButton(Comment comment) {
    if (comment.user_id != UserInstance().id) {
    } else {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('edit away!'),
                  content: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: comment.body),
                    controller: _textFieldController,
                  ),
                  actions: <Widget>[
                    new IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        textfiel = _textFieldController.text;
                        print(_textFieldController.text.toString());
                        API.editComment(comment.id, textfiel);
                        comment.body = textfiel;
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
      );
    }
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
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Theme.of(context).primaryColorDark),
        actions: <Widget>[
          _setW(context, widget),
          Text(
            '      ',
            style: TextStyle(
              color: Colors.black,
              height: 3,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Card(
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
                      color: Theme.of(context).primaryColorDark,
                      borderColor: Theme.of(context).primaryColorDark,
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
                  title: Text(widget.rootReview.title,
                      style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w900)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.rootReview.user_name.toString() + "\n",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold)),
                      Text(
                        widget.rootReview.meat,
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColorDark),
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
                            // Image.network(
                            //   widget.rootReview.image.toString(),
                            //   width: s_width - 30,
                            // )
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\n',
            style: TextStyle(fontSize: 2),
          ),
          Divider(
            color: Theme.of(context).primaryColorDark,
            thickness: 2,
          ),
          Text(
            'COMMENTS',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Theme.of(context).primaryColorDark,
            thickness: 2,
          ),
          Text(
            '\n',
            style: TextStyle(fontSize: 2),
          ),
          _setComments(context, widget)
        ],
      )),
    );
  }
}
