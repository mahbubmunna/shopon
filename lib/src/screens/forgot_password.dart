import 'package:flutter/material.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgotPasswordWidget extends StatefulWidget {
  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: forgot_password_url,
    );
  }
}
