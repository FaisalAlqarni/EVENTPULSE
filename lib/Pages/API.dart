import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:EventPulse/Pages/Reviews/review.dart';
import 'package:EventPulse/Pages/comment.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class API {
  static Future<Map<String, dynamic>> getCurrentUser(String token) async {
    var url = "http://event-discoverer-backend.herokuapp.com/api/users/current";
     final response = await http.get(url, headers: {'X-Auth-Token': token} );

  if (response.statusCode == 200) {
    print('RETURNING: ' + response.body);
    return json.decode(response.body); // <------ CHANGED THIS LINE
  } else {
    throw Exception('Failed to load post');
  }
    //return http.get(url);
  }
  static Future getEvent() {
    var url = "http://event-discoverer-backend.herokuapp.com/api/events";
    return http.get(url);
  }

  static Future getEventReviewss(int event_id) {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/reviews?event_id=${event_id}";
    return http.get(url);
  }

  static Future getCategory() {
    var url = "http://event-discoverer-backend.herokuapp.com/api/categories";
    return http.get(url);
  }

  static Future getReview() {
    var url = "http://event-discoverer-backend.herokuapp.com/api/events";
    return http.get(url);
  }

  static Future getComment() {
    var url = "http://event-discoverer-backend.herokuapp.com/api/events";
    return http.get(url);
  }

  static Future<Map<String, dynamic>> getUser(int user_id) async {
    String x = user_id.toString();
    var url = 'http://event-discoverer-backend.herokuapp.com/api/users/$x';
    final response = await http.get(url);

  if (response.statusCode == 200) {
    print('RETURNING: ' + response.body);
    return json.decode(response.body); // <------ CHANGED THIS LINE
  } else {
    throw Exception('Failed to load post');
  }
    //return http.get(url);
  }

  static Future<UserInstance> requestLogin(
      BuildContext context, String email, String password) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/login";

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      UserInstance.fromJson(responseJson);
      UserInstance().persistUser();
      return UserInstance.fromJson(responseJson);
    } else {
      return null;
    }
  }

  static Future<UserInstance> requestSignup(
      BuildContext context, String email, String password, String name) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/register";

    Map<String, String> body = {
      'email': email,
      'password': password,
      'name': name
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      UserInstance.fromJson(responseJson);
      UserInstance().persistUser();
      return UserInstance.fromJson(responseJson);
    } else {
      return null;
    }
  }

  static Future<UserInstance> requestUpdateUser(
      BuildContext context, String email, String name, String token) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/users/edit";

    Map<String, String> body = {
      'email': email,
      'name': name,
    };
    Map<String, String> header = {'X-Auth-Token': token};

    final response = await http.post(
      url,
      body: body,
      headers: header,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print('before editing////////////////////');
      print(UserInstance().email + ' - ' + UserInstance().name);
      UserInstance().email = email;
      UserInstance().name = name;
      print('After editing=====================');
      print(UserInstance().email + ' - ' + UserInstance().name);
      UserInstance.fromJson(responseJson);
      UserInstance().persistUser();
      return UserInstance.fromJson(responseJson);
    } else {
      print(UserInstance().email + ' - ' + UserInstance().name);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror');
    }
  }

  static Future<Comment> postComment(
      BuildContext context, int user_id, String commentBody) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/comments";

    Map<String, dynamic> body = {
      'body': commentBody.toString(),
      'user_id': user_id.toString(),
      'commentable_type': 'App\\Review'
    };

    final response = await http.post(
      url,
      body: body,
    );
    print('//DDSSSSSDSDDD//////');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      return Comment.fromJson(responseJson);
    } else {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror');
    }
  }

  static Future<List<Review>> getEventReviews(
      BuildContext context, int event_id) async {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/reviews?event_id=$event_id";
    List<Review> reviews = List<Review>();

    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      for (var i in responseJson) {
        Review temp = Review.fromJson(i);
        reviews.add(temp);
      }
      return reviews;
    } else {
      return null;
    }
  }

  static Future<int> postReview(BuildContext context, String title, String meat,
      double rating, int eid, int uid) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/reviews";

    Map<String, dynamic> body = {
      'title': title.toString(),
      'meat': meat.toString(),
      'rating': rating.toString(),
      'event_id': eid.toString(),
      'user_id': uid.toString()
    };

    final response = await http.post(
      url,
      body: body,
    );
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);

      return 201;
    } else {
      return null;
    }
  }

  static Future<Event> postInterest(
      BuildContext context, int event_id, int user_id) async {
    final url =
        "http://event-discoverer-backend.herokuapp.com/api/event_interests";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'event_id': event_id.toString()
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
    } else {
      return null;
    }
  }

    static Future<Event> postBookmark(
      BuildContext context, int event_id, int user_id) async {
    final url =
        "http://event-discoverer-backend.herokuapp.com/api/event_bookmarks";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'event_id': event_id.toString()
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future isIntrested(int event_id, int user_id) {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/event_interests/event?user_id=$user_id&event_id=$event_id";

    return http.get(url);
  }

  static Future isBookmarked(int event_id, int user_id) {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/event_bookmarks/event?user_id=$user_id&event_id=$event_id";

    return http.get(url);
  }

static editComment(int comment_id, String comment) async {
    // set up PUT request arguments
    String url =  "http://event-discoverer-backend.herokuapp.com/api/comments/$comment_id";
    //Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    
    Map<String, dynamic> body = {
      'body': comment,
    };

    final response = await http.put(
      url,
      body: body,
    );
}

  static follow(BuildContext context, int following_id, int user_id) async {
    final url ="http://event-discoverer-backend.herokuapp.com/api/users/follow";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'following_id': following_id.toString()
    };
  Map<String, String> header = {'Content-Type': "application/x-www-form-urlencoded"};
    final response = await http.post(
      url,
      body: body,
      headers: header
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
    } else {
      return null;
    }
  }
  
}
