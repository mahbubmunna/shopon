import 'package:intl/intl.dart' show DateFormat;

enum UserState { available, away, busy }

class UserResponse {
  User user;
  String error;

  UserResponse.fromJson(Map<String, dynamic> json)
    : user = User.fromJson(json['results']),
  error = "";

  UserResponse.withError(String errorValue)
    : user = User.init(),
  error = errorValue;
}

class User {
  String id;
  String name;
  String email;
  String gender;
  DateTime dateOfBirth;
  String avatar;
  String address;
  String city;
  String country;
  String error;
  UserState userState;

  User.init();

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'].toString(),
        name = json["name"],
        gender = 'Male',
        address = json['address'] != null ? json['address'] : '',
        city = json['city'] != null ? json['city'] : '',
        country = json['country'] != null ? json['country'] : '',
        dateOfBirth = DateTime(1993, 12, 31),
        avatar = "https://picsum.photos/200";


  User.basic(this.name, this.avatar, this.userState);

  User.advanced(this.name, this.email, this.gender, this.dateOfBirth, this.avatar, this.address, this.userState);

  User getCurrentUser() {
    return User.advanced('Andrew R. Whitesides', 'andrew@gmail.com', 'Male', DateTime(1993, 12, 31), 'assets/img/user2.jpg',
        '4600 Isaacs Creek Road Golden, IL 62339', UserState.available);
  }

  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
  }
}
