import 'dart:convert';

import 'package:EventPulse/Pages/Reviews/ReviewView.dart';
import 'package:EventPulse/Pages/Users_List_Page.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Reviews/ReviewList.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:EventPulse/topBar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'API.dart';

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
  Icon _infoIcon = Icon(Icons.info_outline);

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
        var isBookmarked = parsedJson["Bookmarked"];
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
      iconSize: 20,
      color: Theme.of(context).primaryColorDark,
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

  Widget whosIntrestedButton(context, widget , int userID , int eventID) {
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

  Widget bookmarkButton(context, widget) {
    return IconButton(
      iconSize: 20,
      color: Theme.of(context).primaryColorDark,
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
    return Container();
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


    _setWhosInterestedButton(context, widget  , int userID , int eventID) {
    if (UserInstance().token == null) {
      return nilChild();
    } else {
      return whosIntrestedButton(context, widget  ,userID ,  eventID);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (UserInstance().token != null) {
      print(
          '///////////////////////////////////////////////////88888888888888888888');
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
              children: <Widget>[
                const SizedBox(height: 250),
                Row(children: <Widget>[
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
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6, top: 4),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            child: Icon(
                              Icons.insert_comment,
                              color: Theme.of(context).primaryColorDark,
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
                    ),
                  ),
                ]),
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
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Row(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
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
                                          _setLikeButton(context, widget),
                                          _setBookmarkButton(context, widget),
                                          _setWhosInterestedButton(context, widget , UserInstance().id , widget.rootEvent.id)
                                        ],
                                      ))),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Theme.of(context).primaryColorDark,
                                    textColor: Colors.white,
                                    child: Text(
                                      "Guest Ticket",
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
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    color: Theme.of(context).primaryColorDark,
                                    textColor: Colors.white,
                                    child: Text(
                                      "Volunteer Ticket",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16.0,
                                    ),
                                    onPressed: () {
                                      _launchURL(
                                          widget.rootEvent.volunteer_url);
                                    },
                                  ),
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
                          const SizedBox(height: 30.0),
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
