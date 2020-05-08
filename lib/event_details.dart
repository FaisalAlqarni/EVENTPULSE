import 'package:flutter/material.dart';
import 'Pages/event.dart';
// import 'package:senior_project/navigation_bar.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
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
                          onTap: () {},
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
                          child: Row(
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).primaryColorDark,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ],
      ),
    ));
  }
}

// class _HomeState extends State<EventDetails> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   get rating => 4.0;

//   @override
//   Widget build(BuildContext context) {
//     double s_width = MediaQuery.of(context).size.width;
//     Color primary = Theme.of(context).primaryColor;
//     void initState() {
//       super.initState();
//     }

//     //Image view
//     Widget event_banner() {
//       return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           children: <Widget>[
//             Image(
//               image: NetworkImage(
//                   widget.rootEvent.image),
//                   fit: BoxFit.cover,
//                   height: 250,
//             ),
//             Text(
//               widget.rootEvent.name,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Event organizer',
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.normal),
//             ),
//             SmoothStarRating(
//                 allowHalfRating: true,
//                 onRatingChanged: (v) {
//                   var rating = v;
//                   setState(() {});
//                 },
//                 starCount: 5,
//                 rating: rating,
//                 size: 20.0,
//                 color: Colors.deepPurple,
//                 borderColor: Colors.deepPurple,
//                 spacing: 0.0)
//           ],
//         ),
//       );
//     }

//     Widget event_description() {
//       return Container(
//         decoration: new BoxDecoration(
//             color: Colors.white,
//             borderRadius: new BorderRadius.only(
//                 topLeft: const Radius.circular(40.0),
//                 topRight: const Radius.circular(40.0),
//                 bottomLeft: const Radius.circular(40.0),
//                 bottomRight: const Radius.circular(40.0))),
//         padding: const EdgeInsets.all(16.0),
//         width: s_width,
//         child: new Column(
//           children: <Widget>[
//             new Text("Event description :", textAlign: TextAlign.center),
//             new Text(
//                 widget.rootEvent.description,
//                 textAlign: TextAlign.left),
//           ],
//         ),
//       );
//     }

//     Widget event_abouts() {
//       return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           children: <Widget>[
//             Text(
//               'from: ' + widget.rootEvent.start_date + "- TO: " + widget.rootEvent.end_date,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.normal),
//             ),
//             Text(
//               'longatitude: ' + widget.rootEvent.longitude.toString() + ' - latitude: ' + widget.rootEvent.latitude.toString(),
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontWeight: FontWeight.normal),
//             ),
//           ],
//         ),
//       );
//     }

//     Widget event_interactions() {
//       return Container(
//         child: new Row(
//             children: <Widget>[
//               Padding(
//                 child: Container(
//                   child: OutlineButton(
//                     highlightedBorderColor: Colors.white,
//                     borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     highlightElevation: 0.0,
//                     splashColor: Colors.white,
//                     highlightColor: Theme.of(context).primaryColor,
//                     color: Theme.of(context).primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     child: Text(
//                       "post review",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                           fontSize: 20),
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//                 padding: EdgeInsets.only(top: 10, right: 5, bottom: 10),
//               ),
//               Padding(
//                 child: Container(
//                   child: OutlineButton(
//                     highlightedBorderColor: Colors.yellow,
//                     borderSide: BorderSide(color: Colors.yellow, width: 2.0),
//                     highlightElevation: 0.0,
//                     splashColor: Colors.yellow,
//                     highlightColor: Colors.yellow,
//                     color: Colors.yellow,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     child: Text(
//                       "Mark intrested",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.yellow,
//                           fontSize: 20),
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//                 padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.center),
//       );
//     }

//     //main screen
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       key: _scaffoldKey,
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Event details",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         iconTheme: new IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             event_banner(),
//             Padding(
//               child: Container(
//                 child: event_description(),
//               ),
//               padding: EdgeInsets.only(top: 20, left: 20, right: 20),
//             ),
//             Padding(
//               child: Container(
//                 child: event_abouts(),
//               ),
//               padding: EdgeInsets.only(top: 20, left: 20, right: 20),
//             ),
//             Padding(
//               child: Container(
//                 child: OutlineButton(
//                   highlightedBorderColor: Colors.white,
//                   borderSide: BorderSide(color: Colors.white, width: 2.0),
//                   highlightElevation: 0.0,
//                   splashColor: Colors.white,
//                   highlightColor: Theme.of(context).primaryColor,
//                   color: Theme.of(context).primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(30.0),
//                   ),
//                   child: Text(
//                     "Event reviews",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20),
//                   ),
//                   onPressed: () {},
//                 ),
//                 height: 50,
//               ),
//               padding: EdgeInsets.only(top: 10, left: 20, right: 20),
//             ),
//             Padding(
//               child: Container(
//                 child: OutlineButton(
//                   highlightedBorderColor: Colors.white,
//                   borderSide: BorderSide(color: Colors.white, width: 2.0),
//                   highlightElevation: 0.0,
//                   splashColor: Colors.white,
//                   highlightColor: Theme.of(context).primaryColor,
//                   color: Theme.of(context).primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(30.0),
//                   ),
//                   child: Text(
//                     "Who is intrested?",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20),
//                   ),
//                   onPressed: () {},
//                 ),
//                 height: 50,
//               ),
//               padding:
//                   EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
//             ),
//             Divider(
//               color: Colors.white,
//               indent: 15,
//               endIndent: 15,
//               thickness: 2,
//             ),
//             Padding(
//               child: Container(
//                 child: event_interactions(),
//               ),
//               padding: EdgeInsets.only(bottom: 15),
//             ),
//           ],
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//         ),
//       ),
//       bottomNavigationBar: NavigationBar(currindx: 1)
//     );
//   }
// }
