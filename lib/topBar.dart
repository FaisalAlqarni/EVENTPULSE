import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{
 final double height;
 final String pageTitle;

  const TopBar({
    Key key,
    @required this.height,
    @required this.pageTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(0),
            child: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          pageTitle,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
          ),
        ),
      ],
    );
  }
  
 @override
  Size get preferredSize => Size.fromHeight(height);
}