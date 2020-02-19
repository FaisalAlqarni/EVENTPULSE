import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      child: Card(
        margin: EdgeInsets.only(left: 2, right: 0, bottom: 27),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.network(
                assetName,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height*0.5,
                alignment: Alignment(0.5, 0),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: 0.5,
              ),
            ),
          ],
        ),
      ), offset: const Offset(0.0,15.0),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),

        ],
      ),
    );
  }
}