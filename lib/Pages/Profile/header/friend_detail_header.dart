import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/Profile/header/diagonally_cut_colored_image.dart';
import 'package:EventPulse/Pages/user_instance.dart';

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
      color:Theme.of(context).primaryColorDark,
    );
  }

  Widget _buildAvatar() {
    return new Hero(
      tag: UserInstance().avatar ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
      child: new CircleAvatar(
        backgroundImage: new NetworkImage('https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
        radius: 50.0,
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBf0f4f8));
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

  Widget _buildActionButtons(ThemeData theme,BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _createWhoIFollowButton(context,
            'WHO I FOLLOW',
            backgroundColor: theme.accentColor,
          ),
/*           new DecoratedBox(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.transparent),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: _createFollowMeButton(context,
              'FOLLOW ME',
              textColor: Theme.of(context).primaryColor,
            ),
          ), */
        ],
      ),
    );
  }
  
  Widget _createWhoIFollowButton(BuildContext context,
    String text, {
    Color backgroundColor = Colors.blueAccent,
    Color textColor = const Color(0xBBf0f4f8),
  }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: new Text(text),
      ),
    );
  }

    Widget _createFollowMeButton(BuildContext context,
    String text, {
    Color backgroundColor = Colors.blueAccent,
    Color textColor = const Color(0xBBf0f4f8),
  }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: Theme.of(context).primaryColor,
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
              _buildActionButtons(theme, context),
            ],
          ),
        ),

      ],
    );
  }
}
