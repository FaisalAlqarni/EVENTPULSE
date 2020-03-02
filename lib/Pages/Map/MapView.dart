import 'dart:async';
import 'package:EventPulse/Pages/Categoory.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/event_coordinator.dart';
import 'package:EventPulse/Pages/event_details.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../topBar.dart';
import 'dart:core';

class MapView extends StatefulWidget {
  @override
  const MapView({Key key}) : super(key: key);
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController myMapController;
  static EventCoordinator eventCoordinator = new EventCoordinator();
  static var eventss = new List<Event>();
  var categ = new List<Categoory>();
  final Set<Marker> _markers = new Set();
  static LatLng _mainLocation;

  _injectData() async {
    await eventCoordinator.downloadEvents();
    await eventCoordinator.downloadCategoories();
    if (mounted) {
      setState(() {
        eventss = eventCoordinator.returnEvents();
        categ = eventCoordinator.returnCategoories();
      });
    }
  }

  initState() {
    super.initState();
    _injectData();
    //_getEvents();
    //_getCategoories();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: TopBar(height: 60, pageTitle: 'Map View'),
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
              ],
            )));
  }

  Set<Marker> myMarker() {
    setState(() {
      for (int i = 0; i < eventss.length; i++) {
        double lat = double.parse(eventss[i].latitude);
        double long = double.parse(eventss[i].longitude);
        _mainLocation = LatLng(lat, long);
        _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_mainLocation.toString()),
            position: _mainLocation,
            infoWindow: InfoWindow(
              title: eventss[i].description,
              snippet: eventss[i].interest_count.toString() +
                  ' are interested on this event',
            ),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new EventDetails(
                      rootEvent: eventss[i]
                    );
                  },
                ),
              );
            }));
      }
    });

    return _markers;
  }
}
