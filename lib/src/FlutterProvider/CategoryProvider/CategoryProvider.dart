import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/product.dart';

class CategoryProvider extends ChangeNotifier {
  List<Product> _categoryProductsList = new List();
  List<Product> _category_list = new List();

  var _page;

  var _seletedCategory;
  var _category_status;
  bool isError = false;

  bool get error => isError;

  get selectedcategory => _seletedCategory;

  get category_status => _category_status;

  get page => _page;

  List<Product> get categoryProductsList => _categoryProductsList;

  List<Product> get category_list => _category_list;

  setPage(p) {
    _page = p;

    notifyListeners();
  }

  CategoryProvider() {
    _page = 1;

    futureCategory(1).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          // List<String> _photo_list = new List();
          // _photo_list.clear();

//          if (value[i]["photos"] != null) {
//            print("Photos  ${value[i]["photos"][0]}");
//
//            List<String> photo_list = json.decode(value[i]["photos"]);
//            photo_list.forEach((element) {
//              _photo_list.add(element);
//            });
//          }

          print("Photos   ${value[i]["photos"]}");
          _category_list.add(
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
                arName: value[i]["ar_name"],
                id: value[i]["id"].toString()),
          );

          isError = false;

          notifyListeners();
        }

        setSelectedcategory(_category_list[0].id);
      } else {
        isError = true;
        notifyListeners();
        print("Error ");
      }
    }).then((value) {
      // print("Selected Id ===  ${_seletedCategory}");

      futureCategoryProducts(_seletedCategory, _page).then((value) {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            print("Photos   ${value[i]["photos"]}");

            _categoryProductsList.add(Product(
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
                icon: /*public_path_url +*/ value[i]["icon"],
                id: value[i]["id"].toString()));
            isError = false;

            notifyListeners();
          }

          notifyListeners();
        } else {
          isError = true;

          notifyListeners();
        }
      });
    });
  }

  Future<List<dynamic>> futureCategoryProducts(id, page_number) async {
    var data;

    await http
        .get("${api_base_url}category/products/${id}?page=${page_number}")
        .then((response) {
      print("Category Products  Response  ${response.body}");

      if (response.statusCode == 200) {
        print("Category Products  Response  ${response.body}");

        var formated = json.decode(response.body);
        data = formated["results"]["data"];
      } else {
        print("Category Products  Response   ${response.statusCode}");
      }
    }).catchError((err) => print("Category Products Error  ${err}"));

    return data;
  }

  Future<List<dynamic>> futureCategory(page_number) async {
    var value;

    await http
        .get("${api_base_url}categories?page=${page_number}")
        .then((response) {
      if (response.statusCode == 200) {
        print("Category   Response  ${response.body}");

        var formated = json.decode(response.body);
        var data = formated["results"]["data"];

        value = data;
      }
    });

    return value;
  }

  CategoryProductsPagination() {
    futureCategoryProducts(_seletedCategory, _page).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          print("Photos   ${value[i]["photos"]}");

          _categoryProductsList.add(Product(
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
              name: value[i]["name"],
              icon: value[i]["icon"],
              id: value[i]["id"].toString()));
        }

        //if(value[])

        isError = false;

        _category_status = true;

        notifyListeners();

        notifyListeners();
      } else {
        print("Data Not  found ");
        _category_status = false;
        isError = true;
        notifyListeners();
      }
    });
  }

  /*
  *
  Product(
      this.name,
      this.image,
      this.available,
      this.price,
      this.quantity,
      this.sales,
      this.rate,
      this.discount,
      this.icon,
      this.id,
      this.meta_description,
      this.colors,
      this.variations);
  *
  * */

  Categorypagination(page) {
    futureCategory(page).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          print("Photos   ${value[i]["photos"]}");

          _category_list.add(Product(
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
              id: value[i]["id"].toString()));

          isError = false;
          notifyListeners();
        }
      } else {
        isError = true;
        notifyListeners();

        print("pagination Error");
      }
    });
  }

  setSelectedcategory(id) {
    _categoryProductsList.clear();
    _seletedCategory = id;

    notifyListeners();

    //  Categorypagination(1);
  }

  setCategoryScrollStatus(value) {
    _category_status = value;
  }
}
