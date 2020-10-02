import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Pending.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';

import 'package:sunbulahome/src/utils/common_utils.dart';

class PendingProvider extends ChangeNotifier {
  bool loading;

  var url;
  Pending _order = new Pending();
  List<Data> _listData;

  List<Data> get listData => _listData;

  Pending get order => _order;


  UnpaidProvider() {
    print("UnpaidProvider");
    _order = null;

    getPending().then((value) {
      _order = value;

      notifyListeners();
    });
  }

  Future<Pending> getPending() async {
    Pending order;

    loading = true;
    notifyListeners();


    var token = await SharedPrefProvider.getString(token_key);


    Map<String, String> header = {"Authorization": "Bearer ${token}"};

    await http
        .get("${api_base_url}orders/pending", headers: header)
        .then((value) {
      if (value.statusCode == 200) {
        print("Pending data   ${value.body}");

        order = Pending.fromJson(json.decode(value.body));

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

  PendingPagination() async {
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

          _order = new Pending();

          _order = Pending.fromJson(json.decode(value.body));

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
