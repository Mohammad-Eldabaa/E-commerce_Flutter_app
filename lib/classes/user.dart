class UserLogin {
  // this code to make the class Singleton.
  static final UserLogin _instance = UserLogin._internal();
  UserLogin._internal();
  factory UserLogin() => _instance;

  String _email = '';
  String _password = '';

  set setEmail(String newEmail) {
    _email = newEmail;
  }

  set setPassword(String newPassword) {
    _password = newPassword;
  }

  String get getPassword => _password;
  String get getEmail => _email;
}

/// Singleton class to contain Register data......................................................................

class UserRegister {
  static final UserRegister _instance = UserRegister._internal();
  UserRegister._internal();
  factory UserRegister() => _instance;

  int _id = 0;
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _address = '';
  String _email = '';
  String _password = '';

  // Setters
  set id(int value) => _id = value;
  set firstName(String value) => _firstName = value;
  set lastName(String value) => _lastName = value;
  set phone(String value) => _phone = value;
  set address(String value) => _address = value;
  set email(String value) => _email = value;
  set password(String value) => _password = value;

  // Getters
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get address => _address;
  String get email => _email;
  String get password => _password;

  // Method to initialize from JSON
  void fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phone = json['phone'];
    _address = json['address'];
    _email = json['email'];
    _password = json['created_at'];
  }

  void clear() {
    _id = 0;
    _firstName = '';
    _lastName = '';
    _phone = '';
    _address = '';
    _email = '';
    _password = '';
  }
}

/// Singleton class to contain user data......................................................................
class UserData {
  Map<String, dynamic> _userData = {};

  static final UserData _instance = UserData._internal();
  UserData._internal();
  factory UserData() => _instance;

  set setUserData(Map<String, dynamic> newUserData) {
    _userData = newUserData;
  }

  Map<String, dynamic> get getUserData => _userData;

  String name() => _userData["first_name"];
  get phone => _userData["phone"];
  get address => _userData["address"];
  get email => _userData["email"];
}
