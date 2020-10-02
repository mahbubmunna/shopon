import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/screens/otp_screen.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/utils/helper.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  bool _isLoading = false;
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newRegisterPageBody(),
      bottomNavigationBar: newBottomBody(),
    );
  }

  newBottomBody() {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: FlatButton(
          onPressed: () {Navigator.pop(context);},
          child: Container(
            height: 30,
            child: Column(
              children: <Widget>[
                Container(
                    child: Center(child: Text(S.of(context).alreadyHaveAnAccountSignIn, style: TextStyle(fontWeight: FontWeight.bold),))
                ),
              ],
            ),
          ),
        )
    );
  }

  registerPageBottom() {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: FlatButton(
          onPressed: () {Navigator.pop(context);},
          child: Container(
            height: 75,
            child: Column(
              children: <Widget>[
                Icon(Icons.expand_more),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      ),
                      color: const Color(0xffbe9f71),
                    ),
                    height: 50,
                    width: 300,
                    child: Center(child: Text(S.of(context).signIn, textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                ),
              ],
            ),
          ),
        )
    );
  }

  newRegisterPageBody() {
    final List<String> countryFilter = ['SA'];
    return ListView(
      children: [
        Image.asset('assets/img/login.png', height: 200, width: 100,),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(child: Text(S.of(context).accountRegistration, textScaleFactor: 1.7,
                style: TextStyle(fontWeight: FontWeight.bold),),),
              SizedBox(height: 10,),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: CountryCodePicker(
                      textStyle: TextStyle(color: Colors.black),
                      countryFilter: countryFilter,
                    ),
                  ),
                  labelText: S.of(context).mobileNumber,
                  labelStyle: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading ?
                  CommonUtils.showProgressBar() :
                  MaterialButton(
                    elevation: 0,
                    minWidth: 160,
                    height: 40,
                    color: Color(0xffF46665),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      print('Otp Tapped'); _register();
                    },
                    child: Text(S.of(context).sendOtp, textScaleFactor: 1.2, ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Image.asset('assets/img/login_registration_bottom.png')
      ],
    );
  }

  registerPageBody() {
    final List<String> countryFilter = ['SA'];
    return ListView(
      children: <Widget>[
        SizedBox(height: 60,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 48.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: const Color(0xffbe9f71),
            border: Border.all(width: 1.0, color: const Color(0xffe4dcd1)),
          ),
          child: Center(
            child: Text(S.of(context).welcomeToSunbulahome, textScaleFactor: 1.7,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
          ),
        ),
        SizedBox(height: 100,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: const Color(0xffe4dcd1),
            border: Border.all(width: 1.0, color: const Color(0xffe4dcd1)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffbe9f71),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: 300.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(51.0),
                    image: DecorationImage(
                      image: const AssetImage('assets/launcher/icon.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: CountryCodePicker(
                              textStyle: TextStyle(color: Colors.black),
                              countryFilter: countryFilter,
                            ),
                          ),
                          labelText: S.of(context).mobileNumber,
                          labelStyle: TextStyle(
                              color: Colors.black
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffbe9f71), width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff707070), width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
              _isLoading ?
              CommonUtils.showProgressBar() :
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: MaterialButton(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    minWidth: 160,
                    color: const Color(0xffbe9f71),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      print('Otp Tapped'); _register();},
                    child: Text('Send OTP', textScaleFactor: 1.3,)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _register() async {
    setState(() {
      _isLoading = true;
      _postRegistrationData();
    });
  }

  _postRegistrationData() async {
    final Dio _dio = Dio();
    final String _endpoint = "${otp_base_url}otp/send";
    Map mobileNumber = {
      'phone': '966'+_phoneController.text,
    };

    print(mobileNumber);
    var _otpResponse =
    await _dio.post(_endpoint, data: mobileNumber)
        .catchError((error) {
      AwesomeDialog(
          context: context,
          body: Text(Common.handleError(error)),
          dialogType: DialogType.ERROR)
          .show();
    });
    print(_otpResponse.statusCode);

    if (_otpResponse.statusCode == 200) {
      setState(() {
        _isLoading = false;
        print(_otpResponse.data['results']['message']);
        if(_otpResponse.data['results']['message'] == '') {
          print('Successfully send the message ');
          print(mobileNumber['phone']);
          Navigator.push(context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: OtpPage(phoneNumber: mobileNumber['phone'],)));
        } else {
          CommonUtils.showErrorDialog(
              context, S.of(context).failure, S.of(context).notSupportedNumberTryWithWorkingNumber, S.of(context).close);
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        CommonUtils.showErrorDialog(
            context, S.of(context).failure, S.of(context).notSupportedNumberTryWithWorkingNumber, S.of(context).close);
      });
    }
  }

//  _getAndSaveToken() async {
//    var loginInfo = {
//      'email': _emailController.text,
//      'password': _passwordController.text,
//      'device_id': device_type=='android' ? device_info.id : 'ios',
//      "device_type": device_type,
//      "device_token": token
//    };
//    print(loginInfo);
//    var tokenResponse = await TokenRepository.getToken(loginInfo);
//
//    print("Token Response   ${tokenResponse.token}");
//
//    if (!(tokenResponse.error == "" || tokenResponse.error == null)) {
//      setState(() {
//        _isLoading = false;
//        CommonUtils.showErrorDialog(
//            context, "Failure", "Failed to Login, try again", "close");
//      });
//    } else {
//      print(tokenResponse.token);
//      SharedPrefProvider.setString(token_key, tokenResponse.token);
//      await UserRepository.getUser().then((user) {
//        appUser = user.user;
////        Navigator.of(context).pushNamedAndRemoveUntil(
////            '/Tabs', ModalRoute.withName('/'),
////            arguments: 2);
//        Navigator.of(context).pushNamedAndRemoveUntil(
//          '/DeliverySelection', ModalRoute.withName('/'),);
//
//      });
//      setState(() {
//        _isLoading = false;
//      });
//    }
//  }
}
