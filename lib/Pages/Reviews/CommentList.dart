import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/comment.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:EventPulse/Pages/API.dart';

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
  Widget _buildChild(context, widget) {
    return Row(
        children: <Widget>[
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
            //height: 3,
          ),
        )]);
    //Text('Comments   ', style: TextStyle(color: Colors.black, height: 3, ),),
  }

  Widget _buildNilChild(context, widget) {
    return Text("nil");
    //Text('Comments   ', style: TextStyle(color: Colors.black, height: 3, ),),
  }

  _setW(context, widget) {
    if (UserInstance().name == null) {
      return _buildNilChild(context, widget);
    } else {
      return _buildChild(context, widget);
    }
  }

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
        actions: <Widget>[_setW(context, widget)],
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
