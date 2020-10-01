import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smartcommercebd/src/configs/strings.dart';

import 'package:smartcommercebd/src/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/models/product.dart';

class BrandsProvider extends ChangeNotifier {
  var _selectedBrandId;
  var _page;
  bool isError = false;

  bool get error => isError;

  get selectedBrandId => _selectedBrandId;

  List<Brand> _brands_list = new List();
  List<Product> _brands_product = new List();

  List<Brand> get brands_list => _brands_list;

  List<Product> get brands_product => _brands_product;

  get page => _page;

  BrandsProvider(pageNumber) {
    //initial

    _page = 1;
    if (pageNumber != null) {
      BrandsProductPageination(selectedBrandId);
      getBrands(pageNumber).then((value) {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            _brands_list.add(Brand(
                name: Intl.getCurrentLocale() == 'en' ? value[i]["name"] : value[i]["ar_name"],
                logo: value[i]["logo"],
                id: value[i]["id"].toString()));

            isError = false;
            notifyListeners();
          }

          //initial selected brands ..
          selecteBrand(brands_list[0].id);
        } else {
          print("Error ");

          isError = true;
          notifyListeners();

        }
      });
    }
  }

  Future<List<dynamic>> getBrands(pageNumber) async {
    print("getBrand ");

    var data;

    await http.get("${api_base_url}brands?page=${pageNumber}").then((response) {
      if (response.statusCode == 200) {
        print("Response  ${response.body}");

        var formated = json.decode(response.body);
        data = formated["results"]["data"];

        print("The data is ${data}");
      }
    });

    return data;
  }

  BarndsPageination(pageNumber) {
    getBrands(pageNumber).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          _brands_list.add(Brand(
              name: value[i]["name"],
              logo: value[i]["logo"],
              id: value[i]["id"].toString()));

          notifyListeners();
        }
      } else {
        print("Error ");
      }
    });
  }

  void selecteBrand(id) {
    _selectedBrandId = id;

    _brands_product.clear();
    BrandsProductPageination(1);

    notifyListeners();
  }

  setPage(pageNumber) {
    _page = _page + 1;

    notifyListeners();
  }

  BrandsProductPageination(page) {
    getBrandProduct(selectedBrandId, page).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          /* Product(this.name, this.image, this.available, this.price, this.quantity,
      this.sales, this.rate, this.discount, this.icon);*/

          print("Photos     ${value[i]["photos"]}");

          _brands_product.add(
            Product(
                photos: value[i]["photos"],
                price: value[i]["unit_price"],
                meta_description: value[i]["meta_description"],
                description: value[i]["description"],

                quantity: value[i]["quantity"],
                rate: value[i]["rating"],
                image: value[i]["image"],
                available: value[i]["available"],
                sales: value[i]["sales"],
                discount: value[i]["discount"],
                thumbnail_img: value[i]["thumbnail_img"],
                colors: value[i]["colors"],
                variations: value[i]["variations"],
                name: Intl.getCurrentLocale() == 'en' ? value[i]["name"] : value[i]["ar_name"],
                icon: value[i]["icon"],
                id: value[i]["id"].toString()),
          );

          isError = false;
          notifyListeners();
        }
      } else {
        isError = true;
        notifyListeners();
        print("Error ");
      }
    });
  }

  Future<dynamic> getBrandProduct(id, page) async {
    print("Get Barndd Product ");

    var data;

    await http
        .get("${api_base_url}brand/products/${id}?page=${page}")
        .then((response) {
      if (response.statusCode == 200) {
        print("Response  ${response.body}");

        var formated = json.decode(response.body);
        data = formated["results"]["data"];

        print("The Brand product is   ${data}");
      }
    });

    return data;
  }
}
