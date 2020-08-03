class Profile {
  bool success;
  Results results;
  String message;

  Profile({this.success, this.results, this.message});

  Profile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Results {
  String name;
  String email;
  Null profilePic;
  String gender;
  String dob;

  Results({this.name, this.email, this.profilePic, this.gender, this.dob});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.profilePic;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    return data;
  }
}
