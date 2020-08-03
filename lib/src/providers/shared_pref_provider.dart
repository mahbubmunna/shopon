import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Cart.dart';

class SharedPrefProvider {
  static setString(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value).then((value) {
      print("The value is  ${value}");
    });
  }

  static getString(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key);
  }

  static addCart(List<String> c) async {
    var sp = await SharedPreferences.getInstance();

    sp.setStringList(cart_list_key, c).then((value) {
      print(value);
    });
  }
}
