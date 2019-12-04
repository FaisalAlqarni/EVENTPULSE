import 'package:senior_project/pages/event.dart';
class Categoory{
  int id;
  String name;
  List<Event> events;




  Categoory(
    this.id,
    this.name,
    this.events,

  );

  Categoory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        events = json['events'];


  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'events': events,

      };


}