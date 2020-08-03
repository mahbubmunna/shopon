import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Profile.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';

class ProfileProvider extends ChangeNotifier {
  var TAG = "Profile";

  Profile _profile;

  Profile get profile => _profile;

  ProfileProvider() {
    print("$TAG  trying to update");

    getProfile().then((value) {
      _profile = value;

      notifyListeners();
    });
  }

  Future<Profile> getProfile() async {
    Profile data;

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {"Authorization": "Bearer $token"};

    await http.get("${api_base_url}user", headers: header).then((value) {
      print("Profile  ${value.body}");
      if (value.statusCode == 200) {
        data = Profile.fromJson(json.decode(value.body));
      } else {
        print("Error Profile");
      }
    });

    return data;
  }
}
