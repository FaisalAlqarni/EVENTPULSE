import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Profile/header/diagonally_cut_colored_image.dart';
import 'package:senior_project/Pages/user_instance.dart';

class UserDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'https://www.oliverwyman.com/content/dam/oliver-wyman/v2/events/2019/October/ecn1.png.imgix.banner.png';

UserInstance user = UserInstance();

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.network(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 230.0,
        fit: BoxFit.cover,
      ),
      color: Colors.transparent,
    );
  }

  Widget _buildAvatar() {
     UserInstance().avatar = 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png';
    return new Hero(
      tag: UserInstance().avatar ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
      child: new CircleAvatar(
        backgroundImage: new NetworkImage(UserInstance().avatar) ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
        radius: 50.0,
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('90 Following', style: followerStyle),
          new Text(
            ' | ',
            style: followerStyle.copyWith(
                fontSize: 24.0, fontWeight: FontWeight.normal),
          ),
          new Text('100 Followers', style: followerStyle),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _createPillButton(
            'WHO I FOLLOW',
            backgroundColor: theme.accentColor,
          ),
          new DecoratedBox(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white30),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: _createPillButton(
              'FOLLOW ME',
              textColor: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createPillButton(
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white,
  }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: new Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.1,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
              _buildActionButtons(theme),
            ],
          ),
        ),
/*         new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ), */
      ],
    );
  }
}
