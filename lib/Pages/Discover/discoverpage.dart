import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';
import 'package:EventPulse/Pages/Categoory.dart';
import 'package:EventPulse/Pages/Discover/sliding_cards.dart';
import 'dart:convert';
import 'package:EventPulse/Pages/API.dart';
import 'package:EventPulse/Pages/event.dart';
import 'package:EventPulse/Pages/event_details.dart';
import 'package:intl/intl.dart';

import '../event_coordinator.dart';

class NewDiscover extends StatefulWidget {
  const NewDiscover({Key key}) : super(key: key);
  @override
  _NewDiscoverState createState() => _NewDiscoverState();
}

/// search classes
class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.eventss);
  final Event eventss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: new NetworkImage(eventss.image),
          ),
          Text(
            '  ' + eventss.name,
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x4437474F),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: Icon(Icons.search),
        border: InputBorder.none,
        hintText: "Search here...",
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 20,
          top: 14,
          bottom: 14,
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class _NewDiscoverState extends State<NewDiscover>
    with AutomaticKeepAliveClientMixin<NewDiscover> {
  final TextEditingController _searchControl = new TextEditingController();
  static EventCoordinator eventCoordinator = new EventCoordinator();
  var eventss = new List<Event>();
  var categ = new List<Categoory>();
  Event x;
/*   _getEvents() {
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
  } */

  _injectData() async {
    await eventCoordinator.downloadEvents();
    await eventCoordinator.downloadCategoories();
    if (mounted) {
      setState(() {
        eventss = eventCoordinator.returnEvents();
        categ = eventCoordinator.returnCategoories();
      });
    }
  }

  initState() {
    super.initState();
    _injectData();
    //_getEvents();
    //_getCategoories();
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
              child: Column(
                children: <Widget>[
                  SearchWidget<Event>(
                    dataList: eventss,
                    hideSearchBoxWhenItemSelected: false,
                    listContainerHeight: MediaQuery.of(context).size.height / 2,
                    queryBuilder: (query, eventss) {
                      return eventss
                          .where((eventss) => eventss.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                    popupListItemBuilder: (eventss) {
                      return PopupListItemWidget(eventss);
                    },
                    selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                      //return SelectedItemWidget(selectedItem, deleteSelectedItem);
                    },
                    // widget customization
                    //noItemsFoundWidget: NoItemsFound(),
                    textFieldBuilder: (controller, focusNode) {
                      return MyTextField(controller, focusNode);
                    },
                    onItemSelected: (item) {
                      setState(
                        () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return new EventDetails(rootEvent: item);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          62.0,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
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
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),

                //Horizontal List here
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: PageView.builder(
                    //primary: false,
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemCount: categ[indexOfCategories].events == null
                        ? 0
                        : categ[indexOfCategories].events.length,
                    itemBuilder: (BuildContext context, int indexOfEvents) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Stack(
                            children: <Widget>[
                              InkWell(
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
                                              return new EventDetails(
                                                  rootEvent: x);
                                            },
                                          ),
                                        )
                                      },
                                  child: SlidingCard(
                                    assetName: categ[indexOfCategories]
                                        .events[indexOfEvents]
                                        .image,
                                    date: DateFormat.yMMMMd("en_US").format(
                                        DateTime.parse(categ[indexOfCategories]
                                            .events[indexOfEvents]
                                            .start_date)),
                                    name: categ[indexOfCategories]
                                        .events[indexOfEvents]
                                        .name,
                                  )
                                  /*Card(
                                  semanticContainer: true,
                                 clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius:BorderRadius.all(
                                    Radius.circular(20)
                                  ) ),
                                  elevation: 15.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Image.network(
                                          categ[indexOfCategories]
                                              .events[indexOfEvents]
                                              .image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          fit: BoxFit.fill,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10000,
                                          child: new InkWell(
                                            onTap: () => {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    for (int i = 0;
                                                        i < eventss.length;
                                                        i++) {
                                                      if (eventss[i].id ==
                                                          categ[indexOfCategories]
                                                              .events[
                                                                  indexOfEvents]
                                                              .id) {
                                                        x = eventss[i];
                                                      }
                                                    }
                                                    return new EventDetails(
                                                        rootEvent: x);
                                                  },
                                                ),
                                              )
                                            },
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3000,
                                            padding: EdgeInsets.all(1),
                                            constraints: BoxConstraints(
                                              minWidth: 0,
                                              minHeight: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),*/
                                  ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0),
/*                 new Divider(
                  thickness: 1,
                  color: Colors.white,
                  indent: 20,
                  endIndent: 20,
                ), */
              ]);
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
