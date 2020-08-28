import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/user.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/repositories/token_repository.dart';
import 'package:smartcommercebd/src/repositories/user_repository.dart';
import 'package:smartcommercebd/src/screens/signup_phone.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:smartcommercebd/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showPassword = false;
  bool _isLoading = false;
  bool _emailValid = false;
  bool _passwordValid = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AndroidDeviceInfo device_info;
  String token;
  String device_type;

  Widget build(BuildContext context) {
    getToken();
    getDeviceInfo().then((value) {
      device_info = value;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: loginPageBody(),
      bottomNavigationBar: loginPageBottom(),
    );
  }

  loginPageBottom() {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: FlatButton(
          onPressed: () {Navigator.push(context,
              PageTransition(
                  type: PageTransitionType.downToUp,
                  child: PhoneNumberScreen()));},
          child: Container(
            height: 75,
            child: Column(
              children: <Widget>[
                Icon(Icons.expand_less),
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
                    child: Center(child: Text('SignUp', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                ),
              ],
            ),
          ),
        )
    );
  }

  loginPageBody() {
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
            child: Text('Welcome to Sunbulahome', textScaleFactor: 1.7,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
          ),
        ),
        SizedBox(height: 60,),
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Color(0xffbe9f71),),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                          errorText:
                          _emailValid ? 'Not an email address' : null,
                          hintText: 'Type your email address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).accentColor),
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
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Color(0xffbe9f71),),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.black
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color:
                            Theme.of(context).accentColor.withOpacity(0.4),
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          errorText:
                          _passwordValid ? 'At least 6 character' : null,
                          hintText: 'Type your password please',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Theme.of(context).accentColor),
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
                    SizedBox(height: 10,),
                    FlatButton(
                      textColor: Color(0xff1d1d1d),
                      onPressed: () {
                        print('forgot tapped');
                        Navigator.of(context).pushNamed('/ForgotPassword');
                        },
                      child: Text(
                          'Forgot password? Click here'
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
              _isLoading
                  ? CommonUtils.showProgressBar()
                  : Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: MaterialButton(
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    minWidth: 160,
                    color: const Color(0xffbe9f71),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      print('Login tapped');
                      !_emailController.text.contains('@')
                          ? _emailValid = true
                          : _emailValid = false;
                      !(_passwordController.text.length >= 6)
                          ? _passwordValid = true
                          : _passwordValid = false;
                      setState(() {
                        if (!_emailValid && !_passwordValid) _login();
                      });
                      },
                    child: Text('Login', textScaleFactor: 1.3,)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  previousLoginPage() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ]),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Text('Sign In',
                        style: Theme.of(context).textTheme.display3),
                    SizedBox(height: 20),
                    new TextField(
                      controller: _emailController,
                      style: TextStyle(color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        errorText:
                        _emailValid ? 'Not an email address' : null,
                        hintText: 'Email Address',
                        hintStyle: Theme.of(context).textTheme.body1.merge(
                          TextStyle(color: Theme.of(context).accentColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        prefixIcon: Icon(
                          UiIcons.envelope,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    new TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.text,
                      obscureText: !_showPassword,
                      decoration: new InputDecoration(
                        errorText:
                        _passwordValid ? 'At least 6 character' : null,
                        hintText: 'Password',
                        hintStyle: Theme.of(context).textTheme.body1.merge(
                          TextStyle(color: Theme.of(context).accentColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
                        prefixIcon: Icon(
                          UiIcons.padlock_1,
                          color: Theme.of(context).accentColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          color:
                          Theme.of(context).accentColor.withOpacity(0.4),
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/ForgotPassword');
                      },
                      child: Text(
                        'Forgot your password ?',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    SizedBox(height: 30),
                    _isLoading
                        ? CommonUtils.showProgressBar()
                        : FlatButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 70),
                      onPressed: () {
                        // 2 number refer the index of Home page
                        //Navigator.of(context).pushNamed('/Tabs', arguments: 2);
                        //Navigator.of(context).pushNamedAndRemoveUntil('/Tabs', ModalRoute.withName('/'), arguments: 2);
                        !_emailController.text.contains('@')
                            ? _emailValid = true
                            : _emailValid = false;
                        !(_passwordController.text.length >= 6)
                            ? _passwordValid = true
                            : _passwordValid = false;
                        setState(() {
                          if (!_emailValid && !_passwordValid) _login();
                        });
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.title.merge(
                          TextStyle(
                              color:
                              Theme.of(context).primaryColor),
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Or using social media',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    SizedBox(height: 20),
                    new SocialMediaWidget()
                  ],
                ),
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/SignUp');
            },
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.title.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
                children: [
                  TextSpan(text: 'Don\'t have an account ?'),
                  TextSpan(
                      text: ' Sign Up',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login() async {
    setState(() {
      _isLoading = true;
      _getAndSaveToken();
    });
  }

  _getAndSaveToken() async {
    var loginInfo = {
      'email': _emailController.text,
      'password': _passwordController.text,
      //'user_type': 'customer',
      'device_id': device_type=='android' ? device_info.id : 'ios',
      "device_type": device_type,
      "device_token": token
    };
    var tokenResponse = await TokenRepository.getToken(loginInfo);

    if (!(tokenResponse.error == "" || tokenResponse.error == null)) {
      print("Invalid credential");
      setState(() {
        _isLoading = false;
        tokenResponse.error == 'Invalid credential'
            ? CommonUtils.showErrorDialog(
                context, "Failure", tokenResponse.error, "close")
            : CommonUtils.showErrorDialog(
                context, "Failure", "Failed to Login, try again", "close");
      });
    } else {
      print("Token  isssssssss ${tokenResponse.token}");
      SharedPrefProvider.setString(token_key, tokenResponse.token);
      await UserRepository.getUser().then((user) {
        appUser = user.user;
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/Tabs', ModalRoute.withName('/'),
            arguments: 2);
      });
      setState(() {
        _isLoading = false;
      });
      var token = await SharedPrefProvider.getString(token_key);
      print('token: $token');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<AndroidDeviceInfo> getDeviceInfo() async {
    AndroidDeviceInfo info;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      device_type = "android";
      info = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      device_type = "ios";

      info = await deviceInfo.androidInfo;
    }

    return info;
  }

  getToken() {
    FirebaseMessaging().getToken().then((value) {
      print("Token ${value}");

      token = value;
    });
  }
}
