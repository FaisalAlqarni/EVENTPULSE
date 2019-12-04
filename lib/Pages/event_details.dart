import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Reviews/ReviewList.dart';
import 'package:senior_project/Pages/event.dart';
import 'package:senior_project/topBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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

  //static final String path = "lib/Details.dart";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: TopBar(pageTitle: 'Event Details', height: 60,),
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
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          child: Text(
                            "8.4/85 reviews",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (c) {
                                  return new ReviewList(event_id: widget.rootEvent.id,);
                                },
                              ),
                            );
                          },
                        )),
                    Spacer(),
                    IconButton(
                      color: Colors.white,
                      icon: _favIcon,
                      onPressed: () {
                        setState(() {
                          if (_favPressed) {
                            _favIcon = Icon(Icons.favorite_border);
                            _favPressed = false;
                            //add interset here
                          } else {
                            _favIcon = Icon(Icons.favorite);
                            _favPressed = true;
                            //remove interest here
                          }
                        });
                      },
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
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
                                  icon: Icon(Icons.location_on),
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
                                    TextSpan(text: "Riyadh Boulevard")
                                  ]),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          Column(
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
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.purple,
                                textColor: Colors.white,
                                child: Text(
                                  "Register as Guest",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 32.0,
                                ),
                                onPressed: () {
                                  // _launchMapsUrl(46.45, 26.45);
                                  _launchURL("https://www.youtube.com/");
                                },
                              ),
                              const SizedBox(height: 20.0),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.purple,
                                textColor: Colors.white,
                                child: Text(
                                  "Volunteer",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 32.0,
                                ),
                                onPressed: () {
                                  _launchURL("https://www.google.com/");
                                },
                              ),
                            ],
                          )),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.rootEvent.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: NavigationBar(),
    ));
  }
}



