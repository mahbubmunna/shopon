import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:smartcommercebd/src/configs/strings.dart';

import 'package:smartcommercebd/src/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/models/product.dart';

class FlashProvider extends ChangeNotifier {
  List<Product> _flash_list = new List();

  List<Product> get flash_list => _flash_list;

  FlashProvider(pageNumber) {
    getFlash(pageNumber).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          print("Flash   ${value[i]["name"]}");

          _flash_list.add(Product.formJson(null, value[i]));

          notifyListeners();
        }
      } else {
        print("Error ");
      }
    });
  }

  Future<List<dynamic>> getFlash(pageNumber) async {
    print("getBrand ");

    var data;

    await http
        .get("${api_base_url}flash_sales?page=${pageNumber}")
        .then((response) {
      if (response.statusCode == 200) {
        print("Flash  Response  ${response.body}");

        var formated = json.decode(response.body);
        data = formated["results"]["data"];
      }
    });

    return data;
  }

  Pageination(pageNumber) {
    getFlash(pageNumber).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          print("Flash  ${value[i]["name"]}");

          _flash_list.add(Product.formJson(null, value[i]));

          notifyListeners();
        }
      } else {
        print("Flash Error ");
      }
    });
  }
}
