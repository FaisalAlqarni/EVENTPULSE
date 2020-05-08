import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../topBar.dart';

class EventTour extends StatefulWidget {
  final String rootUrl;

  const EventTour({Key key, this.rootUrl}) : super(key: key);

  @override
  _EventTourState createState() => _EventTourState();
}

class _EventTourState extends State<EventTour> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

    _setPage(context, widget) {
    if (widget.rootUrl == null) {
      return emptyTour();
    } else {
      return tourView();
    }
  }

  Widget emptyTour() {
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
          '\nTHIS EVENT \nHAS NO TOUR!'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

    Widget tourView() {
    return  WebView(
        initialUrl: widget.rootUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(height: 60, pageTitle: "Event Tour",
        
      ),
      body:_setPage(context,widget),
    );
  }

}