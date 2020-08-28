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
  String area;
  String address;
  String phone;
  String city;
  String country;
  String error;
  UserState userState;
  String postalCode;

  User.init();

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'].toString(),
        name = json["name"],
        gender = 'Male',
        address = json['address'] != null ? json['address'] : '',
        area = json['city'] != null ? json['city'] : '',
        country = json['country'] != null ? json['country'] : '',
        phone = json['phone'] != null ? json['phone'] : '',
        dateOfBirth = DateTime(1993, 12, 31),
        avatar = "https://picsum.photos/200",
        postalCode = json['postal_code'] != null ? json['postal_code'] : '';

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['address'] = address;
    map['city'] = area;
    map['country'] = city;
    map['postal_code'] = postalCode;

    return map;
  }


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
