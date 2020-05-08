import 'package:EventPulse/Pages/user_others.dart';
import 'package:http/http.dart' as http;
import 'MotherActivity.dart';

class Comment extends MotherActivity {
  int id;
  UserOthers user;
  int commentable_id;
  String body;


  Comment(
    this.id,
    this.user,
    this.commentable_id,
    this.body,
  );

factory Comment.fromJson(Map<String, dynamic> json) {
    var json_user  = json['user'];
     UserOthers temp; 
    if (json_user == null) {
      temp = new UserOthers(222, "du", null, "endu",0,0);
    } else {
     temp = UserOthers.fromJson(json_user);
    }
    
    return Comment(json['id'], temp, json['commentable_id'], json['body'],);
  }
  factory Comment.fromJson_noUser(Map<String, dynamic> jsonWithNoUser, Map<String, dynamic> jsonUser) {
 
    UserOthers parsedUser = UserOthers.fromJson(jsonUser);
    return Comment(jsonWithNoUser['id'], parsedUser, jsonWithNoUser['commentable_id'], jsonWithNoUser['body'],);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'user': user,
        'post_id': commentable_id,
        'body': body,
      };

 @override
  String motherMethod() {
    return "has commented : " + this.body;
  }

  @override
  String notificationMethod() {
    return "has commented to your post : " + this.body;
  }

}