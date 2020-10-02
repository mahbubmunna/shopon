import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sunbulahome/src/models/Cart.dart';
import 'package:sunbulahome/src/models/product.dart';

class CommonUtils {
  //

  static var chat_next_url;
  static var selected_color;

  static var home_scroll_value;

  static var token;
  static List<String> cart_list = new List<String>();
  static List<String> payment_cart_list = new List<String>();

  static showProgressBar() {
    return Column(
      children: <Widget>[CircularProgressIndicator(), SizedBox(height: 10,)],
    );
  }

  //
  static showErrorDialog(
      BuildContext context, String title, String content, String action) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(action),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //
  static changeScreen(BuildContext context, Widget page) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => page),
          (dynamic route) => false);

  //
  static raisedButton(String buttonText, Function onPressedFunction) {
    return ButtonTheme(
      height: 50,
      minWidth: double.infinity,
      child: RaisedButton(
        onPressed: onPressedFunction,
        child: Text(buttonText),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
    );
  }

  //
  static flatButton(String buttonText, Function onPressedFunction) {
    return ButtonTheme(
      height: 50,
      minWidth: double.infinity,
      child: FlatButton(
        onPressed: onPressedFunction,
        child: Text(buttonText),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
    );
  }
}

closeAwesomeDialog(BuildContext context) {
  Timer(Duration(seconds: 3), () {
    Navigator.pop(context);
  });
}