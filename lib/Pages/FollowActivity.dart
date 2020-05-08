import 'dart:io';
import 'package:EventPulse/Pages/MotherActivity.dart';
import 'package:http/http.dart' as http;
import 'user_others.dart';

class FollowActivity extends MotherActivity { 
  UserOthers follower;
  int following_id;
  String following_name;

  FollowActivity(this.follower, this.following_id, this.following_name);

    factory FollowActivity.fromJson(Map<String, dynamic> json, Map<String, dynamic> jsonUser) {
      UserOthers parsedUser = UserOthers.fromJson(jsonUser);
      return FollowActivity(parsedUser, json['id'], json['name']);
  }

   @override
  String motherMethod() {
    return "just followed " + this.following_name;
  }

   @override
  String notificationMethod() {
    return follower.name + " just followed you!";
  }

}