import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/RelatedProduct.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:http/http.dart' as http;

class RelatedProductProvider {
  ///Map<String, String> header = {"Authorization": "Bearer ${CommonUtils.token}"};

  Future<List<Product>> getRelatedProduct(id) async {
    List<Product> _product_list = new List();

    //notifyListeners();

    await http
        .get("http://157.175.91.49/api/related_products/${id}")
        .then((data) {
      if (data.statusCode == 200) {
        print(" Related Data   ${data.body}");

        var v = json.decode(data.body);

        List value = v["results"];

        print("Related Value   ${value}");

        for (int i = 0; i < value.length; i++) {
          print("Related  Photos  is  ${value[i]["photos"]}");

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
                arName: value[i]["ar_name"],
                name: Intl.getCurrentLocale() == 'en' ? value[i]["name"] : value[i]["ar_name"],
                icon: value[i]["icon"],
                id: value[i]["id"].toString()),
          );
        }

        // relatedProduct = order;

      } else {
        print("error");
      }
    });

    return _product_list;
    ;
  }
}
