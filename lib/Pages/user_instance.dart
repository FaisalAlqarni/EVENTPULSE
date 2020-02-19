import 'package:shared_preferences/shared_preferences.dart';

class UserInstance {
  static final UserInstance _instance = UserInstance._internal();

  int id;
  String name;
  String email;
  String token;
  String avatar;

  Future<SharedPreferences> _test = SharedPreferences.getInstance();

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
    killUser();
  }

  persistUser() async {
    SharedPreferences storedUser = await SharedPreferences.getInstance();

    storedUser.setInt('id', _instance.id);
    storedUser.setString('token', _instance.token);
    storedUser.setString('name', _instance.name);
    storedUser.setString('avatar', _instance.avatar);
    storedUser.setString('email', _instance.email);
    print("BECOME thot");
    print(storedUser.getString('email'));
  }

  assignUserFromDefaults() async {
    SharedPreferences storedUser = await SharedPreferences.getInstance();
    bool doesExsist = storedUser.containsKey('token');

    if (doesExsist) {
      _instance.id = storedUser.getInt('id');
      _instance.token = storedUser.getString('token');
      _instance.name = storedUser.getString('name');
      _instance.avatar = storedUser.getString('avatar');
      _instance.email = storedUser.getString('email');
    }
  }

  killUser() async {
    SharedPreferences storedUser = await SharedPreferences.getInstance();

    storedUser.remove('id');
    storedUser.remove('token');
    storedUser.remove('name');
    storedUser.remove('avatar');
    storedUser.remove('email');
  }
}
