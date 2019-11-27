import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:senior_project/Pages/user_instance.dart';
import 'package:flutter/material.dart';

class API {
  static Future getEvent() {
    var url = "http://event-discoverer-backend.herokuapp.com/api/events";

    return http.get(url);
  }

  static Future getUser(UserInstance user) {
    var url =
        'http://event-discoverer-backend.herokuapp.com/api/users/' + user.id.toString();
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
}
