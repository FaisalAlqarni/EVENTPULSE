import 'package:EventPulse/Pages/MotherActivity.dart';
import 'package:EventPulse/Pages/user_others.dart';

class CheckActivity extends MotherActivity { 
  UserOthers follower;
  int following_id;
  String following_name;

  CheckActivity(this.follower, this.following_id, this.following_name);

    factory CheckActivity.fromJson(Map<String, dynamic> json, Map<String, dynamic> jsonUser) {
      UserOthers parsedUser = UserOthers.fromJson(jsonUser);
      return CheckActivity(parsedUser, json['id'], json['name']);
  }

   @override
  String motherMethod() {
    return "just checked-in " + this.following_name;
  }

}