import 'package:http/http.dart' as http;

class Comment{
  int id;
  int user_id;
  int commentable_id;
  String body;

  Comment(
    this.id,
    this.user_id,
    this.commentable_id,
    this.body
  );

 factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(json['id'], json['user_id'], json['commentable_id'], json['body']);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'user_id': user_id,
        'post_id': commentable_id,
        'body': body,
      };


}