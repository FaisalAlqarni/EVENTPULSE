import 'dart:convert';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:EventPulse/Pages/Users_List_Page.dart';
import 'package:EventPulse/Pages/whoIsCheckedin.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Reviews/ReviewList.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:EventPulse/topBar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'API.dart';
import 'event_tour.dart';

class EventDetails extends StatefulWidget {
  final Event rootEvent;

  const EventDetails({Key key, this.rootEvent}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EventDetails> {
  //Future<Event> event;

  // @override
  // void initState() {
  //   super.initState();
  //   event = getEvent();
  // }
  bool _favPressed = false;
  Icon _favIcon = Icon(Icons.favorite_border);
  bool _bookmarkPressed = false;
  Icon _bookmarkIcon = Icon(Icons.bookmark_border);
  Icon _infoIcon = Icon(Icons.remove_red_eye);

    void _showDialog(Text ttl, Text cntnt) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: ttl,
          titleTextStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 24),
          contentTextStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 20),
          content: cntnt,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _setFavIcon() async {
    await API
        .isIntrested(widget.rootEvent.id, UserInstance().id)
        .then((response) {
      setState(() {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        var isIntrested = parsedJson["intrested"];
        if (isIntrested) {
          _favIcon = Icon(Icons.favorite);
          _favPressed = isIntrested;
        } else {
          _favPressed = isIntrested;
        }
      });
    });
  }

  _setBookmarkIcon() async {
    await API
        .isBookmarked(widget.rootEvent.id, UserInstance().id)
        .then((response) {
      setState(() {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        var isBookmarked = parsedJson["bookmarked"];
        if (isBookmarked) {
          _bookmarkIcon = Icon(Icons.bookmark);
          _bookmarkPressed = isBookmarked;
        } else {
          _bookmarkPressed = isBookmarked;
        }
      });
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget likeButton(context, widget) {
    return IconButton(
      color: Theme.of(context).primaryColor,
      icon: _favIcon,
      onPressed: () {
        setState(() {
          if (_favPressed) {
            API.postInterest(context, widget.rootEvent.id, UserInstance().id);
            _favIcon = Icon(Icons.favorite_border);
            _favPressed = false;
            widget.rootEvent.interest_count -= 1;
          } else {
            _favIcon = Icon(Icons.favorite);
            _favPressed = true;
            API.postInterest(context, widget.rootEvent.id, UserInstance().id);
            widget.rootEvent.interest_count += 1;
            //remove interest here
          }
        });
      },
    );
  }

  Widget whosIntrestedButton(context, widget, int userID, int eventID) {
    return IconButton(
      iconSize: 20,
      color: Theme.of(context).primaryColorDark,
      icon: _infoIcon,
      onPressed: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (c) {
              return new Users_List(
                title: "whos interested",
                userid: userID,
                eventid: eventID,
              );
            },
          ),
        );
        //null;
      },
    );
  }

rateValue(){
  String rate;
  print(widget.rootEvent.rating);
/*   if( widget.rootEvent.rating == null){
    rate="0.000";
  }
  else{
    //rate= widget.rootEvent.rating;
  }
  print(rate); */
  return 2.5;
}

  Widget whosIsCheckedButton(context, widget, int userID, int eventID) {
    return InkWell(
      child: Text(
        'who checked-in',
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (c) {
              return new WhoIsChecked(
                title: "who is Checked-in",
                userid: userID,
                eventid: eventID,
              );
            },
          ),
        );
      },
    );
  }

  Widget bookmarkButton(context, widget) {
    print(widget.rootEvent.rating);
    return IconButton(
      color: Theme.of(context).primaryColor,
      icon: _bookmarkIcon,
      onPressed: () {
        setState(() {
          if (_bookmarkPressed) {
            API.postBookmark(context, widget.rootEvent.id, UserInstance().id);
            _bookmarkIcon = Icon(Icons.bookmark_border);
            _bookmarkPressed = false;
          } else {
            _bookmarkIcon = Icon(Icons.bookmark);
            _bookmarkPressed = true;
            API.postBookmark(context, widget.rootEvent.id, UserInstance().id);
            //remove interest here
          }
        });
      },
    );
  }

  Widget nilChild() {
    return Column(
      children: <Widget>[
        Text(
          '',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              ),
        ),
      ],
    );
  }

    Widget nilChildCheckin() {
    return InkWell(
      child: Text(
        'who checked-in',
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      onTap: () {
        _showDialog(Text('NOT SIGNED IN'), Text('Please sign-in first'));
      },
    );
  }

  _setLikeButton(context, widget) {
    if (UserInstance().token == null) {
      return nilChild();
    } else {
      return likeButton(context, widget);
    }
  }

  _setBookmarkButton(context, widget) {
    if (UserInstance().token == null) {
      return nilChild();
    } else {
      return bookmarkButton(context, widget);
    }
  }

  _setWhosInterestedButton(context, widget, int userID, int eventID) {
    if (UserInstance().token == null) {
      return nilChild();
    } else {
      return whosIntrestedButton(context, widget, userID, eventID);
    }
  }

  _setWhoIsCheckedInButton(context, widget, int userID, int eventID) {
    if (UserInstance().token == null) {
      return nilChildCheckin();
    } else {
      return whosIsCheckedButton(context, widget, userID, eventID);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (UserInstance().token != null) {
      _setFavIcon();
      _setBookmarkIcon();
    } else {
      _favPressed = false;
      _bookmarkPressed = false;
    }
  }

  //static final String path = "lib/Details.dart";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: TopBar(
        pageTitle: 'Event Details',
        height: 60,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.network(
                widget.rootEvent.image,
                fit: BoxFit.cover,
              )),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.rootEvent.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          child: Text(
                            "Reviews",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (c) {
                                  return new ReviewList(
                                    event_id: widget.rootEvent.id,
                                  );
                                },
                              ),
                            );
                          },
                        )),
                    //Spacer(),
                    Container(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 6, top: 4, left: 10),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: _setWhoIsCheckedInButton(context, widget,
                                UserInstance().id, widget.rootEvent.id)),
                      ),
                    ),
                    Spacer(),
                    _setLikeButton(context, widget),
                    _setBookmarkButton(context, widget),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                      color: Colors.grey,
                                      iconSize: 28.0,
                                      icon: Icon(
                                        Icons.location_on,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        _launchMapsUrl(
                                            double.parse(
                                                widget.rootEvent.longitude),
                                            double.parse(
                                                widget.rootEvent.latitude));
                                      },
                                    ),
                                    Text.rich(
                                      TextSpan(children: [
                                        WidgetSpan(
                                            child: Icon(
                                          Icons.navigate_next,
                                          size: 13.0,
                                          color: Colors.grey,
                                        )),
                                        TextSpan(text: "Riyadh")
                                      ]),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontSize: 14.0),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      child: Text(
                                        "${widget.rootEvent.interest_count} Interests",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontSize: 16.0),
                                      ),
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //   new MaterialPageRoute(
                                        //     builder: (c) {
                                        //       return new Users_List(
                                        //         title: "whos interested",
                                        //         userid: 1,
                                        //         eventid: 1,
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                        //null;
                                      },
                                    ),
                                    _setWhosInterestedButton(context, widget,
                                        UserInstance().id, widget.rootEvent.id)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Spacer(),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Theme.of(context).primaryColorDark,
                                    textColor: Colors.white,
                                    child: Text(
                                      "Ticket",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16.0,
                                    ),
                                    onPressed: () {
                                      // _launchMapsUrl(46.45, 26.45);
                                      _launchURL(widget.rootEvent.guest_url);
                                    },
                                  ),
                                  // const SizedBox(width: 20),
                                  Spacer(),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Theme.of(context).primaryColorDark,
                                    textColor: Colors.white,
                                    child: Text(
                                      "360 Tour",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16.0,
                                    ),
                                    onPressed: () {
                                     Navigator.of(context).push(
                                        new MaterialPageRoute(
                                          builder: (c) {
                                            return new EventTour(rootUrl: widget.rootEvent.panorama_url);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  Spacer()
                                  /*  Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      DateFormat.yMMMMd("en_US").format(
                                          DateTime.parse(
                                              widget.rootEvent.start_date)),
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      "3 days event",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ) */
                                ],
                              )),
                          const SizedBox(height: 15.0),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Rate".toUpperCase(),
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),

                                ],
                              )),
                              const SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.center,
                                      child: SmoothStarRating(
                                      allowHalfRating: false,
                                      onRatingChanged: (v) {
                                        // _rating = v;
                                        // setState(() {});
                       /*                  _launchURL(
                                            widget.rootEvent.volunteer_url); */
                                      },
                                      starCount: 5,
                                      rating: widget.rootEvent.rating,
                                      size: 40.0,
                                      color: Theme.of(context).primaryColorDark,
                                      borderColor:
                                          Theme.of(context).primaryColorDark,
                                      spacing: 0.0),
                              ),

                          const SizedBox(height: 10.0),
                          Text(
                            "Description".toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.rootEvent.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          /* Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ), */
        ],
      ),
    ));
  }
}
