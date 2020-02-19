import 'dart:io';
import 'package:http/http.dart' as http;
import '../comment.dart';

class Review {
  int id;
  String title;
  String meat;
  double rating;
  int event_id;
  int user_id;
  String user_name;
  List<Comment> comments = List<Comment>();

  Review(this.id, this.title, this.meat, this.rating, this.event_id, this.user_id, this.user_name, this.comments);

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
    print("NEAR");
    return Review(json['id'], json['title'], json['meat'], json['rating'].toDouble(),json['event_id'],json['user_id'],json['user_name'], parsedComments);
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
