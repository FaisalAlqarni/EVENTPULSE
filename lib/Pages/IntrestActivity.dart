import 'dart:io';
import 'package:EventPulse/Pages/MotherActivity.dart';
import 'package:http/http.dart' as http;

import 'user_others.dart';

class IntrestActivity extends MotherActivity { 
  UserOthers personOfIntrest;
  int event_id;
  String event_name;

  IntrestActivity(this.personOfIntrest, this.event_id, this.event_name);

    factory IntrestActivity.fromJson(Map<String, dynamic> json, Map<String, dynamic> jsonUser) {
      UserOthers parsedUser = UserOthers.fromJson(jsonUser);
      return IntrestActivity(parsedUser, json['id'], json['name']);
  }

   @override
  String motherMethod() {
    return "is intrested about " + this.event_name;
  }
}