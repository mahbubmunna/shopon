import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Shipped.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';

class ShippedProvider extends ChangeNotifier {
  bool loading;

  var url;
  Shipped _order = new Shipped();
  List<Data> _listData;

  List<Data> get listData => _listData;

  Shipped get order => _order;


  ShippedProvider() {
    print("OrderProvider");
    _order = null;

    getShipped().then((value) {
      _order = value;

      notifyListeners();
    });
  }

  Future<Shipped> getShipped() async {
    Shipped order;

    loading = true;
    notifyListeners();


    var token = await SharedPrefProvider.getString(token_key);


    Map<String, String> header = {"Authorization": "Bearer ${token}"};

    await http
        .get("${api_base_url}orders/all", headers: header)
        .then((value) {
      if (value.statusCode == 200) {
        print("Shipped data   ${value.body}");

        order = Shipped.fromJson(json.decode(value.body));

        _listData = order.results.data;

        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
        print("error");
      }
    });

    return order;
  }

  ShippedPagination() async {


    var token = await SharedPrefProvider.getString(token_key);


    Map<String, String> header = {"Authorization": "Bearer ${token}"};
    //Order _order =

    loading = true;
    notifyListeners();
    if (_order.results.nextPageUrl != null) {
      //fixed the url hit problem

      await http
          .get("${_order.results.nextPageUrl}", headers: header)
          .then((value) {
        _order.results.nextPageUrl = null;
        print("Pagination Valueee  ${value.body}");

        if (value.statusCode == 200) {
          //   _order.results.data.clear();

          _order = new Shipped();

          _order = Shipped.fromJson(json.decode(value.body));

          for (int i = 0; i < _order.results.data.length; i++) {
            print("Pagination Data  ${_order.results.data[i].orderDetails} ");
            _listData.add(_order.results.data[i]);
          }

          loading = false;
          notifyListeners();
        } else {
          loading = false;
          notifyListeners();
          print("error");
        }
      });
    } else {
      loading = false;
      notifyListeners();
    }
  }
}
