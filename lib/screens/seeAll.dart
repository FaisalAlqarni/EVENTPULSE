import 'package:flutter/material.dart';

class Catagory1 extends StatefulWidget {
  @override
  _Catagory1State createState() => _Catagory1State();
}

class _Catagory1State extends State<Catagory1> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("catagory1 Restaurants"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[


            SizedBox(height: 10.0),

            ListView.builder(

              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {

              },

            ),

            SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}
