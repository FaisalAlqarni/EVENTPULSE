import 'package:senior_project/pages/event.dart';

class Categoory {
  int id;
  String name;
  List<Event> events;

  Categoory({
    this.id,
    this.name,
    this.events,
  });
  
  factory Categoory.fromJson(Map<String, dynamic> json) {
  var list = json['events'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Event> eventsList = list.map((i) => Event.fromJson(i)).toList();

    return new Categoory(
      id: json['id'],
      name: json['name'],
      events: eventsList,
    );
  }
  
/*   Categoory.fromJson(Map<String, Object> json)
      : id = json['id'],
        name = json['name'];
        //events = json['events']; */

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'events': events,
      };
}
