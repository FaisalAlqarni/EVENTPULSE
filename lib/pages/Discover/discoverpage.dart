import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:senior_project/Pages/event_details.dart';
import 'package:senior_project/navigation_bar.dart';
import 'package:senior_project/topBar.dart';
import 'package:senior_project/Pages/API.dart';
import 'package:senior_project/Pages/event.dart';

class DiscoverPage extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var events = new List<Event>();

  _getEvents() {
    API.getEvent().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        events = list.map((model) => Event.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getEvents();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: TopBar(pageTitle: "Event list", height: 60),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              events[index].name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (c) {
                    return new EventDetails(rootEvent: events[index]);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(currindx: 1),
    );
  }
}
