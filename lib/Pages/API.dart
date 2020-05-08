import 'dart:async';
import 'dart:convert';
import 'package:EventPulse/Pages/ActivityItem.dart';
import 'package:EventPulse/Pages/user_others.dart';
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
    final response = await http.get(url, headers: {'X-Auth-Token': token});

    if (response.statusCode == 200) {
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
      UserInstance().email = email;
      UserInstance().name = name;

      UserInstance.fromJson(responseJson);
      UserInstance().persistUser();
      return UserInstance.fromJson(responseJson);
    } else {}
  }

  static Future<Comment> postComment(
      BuildContext context, int user_id, String commentBody) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/comments";

    Map<String, dynamic> body = {
      'body': commentBody.toString(),
      'user_id': user_id.toString(),
      'commentable_type': 'App\\Review',
    };

    final response = await http.post(
      url,
      body: body,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      return Comment.fromJson(responseJson);
    } else {}
  }

  static Future<Comment> postComment2(BuildContext context, int user_id,
      String commentBody, int review_id) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/comments";

    Map<String, dynamic> body = {
      'body': commentBody.toString(),
      'user_id': user_id.toString(),
      'commentable_type': 'App\\Review',
      'commentable_id': review_id.toString()
    };

    final response = await http.post(
      url,
      body: body,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);

      return Comment.fromJson(responseJson);
    } else {}
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
    String url =
        "http://event-discoverer-backend.herokuapp.com/api/comments/$comment_id";
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
    final url =
        "http://event-discoverer-backend.herokuapp.com/api/users/follow";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'following_id': following_id.toString()
    };
    Map<String, String> header = {
      'Content-Type': "application/x-www-form-urlencoded"
    };
    final response = await http.post(url, body: body, headers: header);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<List<UserOthers>> getFollowers(int userid) async {
    var data = await http.get(
        "http://event-discoverer-backend.herokuapp.com/api/users/$userid/followers");
    var jsonData = json.decode(data.body);

    List<UserOthers> users = [];

    for (var u in jsonData) {
      UserOthers user = UserOthers(u["id"], u["name"], u["avatar"], u["email"],
          u['followers_count'], u['followings_count']);

      users.add(user);
    }
    return users;
  }

  static Future<List<UserOthers>> getFollowing(int userid) async {
    var data = await http.get(
        "http://event-discoverer-backend.herokuapp.com/api/users/$userid/followings");
    var jsonData = json.decode(data.body);

    List<UserOthers> users = [];

    for (var u in jsonData) {
      UserOthers user = UserOthers(u["id"], u["name"], u["avatar"], u["email"],
          u['followers_count'], u['followings_count']);

      users.add(user);
    }
    return users;
  }

  static Future<List<ActivityFactory>> getNextTimelinePage_unused(
      BuildContext context) async {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/timeline/for-user/1";
    List<ActivityFactory> activities = List<ActivityFactory>();

    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      for (var i in responseJson) {
        ActivityFactory temp = ActivityFactory.fromJson(i);
        activities.add(temp);
      }
      return activities;
    } else {
      return null;
    }
  }

  static Future getHistory(int x) {
    //for history
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/timeline/of-user/$x";
    return http.get(url);
  }

  static Future getTimeline(int x) {
    //for timeline
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/timeline/for-user/$x";
    return http.get(url);
  }

    static Future getCheckableEvents() {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/events/findByRange";
    return http.get(url);
  }

  static Future<UserInstance> checkinNOW(String user_id, String event_id) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/event_checkins";

    Map<String, dynamic> body = {
      'user_id': user_id,
      'event_id': event_id,
    };

    final response = await http.post(
      url,
      body: body,
    );

/*     if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      UserInstance.fromJson(responseJson);
      UserInstance().persistUser();
      return UserInstance.fromJson(responseJson);
    } else {
      return null;
    } */
  }

    static Future<Event> postUpVote(int user_id, int timeline_item_id) async {
    final url =
        "http://event-discoverer-backend.herokuapp.com/api/timeline/upvote";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'timeline_item_id': timeline_item_id.toString()
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

    static Future<Event> postDownVote(int user_id, int timeline_item_id) async {

    final url =
        "http://event-discoverer-backend.herokuapp.com/api/timeline/downvote";

    Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'timeline_item_id': timeline_item_id.toString()
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

   static Future getNotification() {
     
    int x = UserInstance().id;
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/notification/for-user/$x";
    return http.get(url);
  }

   static Future notificationsAreRead() {
    int x = UserInstance().id;
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/notification/are-read/$x";
    return http.post(url);
  }

    static Future isfollowing(int user_id, int following_id) async {
    var url =
        "http://event-discoverer-backend.herokuapp.com/api/users/isfollowing";

        Map<String, dynamic> body = {
      'user_id': user_id.toString(),
      'following_id': following_id.toString()
    };

    final response = await http.post(
      url,
      body: body,
    );

    if(response.statusCode == 200){
      final responseJson = json.decode(response.body);
      print(responseJson);
      bool isit = responseJson["is_following"];
      return isit;

    }
    else{
      return null;
    }
  }


}
