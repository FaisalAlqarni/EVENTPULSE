
class UserOthers{
  int id;
  String name;
  String email;
  String avatar;

  UserOthers(
    this.id,
    this.name,
    this.avatar,
    this.email
  );

  UserOthers.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'avatar': avatar,
        'email': email,
      };


}