import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Review.dart';
import 'package:http/http.dart' as http;
import 'package:smartcommercebd/src/utils/common_utils.dart';

class ReviewProvider extends ChangeNotifier {
  bool loading;

  var url;
  Review _review;
  List<Data> _listData;

  List<Data> get listData => _listData;

  Review get review => _review;

  ReviewProvider(id) {
    _review = null;

    if (id != null) {
      getReview(id).then((value) {
        _review = value;

        notifyListeners();
      });
    }
  }

  Future<Review> getReview(id) async {
    Review review;

    loading = true;
    notifyListeners();

    await http.get("${api_base_url}review/${id}").then((value) {
      if (value.statusCode == 200) {
        print("Review data   ${value.body}");

        review = Review.fromJson(json.decode(value.body));

        _listData = review.results.data;

        loading = false;
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
        print("error");
      }
    });

    return review;
  }

  ReviewPagination() async {
    loading = true;
    notifyListeners();
    if (_review.results.nextPageUrl != null) {
      await http.get("${_review.results.nextPageUrl}").then((value) {
        if (value.statusCode == 200) {
          _review = Review.fromJson(json.decode(value.body));

          for (int i = 0; i < _review.results.data.length; i++) {
            _listData.add(_review.results.data[i]);

            notifyListeners();
          }

          loading = false;
          notifyListeners();
        } else {
          loading = false;
          notifyListeners();
          print("error");
        }
      });
    }
  }
}
