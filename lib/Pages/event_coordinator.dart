import 'dart:convert';
import 'API.dart';
import 'Categoory.dart';
import 'event.dart';

class EventCoordinator {
  static final EventCoordinator _instance = EventCoordinator._internal();

  var events = new List<Event>();
  var categories = new List<Categoory>();

  factory EventCoordinator() {
    return _instance;
  }
  EventCoordinator._internal();

  downloadEvents() async {
    await API.getEvent().then((response) {
      Iterable list = json.decode(response.body);
      _instance.events = list.map((model) => Event.fromJson(model)).toList();
    });
  }

   downloadCategoories() async {
    await API.getCategory().then((response) {
     
        Iterable list = json.decode(response.body);
        _instance.categories = list.map((model) => Categoory.fromJson(model)).toList();
    });
  }

  List<Event> returnEvents() {
    return _instance.events;
  }

  List<Categoory> returnCategoories() {
    return _instance.categories;
  }
}
