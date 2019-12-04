class UserInstance {
  static final UserInstance _instance = UserInstance._internal();

  int id;
  String name;
  String email;
  String token;
  String avatar;

  factory UserInstance() {
    return _instance;
  }

  UserInstance._internal();

  void setUserObject(int identification, String tkn, String avi, String nm,
      String eml, String psw) {
    _instance.token = tkn;
    _instance.avatar = avi;
    _instance.name = nm;
    _instance.email = eml;
    _instance.id = identification;
  }

  factory UserInstance.fromJson(Map<String, dynamic> json) {
    _instance.id = json['id'];
    _instance.name = json['name'];
    _instance.email = json['email'];
    _instance.token = json['authentication_token'];
    _instance.avatar = json['avatar'];

    return _instance;
  }

  void distroyUser() {
     _instance.token = null;
    _instance.avatar = null;
    _instance.name = null;
    _instance.email = null;
    _instance.id = null;
  }
}
