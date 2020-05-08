import 'package:EventPulse/Pages/FollowActivity.dart';
import 'package:EventPulse/Pages/IntrestActivity.dart';
import 'package:EventPulse/Pages/check-inActivity.dart';
import 'package:EventPulse/Pages/event.dart';
import 'MotherActivity.dart';
import 'Reviews/review.dart';
import 'comment.dart';
import 'user_others.dart';

class ActivityFactory {
  int id;
  UserOthers creator;
  String type;
  MotherActivity activity_object;
  int upvote_count;
  int downvote_count;
  bool upclicked = false;
  bool downclicked = false;
  //double created_at;

  ActivityFactory(this.id, this.creator, this.type, this.activity_object, this.upvote_count, this.downvote_count, /*this.created_at*/);

  factory ActivityFactory.fromJson(Map<String, dynamic> json) {
    String parsedType = json['type'];
    MotherActivity parsedActivity;

    if (parsedType.compareTo('review') == 0) {
       parsedActivity = Review.fromJson_noComments(json['source']);
    } else if (parsedType.compareTo('comment') == 0) {
        parsedActivity = Comment.fromJson_noUser(json['source'],json['creator']);
    } else if (parsedType.compareTo('event_interest') == 0) {
        parsedActivity = IntrestActivity.fromJson(json['source'],json['creator']);
    } else if (parsedType.compareTo('follow_user') == 0) {
        parsedActivity = FollowActivity.fromJson(json['source'],json['creator']);
    }else if (parsedType.compareTo('event_checkin') == 0) {
        parsedActivity = Event.fromJson(json['source']);
    }
    
    var json_user  = json['creator'];
    int paresdUp = json['upvote_count'];
    int parsedDoun = json['downvote_count'];
    UserOthers parsedCreator = UserOthers.fromJson(json_user);

    return ActivityFactory(json['id'], parsedCreator, parsedType, parsedActivity, paresdUp,parsedDoun);
  }



}
