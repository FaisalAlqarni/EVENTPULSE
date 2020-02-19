import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/user_others.dart';

class UserDetailBodyOthers extends StatelessWidget {
    final UserOthers rootUser;
  const UserDetailBodyOthers({Key key, this.rootUser}) : super(key: key);

  Widget _buildLocationInfo(TextTheme textTheme, BuildContext context) {
    return new Row(
      children: <Widget>[
        new Icon(
          Icons.email,
          color: Theme.of(context).primaryColorDark,
          size: 16.0,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(
            rootUser.email ?? 'loading!',
            style: textTheme.subhead.copyWith(color: Theme.of(context).primaryColorDark),
          ),
        ),
      ],
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color, BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: new Icon(
          iconData,
          color: Theme.of(context).primaryColorDark,
          size: 16.0,
        ),
        radius: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          rootUser.name ?? 'loading!',
          style: textTheme.headline.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme, context),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            'hi there.',
            style:
                textTheme.body1.copyWith(color: Theme.of(context).primaryColorDark, fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
