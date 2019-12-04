import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:senior_project/Pages/Reviews/review.dart';
import 'package:senior_project/Pages/comment.dart';
import 'package:senior_project/Pages/event.dart';
import 'package:senior_project/Pages/user_instance.dart';
import 'package:flutter/material.dart';

class API {
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

  static Future getUser(String user) {
    var url = 'http://event-discoverer-backend.herokuapp.com/api/users/' +
        user.toString();
    return http.get(url);
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
      'body': commentBody,
      'user_id': user_id,
      'commentable_type': 'App\\Review'
    };

    final response = await http.post(
      url,
      body: json.encode(body),
    );
    print('//DDSSSSSDSDDD//////');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print('////////////////////');
      print(commentBody + ' - ' + user_id.toString());
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

  static Future<Review> postReview(BuildContext context, String title,
      String meat, double rating, File image) async {
    final url = "http://event-discoverer-backend.herokuapp.com/api/reviews";

    Map<String, dynamic> body = {
      'title': title,
      'meat': meat,
      'rating': rating,
      'image': image
    };

    print("_____-------_____________----------_____!@!@!@#@!");
    print(body);
    print(url);

    final response = await http.post(
      url,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print("xx_____xx_____");
      print(responseJson);
      return Review.fromJson(responseJson);
    } else {
      return null;
    }
  }
}
