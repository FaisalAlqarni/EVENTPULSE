import 'dart:async';
import 'dart:convert';
import 'package:EventPulse/Pages/Categoory.dart';
import 'package:EventPulse/Pages/Navigation/navigation_controler.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/event_coordinator.dart';
import 'package:EventPulse/Pages/event_details.dart';
import 'package:EventPulse/Pages/user_instance.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../topBar.dart';
import 'dart:core';

import 'API.dart';
import 'check-in_details_page.dart';

class CheckInPage extends StatefulWidget {
  @override
  const CheckInPage({Key key}) : super(key: key);
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckInPage> {
  GoogleMapController myMapController;
  static EventCoordinator eventCoordinator = new EventCoordinator();
  static var events = new List<Event>();
  var categ = new List<Categoory>();
  final Set<Marker> _markers = new Set();
  static LatLng _mainLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _desc = new TextEditingController();

  Future check(int userId, int eventId) async {
    await API.checkinNOW(userId.toString(), eventId.toString());

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => NavigationBarController()));
  }

  void _showDialog(Text ttl, Text cntnt) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: ttl,
          titleTextStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          contentTextStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
              fontSize: 20),
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

  Widget _button(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, int eventId) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        if (UserInstance().token == null) {
          _showDialog(Text('NOT SIGNED IN'), Text('Please sign-in first'));
        } else {
          check(UserInstance().id, eventId);
        }
      },
    );
  }

  Widget _inputMeat(
      Icon icon, String hint, TextEditingController controller, bool obsecure) {
    return Container(
      margin: EdgeInsets.all(12),
      height: 5 * 40.0,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 100,
        controller: controller,
        obscureText: obsecure,
        style:
            TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark),
        decoration: InputDecoration(
            //filled: true,
            //contentPadding: const EdgeInsets.symmetric(vertical: 100.0),
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColorDark,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColorDark,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColorDark),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }

  void createReviewSheet(int eventId) {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _desc.clear();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30.0,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      )
                    ],
                  ),
                  height: 50,
                  width: 50,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 00),
                        child: _inputMeat(Icon(Icons.description),
                            "Description", _desc, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: _button(
                              "Submit",
                              Colors.white,
                              Theme.of(context).primaryColorDark,
                              Theme.of(context).primaryColorDark,
                              Colors.white,
                              eventId),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  _getCheckableEvents() async {
    API.getCheckableEvents().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        events = list.map((model) => Event.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getCheckableEvents();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: _scaffoldKey,
            appBar: TopBar(height: 60, pageTitle: 'Check in'),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(24.774265, 46.738586),
                      zoom: 10.0,
                    ),
                    markers: this.myMarker(),
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      setState(() {
                        myMapController = controller;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                if (UserInstance().token == null) {
                                  _showDialog(Text('NOT SIGNED IN'),
                                      Text('Please sign-in first'));
                                } else {
                                  check(UserInstance().id, events[index].id);
                                }

/*                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (c) {
                            return new CheckInDetails(rootEventid: events[index].id);
                          },
                        ),
                      ); */
                              },
                              isThreeLine: true,
                              //leading: Text('THIS IS THE TITLE\n', style: TextStyle(fontSize: 15),),
                              title: Text(
                                events[index].name,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[],
                              ),

                              // subtitle: ,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ],
            )));
  }

  Set<Marker> myMarker() {
    setState(() {
      for (int i = 0; i < events.length; i++) {
        double lat = double.parse(events[i].latitude);
        double long = double.parse(events[i].longitude);
        _mainLocation = LatLng(lat, long);
        _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_mainLocation.toString()),
            position: _mainLocation,
            infoWindow: InfoWindow(
              title: events[i].description,
              snippet: events[i].interest_count.toString() +
                  ' are interested on this event',
            ),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new EventDetails(rootEvent: events[i]);
                  },
                ),
              );
            }));
      }
    });

    return _markers;
  }
}
