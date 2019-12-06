import 'package:flutter/material.dart';
import 'package:senior_project/Pages/Categoory.dart';
//import 'package:senior_project/screens/seeAll.dart';
import 'package:senior_project/navigation_bar.dart';
import 'dart:convert';
import 'package:senior_project/Pages/API.dart';
import 'package:senior_project/Pages/event.dart';
import 'package:senior_project/Pages/event_details.dart';

class NewDiscover extends StatefulWidget {
  const NewDiscover({Key key}) : super(key: key);
  @override
  _NewDiscoverState createState() => _NewDiscoverState();
}

class _NewDiscoverState extends State<NewDiscover>
    with AutomaticKeepAliveClientMixin<NewDiscover> {
  final TextEditingController _searchControl = new TextEditingController();
  var eventss = new List<Event>();
  var categ = new List<Categoory>();
  Event x;
  _getEvents() {
    API.getEvent().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        eventss = list.map((model) => Event.fromJson(model)).toList();
      });
    });
  }

  _getCategoories() {
    API.getCategory().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print('0000000000000000000000000000000000000000000');
        categ = list.map((model) => Categoory.fromJson(model)).toList();
        print(categ[0].events[0].name);
      });
    });
  }

  initState() {
    super.initState();
    _getEvents();
    _getCategoories();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar:
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          60.0,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categ == null ? 0 : categ.length,
            itemBuilder: (BuildContext context, int indexOfCategories) {
              return Column(children: <Widget>[
                SizedBox(height: 1.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      categ[indexOfCategories].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),

                //Horizontal List here
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categ[indexOfCategories].events == null
                        ? 0
                        : categ[indexOfCategories].events.length,
                    itemBuilder: (BuildContext context, int indexOfEvents) {
                      return Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),

                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                categ[indexOfCategories]
                                    .events[indexOfEvents]
                                    .image,
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.height / 4,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width / 2,
                                child: new InkWell(
                                  onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          for (int i = 0;
                                              i < eventss.length;
                                              i++) {
                                            if (eventss[i].id ==
                                                categ[indexOfCategories]
                                                    .events[indexOfEvents]
                                                    .id) {
                                              x = eventss[i];
                                            }
                                          }
                                          return new EventDetails(rootEvent: x);
                                        },
                                      ),
                                    )
                                  },
                                ),
                              ),
                              Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  width: MediaQuery.of(context).size.height / 6,
                                  padding: EdgeInsets.all(1),
                                  constraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                new Divider(
                  thickness: 1,
                  color: Colors.white,
                  indent: 20,
                  endIndent: 20,
                ),

                
              ]);
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
