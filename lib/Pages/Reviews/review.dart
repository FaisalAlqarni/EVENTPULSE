import 'dart:io';
import 'package:http/http.dart' as http;
import '../comment.dart';

class Review {
  int id;
  String title;
  String meat;
  File image;
  double rating;
  int event_id;
  int user_id;
  List<Comment> comments = List<Comment>();

  Review(this.id, this.title, this.meat, this.image, this.rating, this.event_id, this.user_id, this.comments);

  factory Review.fromJson(Map<String, dynamic> json) {
    var json_comments  = json['comments'];
    List<Comment> parsedComments = new List<Comment>();
    //print(streetsFromJson.runtimeType);
    // List<String> streetsList = new List<String>.from(streetsFromJson);
     for (var i in json_comments) {
        print("WWWSSSSSSSSSSSSSSSS--------");
       print(i.toString());
         print("WWWSSSSSSSSwwwwSSSSSSSS--------");
        Comment temp = Comment.fromJson(i);
        parsedComments.add(temp);
      }

    return Review(json['id'], json['title'], json['meat'], json['image'],
        json['rating'],json['event_id'],json['user_id'],parsedComments);
  }

/*   void configureComments(){
      for (var i in json_comments) {
        print("X_____))XXXX___");
        Comment tmp = Comment.fromJson(i);
        print(i);
        comments.add(Comment.fromJson(i));
      }
  } */

  Map<String, dynamic> toJson() => {
        'title': title,
        'meat': meat,
        'rating': rating,
        'event_id': event_id,
        'user_id': user_id
      };
}
