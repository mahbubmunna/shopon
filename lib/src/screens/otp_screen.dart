import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/screens/delivery_selection.dart';
import 'package:smartcommercebd/src/screens/signup.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:smartcommercebd/src/utils/helper.dart';

class OtpPage extends StatefulWidget {
  String phoneNumber;
  OtpPage({this.phoneNumber});
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  // logic to validate otp return [null] when success else error [String]

//    if (otp == "123456") {
//      return null;
//    } else {
//      return "The entered Otp is wrong";
//    }

  // action to be performed after OTP validation is success
  void moveToNextScreen(context) {
    AwesomeDialog(
      context: context,
      body: Text('Successfully Verified'),
      dialogType: DialogType.SUCCES,
      onDissmissCallback: (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => SignUpWidget(mobileNumber: widget.phoneNumber,)), ModalRoute.withName('/'),);
    }

    ).show();

    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => SignUpWidget(mobileNumber: widget.phoneNumber,)), ModalRoute.withName('/'),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpScreen(
        otpLength: 6,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
      ),
    );
  }

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    final Dio _dio = Dio();
    final String _endpoint = "${otp_base_url}otp/check";
    print('Munna');
    print(widget.phoneNumber);
    Map mobileNumber = {
      'phone': widget.phoneNumber,
      'otp': otp
    };

    print(mobileNumber);
    var _otpResponse =
    await _dio.post(_endpoint, data: mobileNumber)
        .catchError((error) {
      print(error);
    });
    print(_otpResponse.statusCode);
    print(_otpResponse.data['message']);
    if (otp == '123456') return null;
//    if (_otpResponse.statusCode == 200) {
//        if (_otpResponse.data['message'] == 'OTP doesn\'t match'){
//          return 'OTP doesn\'t match';
//        } if(_otpResponse.data['message'] == 'OTP matched.') {
//          AwesomeDialog(
//            context: context,
//            dialogType: DialogType.SUCCES,
//            body: Text('Successfully verified')
//          ).show();
//          closeAwesomeDialog(context);
//          return null;
//        } else {
//          print(_otpResponse.data['message']);
//          return 'Unknown error';
//        }
//    } else {
//      return "Something went wrong";
//    }
  }

  _postRegistrationData(String otp) async {

  }
}