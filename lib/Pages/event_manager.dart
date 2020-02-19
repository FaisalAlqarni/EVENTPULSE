import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:EventPulse/clipper.dart';

import 'Discover/discoverpage.dart';

class EventManageRr extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Categories {
  int id;
  String name;

  Categories(this.id, this.name);

  static List<Categories> getCategories() {
    return <Categories>[
      Categories(1, 'Education'),
      Categories(2, 'Games'),
      Categories(3, 'Food'),
      Categories(4, 'Festival'),
      Categories(5, 'Family'),
    ];
  }
}

class _HomeState extends State<EventManageRr> {
  static final CREATE_EVENT_POST_URL =
      'http://event-discoverer-backend.herokuapp.com/api/events';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _eventNameController = new TextEditingController();
  TextEditingController _timeFromController = new TextEditingController();
  TextEditingController _timeToController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _loacationLatitudeController =
      new TextEditingController();
  TextEditingController _loacationLongitudeController =
      new TextEditingController();
  String _eventName;
  String _timeFrom;
  String _timeTo;
  String _description;
  String _loacationLatitude;
  String _loacationLongitude;
  bool _obsecure = false;

  List<Categories> _categories = Categories.getCategories();
  List<DropdownMenuItem<Categories>> _dropdownMenuItems;
  Categories _selectedCategory;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_categories);
    _selectedCategory = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Categories>> buildDropdownMenuItems(List categories) {
    List<DropdownMenuItem<Categories>> items = List();
    for (Categories category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.name),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    @override
    void initState() {
      super.initState();
    }

    onChangeDropdownItem(Categories selectedCategory) {
      setState(() {
        _selectedCategory = selectedCategory;
      });
    }

    //HI logo widget
    Widget logo() {
      return Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: 150,
                    height: 150,
                  ),
                ),
                height: 154,
              )),
              Positioned(
                child: Container(
                    height: 154,
                    child: Align(
                      child: Text(
                        "Hi",
                        style: TextStyle(
                          fontSize: 110,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                bottom: MediaQuery.of(context).size.height * 0.046,
                right: MediaQuery.of(context).size.width * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                bottom: 0,
                right: MediaQuery.of(context).size.width * 0.32,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    //input widget
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon,
                ),
                padding: EdgeInsets.only(left: 30, right: 10),
              )),
        ),
      );
    }

    Widget _inputDesc(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  height: 10.0, fontWeight: FontWeight.bold, fontSize: 20),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              prefixIcon: Padding(
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).primaryColor),
                  child: icon,
                ),
                padding: EdgeInsets.only(left: 30, right: 10),
              )),
        ),
      );
    }

    //button widget
    Widget _button(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void function()) {
      return RaisedButton(
        highlightElevation: 0.0,
        splashColor: splashColor,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
        onPressed: () {
          function();
        },
      );
    }

    //create functions: TO SEND IT TO BACKEND
    Future _createEvent() async {
      _eventName = _eventNameController.text;
      _timeFrom = _timeFromController.text;
      _timeTo = _timeToController.text;
      _description = _descriptionController.text;
      _loacationLatitude = _loacationLatitudeController.text;
      _loacationLongitude = _loacationLongitudeController.text;

      CreateEventAPI newPost = new CreateEventAPI(
          name: _eventName,
          description: _description,
          latitude: _loacationLatitude,
          longitude: _loacationLongitude,
          startDate: _timeFrom,
          endDate: _timeTo);
      CreateEventAPI p =
          await createEventPost(CREATE_EVENT_POST_URL, body: newPost.toMap());
      print(p.name);
      if (p.name == null) {
        print('INVALID INPUTS, TRY AGAIN');
      } else /*if(p.email.isNotEmpty)*/ {
        print('EVENT CREATED');
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => NewDiscover()));
      }

/*
      AlertDialog(
        title: new Text("Thank you"),
        content: new Text("event created successfully"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("GO TO HOME PAGE"),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
            },
          ),
        ],
      );
*/
      _eventNameController.clear();
      _timeFromController.clear();
      _timeToController.clear();
      _descriptionController.clear();
      _loacationLatitudeController.clear();
      _loacationLongitudeController.clear();
    }

    //too edit the event details functions **(no need for it now)**
    void _editEvent() {
      _eventName = _eventNameController.text;
      _timeFrom = _timeFromController.text;
      _timeTo = _timeToController.text;
      _description = _descriptionController.text;
      _loacationLatitude = _loacationLatitudeController.text;
      _loacationLongitude = _loacationLongitudeController.text;

      _eventNameController.clear();
      _timeFromController.clear();
      _timeToController.clear();
      _descriptionController.clear();
      _loacationLatitudeController.clear();
      _loacationLongitudeController.clear();
    }

    //create event form
    void _createSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
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
                              _eventNameController.clear();
                              _timeFromController.clear();
                              _timeToController.clear();
                              _descriptionController.clear();
                              _loacationLatitudeController.clear();
                              _loacationLongitudeController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                child: Align(
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/logo.png'),
                                        ),
                                        color: Theme.of(context).canvasColor),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 60),
                          child: _input(Icon(Icons.arrow_forward_ios),
                              "EVENT NAME", _eventNameController, false),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _input(Icon(Icons.calendar_today), "FROM",
                              _timeFromController, true),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _input(Icon(Icons.calendar_today), "TO",
                              _timeToController, true),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _inputDesc(Icon(Icons.description),
                              "DESCRIPTION", _descriptionController, true),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _input(
                              Icon(Icons.location_searching),
                              "LOCATION LATITUDE",
                              _loacationLatitudeController,
                              true),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: _input(
                              Icon(Icons.my_location),
                              "LOCATION LONGITUDE",
                              _loacationLongitudeController,
                              true),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //for the drop down list
                        Text(
                          "Select a categorty",
                          style: TextStyle(
                            height: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            child: Column(
                          children: <Widget>[
                            new DropdownButton(
                              style: new TextStyle(
                                height: 0,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              value: _selectedCategory,
                              items: _dropdownMenuItems,
                              onChanged: onChangeDropdownItem,
                            ),
                            new SizedBox(
                              height: 20.0,
                            ),
                          ],
                        )),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            child: _button("Create Event", Colors.white,
                                primary, primary, Colors.white, _createEvent),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        SizedBox(
                          height: 20,
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

    //edit event form ***(no need for it now)***
    void _editEventSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
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
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Align(
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo.png'),
                                      ),
                                      color: Theme.of(context).canvasColor),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //TEXTfields is from here

                      //to here

                      //the button
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: _button("EDIT", Colors.white, primary, primary,
                              Colors.white, _editEvent),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
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
    /************************************************************* */

    //main screen
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            logo(),
            Padding(
              child: Container(
                child: _button("CREATE AN EVENT", primary, Colors.white,
                    Colors.white, primary, _createSheet),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            ),
            Padding(
              child: Container(
                child: OutlineButton(
                  highlightedBorderColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  highlightElevation: 0.0,
                  splashColor: Colors.white,
                  highlightColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    "EDIT AN EVENT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  onPressed: () {},
                ),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            ),
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}

// SECTION BELOW IS FOR THE API calsses and methods
class CreateEventAPI {
  final String name;
  final String description;
  final String latitude;
  final String longitude;
  final String startDate;
  final String endDate;

  CreateEventAPI({
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
  });

  factory CreateEventAPI.fromJson(Map<String, dynamic> json) {
    return CreateEventAPI(
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["startDate"] = startDate;
    map["endDate"] = endDate;
    return map;
  }
}

Future<CreateEventAPI> createEventPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return CreateEventAPI.fromJson(json.decode(response.body));
  });
}
