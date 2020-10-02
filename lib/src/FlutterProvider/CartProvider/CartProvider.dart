import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbulahome/src/models/Cart.dart';
import 'package:sunbulahome/src/models/RelatedProduct.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:dio/dio.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import '../../configs/strings.dart';

class CartProvider extends ChangeNotifier {
  Dio _dio = new Dio();
  Map<String, String> headers = {};

  var _total_price = 0.0;

  List<Cart> _card_list = new List<Cart>();

  List<Cart> get card_list => _card_list;

  get total_price => _total_price;

  CartProvider() {
//    getAllCarts();

    //allCarts();
  }

  total_price_calculation() {
    List<String> cart_list = CommonUtils.cart_list;

    for (int i = 0; i < cart_list.length; i++) {
      var cart = json.decode(cart_list[i]);

      print("Price   ===>  ${cart["unitPrice"]}");
      _total_price += double.parse(cart["unitPrice"].toString()) *
          int.parse(cart["quantity"].toString());
    }

    notifyListeners();
  }

  updateCard(Cart carts, /*Results results,*/ quantity, index) async {
    print("provider quanity  ${quantity}");

    Map<String, dynamic> cart = {
      "id": carts.id,
      "name": carts.name,
      "images": carts.images,
      "flashDealDiscount": carts.flashDealDiscount,
      "productDiscount": carts.productDiscount,
      /* 'choice1' : widget.product==null ? "null" : "null",
    "choice2" : ,*/
      "quantity": quantity,
      "unitPrice": carts.unitPrice,
    };

    print(
        "Index  ==>  ${index}   and the data is   ===>  ${CommonUtils.cart_list[index]}");

    CommonUtils.cart_list[index] = json.encode(cart);

    //  notifyListeners();

    await SharedPrefProvider.addCart(CommonUtils.cart_list);

    total_price_calculation();
  }

/*  void allCarts() async {
    var sp = await SharedPreferences.getInstance();


    var value = sp.getStringList(cart_list_key);


    for()
    _card_list = ;
  }*/

/*
  Future<Carts> getAllCarts() async {
    Carts carts;

    var token = await SharedPrefProvider.getString(token_key);

    // Map<String, String> body = {"id": id, "quantity": quantity};

    print("Cart Token  ${token}");

    headers['Authorization'] = "Bearer $token";

    headers["cookie"] = await SharedPrefProvider.getString(cookie);

    print("Cookie ====>  ${headers["cookie"]}");
    await http.get(api_base_url + 'carts', headers: headers).then((value) {
      print("The Value == > ${value.body}");

      if (value.statusCode == 200) {
        carts = Carts.fromJson(json.decode(value.body));
      } else {
        print("Failed to load carts");
      }
    }).catchError((err) => print("The Vaue is ${err}"));

    return carts;
  }

  Future<bool> addtoCard(id, quantity) async {
    bool status;

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> body = {
      "id": id,
      "quantity": quantity,
    };

    if (CommonUtils.selected_color != null) {
      body["color"] = CommonUtils.selected_color;
    }

    print("The Token  ${token}");

    Map<String, String> header = {"Authorization": "Bearer $token"};

    await http
        .post("${api_base_url}add-to-cart", body: body, headers: header)
        .then((value) {
      updateCookie(value);
      print("Carts Value ${value.body}");

      if (value.statusCode == 200) {
        status = true;
      } else {
        status = false;
      }

      print(value);
    });

    return status;
  }

  Future<void> updateCookie(http.Response response) async {
    String rawCookie = response.headers['set-cookie'];
    print("RowCookie   ${rawCookie}");

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      */ /*    headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);*/ /*
      var data = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      await SharedPrefProvider.setString(cookie, data);
      var v = await SharedPrefProvider.getString(cookie);
      print("Check  == > ${v}   and the data is   ==>  ${data}");
    }
  }*/
}
