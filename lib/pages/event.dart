import 'package:http/http.dart' as http;

class Event{
  int id;
  String name;
  String description;
  String start_date;
  String end_date;
  String image;
  String longitude;
  String latitude;

  Event(
    this.id,
    this.name,
    this.description,
    this.start_date,
    this.end_date,
    this.image,
    this.longitude,
    this.latitude
  );

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        start_date = json['start_date'],
        end_date = json['end_date'],
        image = json['image'],
        longitude = json['longitude'],
        latitude = json['latitude'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'description': description,
        'start_date': start_date,
        'end_date': end_date,
        'image': image,
        'longitude': longitude,
        'longitude': longitude,
      };


}