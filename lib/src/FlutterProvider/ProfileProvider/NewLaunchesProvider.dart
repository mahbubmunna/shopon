import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/BestSell.dart';

import 'package:smartcommercebd/src/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/models/product.dart';

class NewLaunches {
  Future<List<Product>> getNewLaunches() async {
    List<Product> _product_list = new List();

    await http.get("http://157.175.91.49/api/product/new-launch").then((data) {
      print(" New Launch Body   ${data.body}");

      if (data.statusCode == 200) {
        var v = json.decode(data.body);

        List value = v["results"];

        for (int i = 0; i < value.length; i++) {
          print("Photos  is  ${value[i]["photos"]}");

          _product_list.add(
            Product(

                photos: value[i]["photos"],
                price: value[i]["unit_price"],
                meta_description: value[i]["meta_description"],
                description: value[i]["description"],
                quantity: value[i]["quantity"],
                rate: value[i]["rating"],
                image: value[i]["image"],
                available: value[i]["available"],
                sales: value[i]["num_of_sale"],
                discount: value[i]["discount"],
                thumbnail_img: value[i]["thumbnail_img"],
                colors: value[i]["colors"],
                variations: value[i]["variations"],
                name: value[i]["name"],
                icon: value[i]["icon"],
                id: value[i]["id"].toString()),

          );
        }

        // return
      }
    });

    return _product_list;
  }
}
