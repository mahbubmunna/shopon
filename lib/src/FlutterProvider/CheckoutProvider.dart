import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/CheckoutModel.dart';
import 'package:sunbulahome/src/models/Delivery.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:http/http.dart' as http;

class CheckoutProvider extends ChangeNotifier {
  //controller_address.value.text,controller_country.value.text,controller_city.value.text,controller_postal_code.value.text,controller_phone.value.text,controller_name.value.text,controller_email.value.text

  Future<CheckoutModel> delivery_checkout(Delivery delivery) async {
    CheckoutModel checkoutModel;

    var token = await SharedPrefProvider.getString(token_key);

    print("The tokennn is   ${token}");

    Map<String, String> header = {
      "Content-Type": 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    print(json.encode(delivery));

    await http
        .post("${api_base_url}checkout",
            headers: header, body: json.encode(delivery))
        .then((value) {
      print("The Che ${value.body}");

      checkoutModel = CheckoutModel.fromJson(json.decode(value.body));
      // conversations = Conversations.fromJson(json.decode(value.body));
    });

    return checkoutModel;
  }
}
