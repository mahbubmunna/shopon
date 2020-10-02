import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Unpaid.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';

class UnpaidProvider extends ChangeNotifier {
  bool loading;

  var url;
  Unpaid _order = new Unpaid();
  List<Data> _listData;

  List<Data> get listData => _listData;

  Unpaid get order => _order;

  UnpaidProvider() {
    print("UnpaidProvider");
    _order = null;
    getUnpaid().then((value) {
      _order = value;
      notifyListeners();
    });
  }

  Future<Unpaid> getUnpaid() async {
    Unpaid order;

    loading = true;
    notifyListeners();

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {"Authorization": "Bearer ${token}"};

    await http
        .get("${api_base_url}orders/unpaid", headers: header)
        .then((value) {
      if (value.statusCode == 200) {
        print("Unpaid    ${value.body}");

        order = Unpaid.fromJson(json.decode(value.body));
        print("Unpaid data   ${order.results.nextPageUrl}");
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

  UnpaidPagination() async {
    //Order _order =

    var token = await SharedPrefProvider.getString(token_key);

    Map<String, String> header = {"Authorization": "Bearer ${token}"};
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

          _order = new Unpaid();

          _order = Unpaid.fromJson(json.decode(value.body));

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
