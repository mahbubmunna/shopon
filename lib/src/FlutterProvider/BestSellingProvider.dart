import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/BestSell.dart';

import 'package:sunbulahome/src/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:sunbulahome/src/models/product.dart';

class BestSellProvider {
  Future<List<Product>> getBestSelling() async {
    List<Product> _product_list = new List();

    await http.get("http://157.175.91.49/api/product/best-selling").then((data) {
      print(" Best Sell Body   ${data.body}");

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
                available: value[i]["current_stock"],
                sales: value[i]["num_of_sale"],
                discount: value[i]["discount"],
                thumbnail_img: value[i]["thumbnail_img"],
                colors: value[i]["colors"],
                variations: value[i]["variations"],
                name: Intl.getCurrentLocale() == 'en' ? value[i]["name"] : value[i]["ar_name"],
                icon: value[i]["icon"],
                arName: value[i]["ar_name"],
                id: value[i]["id"].toString()),

          );
        }

        // return
      }
    });

    return _product_list;
  }
}
