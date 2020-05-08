import 'dart:convert';

import 'package:EventPulse/Pages/ActivityItem.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/topBar.dart';
import '../../event_details.dart';
import '../API.dart';
import '../Check-In_page.dart';
import '../ProfileOthers/user_details_page.dart';
import '../Reviews/ReviewView.dart';
import '../user_instance.dart';

//no need to modify this
class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//the home page state, it has all the configration for UI
class _MyHomePageState extends State<TimelinePage> {
  var activities = List<ActivityFactory>();
  get rating => 4.0;
  static Color normal = Color(0xff486581);
  static Color g = Colors.green[300];
  static Color r = Colors.redAccent;
  static Color oldG = normal;
  static Color oldR = normal;
  bool upclicked = false;
  bool downclicked = false;

  _getTimeline() async {
    API.getTimeline(UserInstance().id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        activities =
            list.map((model) => ActivityFactory.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getTimeline();
  }

  dispose() {
    super.dispose();
  }

  _ifClickable(context, widget, ActivityFactory doodle) {
    if (doodle.type.compareTo('review') == 0) {
      return reviewCard(doodle);
    } else if (doodle.type.compareTo('event_checkin') == 0) {
      return checkinCard(doodle);
    } else {
      return nonReviewCard(doodle);
    }
  }

  void _openCheckInPage() async {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new CheckInPage();
        },
      ),
    );
  }

  Widget reviewCard(ActivityFactory doodle) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (c) {
              return new ReviewView(rootReview: doodle.activity_object);
            },
          ),
        );
      },
      child: Text(doodle.activity_object.motherMethod(),
          overflow: TextOverflow.clip,
          maxLines: 3,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColorDark,
          )),
    );
  }

  Widget checkinCard(ActivityFactory doodle) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (c) {
              return new EventDetails(rootEvent: doodle.activity_object);
            },
          ),
        );
      },
      child: Text(doodle.activity_object.motherMethod(),
          overflow: TextOverflow.clip,
          maxLines: 3,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColorDark,
          )),
    );
  }

  Widget nonReviewCard(ActivityFactory doodle) {
    return Text(doodle.activity_object.motherMethod(),
        overflow: TextOverflow.clip,
        maxLines: 3,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColorDark,
        ));
  }

  _publishTimeline(context, widget) {
    if (UserInstance().id == null) {
      return nilTimeline();
    } else if (activities.length > 0) {
      return gtgTimeline();
    } else {
      return emptyTimeline();
    }
  }

  Widget nilTimeline() {
    return Column(
      children: <Widget>[
        Text(
          '\n',
          style: TextStyle(fontSize: 2),
        ),
        Divider(
          color: Theme.of(context).primaryColorDark,
          thickness: 2,
        ),
        Text(
          'NOTHING TO SEE',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Theme.of(context).primaryColorDark,
          thickness: 2,
        ),
        Text(
          '\n',
          style: TextStyle(fontSize: 2),
        ),
        Text(
          '\nYOU ARE NOT LOGGEDIN!\nPLEASE LOGIN FIRST TO SEE YOUR TIMELINE'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  
  }

  Widget emptyTimeline() {
    return Column(
      children: <Widget>[
        Text(
          '\n',
          style: TextStyle(fontSize: 2),
        ),
        Divider(
          color: Theme.of(context).primaryColorDark,
          thickness: 2,
        ),
        Text(
          'NOTHING TO SEE',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Theme.of(context).primaryColorDark,
          thickness: 2,
        ),
        Text(
          '\n',
          style: TextStyle(fontSize: 2),
        ),
        Text(
          '\nTHERE ARE NOTHING \nIN THE TIMELINE YET!'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget gtgTimeline() {
   return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (c) {
                      return new ProfilePageOthers(
                          rootUserid: activities[index].creator.id);
                    },
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    activities[index].creator.avatar.toString()),
              ),
            ),
            title: Text(
              activities[index].creator.name,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _ifClickable(context, widget, activities[index]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 22.0,
                      icon: Icon(
                        Icons.thumb_up,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          if (activities[index].downclicked) {
                            activities[index].upvote_count =
                                activities[index].upvote_count + 1;
                            activities[index].downvote_count =
                                activities[index].downvote_count - 1;
                            API.postDownVote(
                                UserInstance().id, activities[index].id);
                            API.postUpVote(
                                UserInstance().id, activities[index].id);
                            activities[index].downclicked = false;
                            activities[index].upclicked = true;
                          }

                          if (activities[index].upclicked) {
                            activities[index].upclicked = false;
                            activities[index].upvote_count =
                                activities[index].upvote_count - 1;
                            API.postUpVote(
                                UserInstance().id, activities[index].id);
                          } else {
                            API.postUpVote(
                                UserInstance().id, activities[index].id);
                            activities[index].upclicked = true;
                            activities[index].upvote_count =
                                activities[index].upvote_count + 1;
                          }
                        });
                      },
                    ),
                    Text(
                      activities[index].upvote_count.toString(),
                    ),
                    Spacer(),
                    Text(
                      activities[index].downvote_count.toString(),
                    ),
                    IconButton(
                      color: Colors.red,
                      iconSize: 22.0,
                      icon: Icon(
                        Icons.thumb_down,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          if (activities[index].upclicked) {
                            activities[index].upvote_count =
                                activities[index].upvote_count - 1;
                            activities[index].downvote_count =
                                activities[index].downvote_count + 1;
                            API.postUpVote(
                                UserInstance().id, activities[index].id);
                            API.postDownVote(
                                UserInstance().id, activities[index].id);
                            activities[index].downclicked = true;
                            activities[index].upclicked = false;
                          }

                          if (activities[index].downclicked) {
                            API.postDownVote(
                                UserInstance().id, activities[index].id);
                            activities[index].downclicked = false;
                            activities[index].downvote_count =
                                activities[index].downvote_count - 1;
                          } else {
                            API.postDownVote(
                                UserInstance().id, activities[index].id);
                            activities[index].downclicked = true;
                            activities[index].downvote_count =
                                activities[index].downvote_count + 1;
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        height: 60,
        pageTitle: "Timeline",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCheckInPage,
        tooltip: 'Check in',
        child: Icon(Icons.location_on),
      ),
      backgroundColor: Colors.white,
      body: _publishTimeline(context, widget)
    );
  }
}
