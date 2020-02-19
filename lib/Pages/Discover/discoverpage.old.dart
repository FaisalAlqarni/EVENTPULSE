import 'dart:convert';

import 'package:search_widget/search_widget.dart';
import 'package:EventPulse/Pages/Categoory.dart';
import 'package:flutter/material.dart';
import 'package:EventPulse/Pages/API.dart';
import 'package:EventPulse/Pages/Discover/discoverpage.dart';
import 'package:EventPulse/Pages/MainLogin.dart';
import 'package:EventPulse/Pages/event.dart';
/* import 'package:EventPulse/Pages/event_details.dart';
import 'customIcons.dart'; */
import 'dart:math';

import 'package:EventPulse/Pages/event_details.dart';
import 'package:EventPulse/topBar.dart';

var images = new List<String>();
var name = new List<String>();
var start_date = new List<String>();
var end_date = new List<String>();
var events = new List<Event>();
class DiscoverPageNew extends StatefulWidget {
    const DiscoverPageNew({Key key}) : super(key: key);

  @override
  _DiscoverPageState createState() => new _DiscoverPageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _DiscoverPageState extends State<DiscoverPageNew> {
  
  var catg = new List<Categoory>();
  static int length;
  _getEvents() {
    API.getEvent().then((response) {
      setState(() {
      //  Iterable list = json.decode(response.body);
     //   events = list.map((model) => Event.fromJson(model)).toList();
      });
      length = events.length;
      images.length = length;
      name.length = length;
      start_date.length = length;
      end_date.length = length;
    });
  }

  initState() {
    super.initState();
    _getEvents();
  }

  dispose() {
    super.dispose();
  }

  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < events.length; i++) {
      print('----------------');
      print(events[i].name);
      images[i] = events[i].image;
      name[i] = events[i].name;
      start_date[i] = events[i].start_date;
      end_date[i] = events[i].end_date;
    }
    //print(events);
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        appBar: TopBar(pageTitle: '', height: 60,),
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SearchWidget<Event>(
                    dataList: events,
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
              //First catagory
              Padding(
                //The category title + option button ...
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Events",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: events.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {

                         Container();
                      },
                    ),
                  ),

                  /* IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.play_arrow),
                    color: Colors.black,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainLogin()),
                      )
                    },
                  ), */
                ],
              ),

              /* //The second catagory
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Family",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                      icon: Icon(
                        CustomIcons.option,
                        size: 12.0,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("9+ Events",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
*/
              /*Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 18.0, bottom: 18.0,),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/image_02.jpg",
                          width: 296.0, height: 222.0),
                    ),
                  )
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

//This class is for the animated cards of events.
class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < events.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: InkWell(
              onTap: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainLogin()),
                      )
                        },
              child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      
                        
                       Image.network(images[i], fit: BoxFit.cover),                  
                      
                      

                      //The title of each event card
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(name[i],
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      backgroundColor: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27.0,
                                      /* fontFamily: "SF-Pro-Text-Regular" */)),
                            ),

                            //Read Later Box
                            SizedBox(
                              height: 10.0,
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
           ), ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
