import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Order.dart';

import 'package:http/http.dart' as http;
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';

class OrderProvider extends ChangeNotifier {
  bool loading;

  var url;
  Order _order = new Order();
  List<Data> _listData;

  List<Data> get listData => _listData;

  Order get order => _order;

  OrderProvider() {
    print("OrderProvider");
    _order = null;

    getOrder().then((value) {
      _order = value;

      notifyListeners();
    });
  }

  Future<Order> getOrder() async {
    Order order;

    loading = true;
    notifyListeners();

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {"Authorization": "Bearer ${token}"};

    print("Header   ${header}");

    await http.get("${api_base_url}orders/all", headers: header).then((value) {



      if (value.statusCode == 200) {
        print("Order data   ${value.body}");

        order = Order.fromJson(json.decode(value.body));

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

  OrderPagination() async {
    //Order _order =

    loading = true;
    notifyListeners();
    if (_order.results.nextPageUrl != null) {
      //fixed the
      // url hit problem

      var token = await SharedPrefProvider.getString(token_key);

      Map<String, String> header = {"Authorization": "Bearer ${token}"};

      await http
          .get("${_order.results.nextPageUrl}", headers: header)
          .then((value) {
        _order.results.nextPageUrl = null;
        print("Pagination Valueee  ${value.body}");

        if (value.statusCode == 200) {
          //   _order.results.data.clear();

          _order = new Order();

          _order = Order.fromJson(json.decode(value.body));

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
