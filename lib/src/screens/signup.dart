import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info/device_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/repositories/registration_repository.dart';
import 'package:sunbulahome/src/repositories/token_repository.dart';
import 'package:sunbulahome/src/repositories/user_repository.dart';
import 'package:sunbulahome/src/screens/signin.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'package:sunbulahome/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

import '../utils/common_utils.dart';

class SignUpWidget extends StatefulWidget {
  String mobileNumber;
  SignUpWidget({this.mobileNumber});

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _showPassword = false;
  bool _isLoading = false;
  final _usernameController = TextEditingController();
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
      body: newLoginPageBody(),
      bottomNavigationBar: registerPageBottom(),
    );
  }

  registerPageBottom() {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: FlatButton(
          onPressed: () {
            PageTransition(
                type: PageTransitionType.downToUp,
                child: SignInWidget());
          },
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

  newLoginPageBody() {
    return ListView(
      children: [
        SizedBox(height: 20,),
        Center(child: Text(S.of(context).sunbulahome, textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),)),
        Center(child: Image.asset('assets/img/login.png', height: 150, width: 100,)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(child: Text(S.of(context).accountRegistration, textScaleFactor: 1.7,
                style: TextStyle(fontWeight: FontWeight.bold),),),
              SizedBox(height: 10,),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: S.of(context).name,
                  hintText: S.of(context).typeYourName,
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                    TextStyle(color: Theme.of(context).accentColor),
                  ),
                  suffixIcon: Icon(Icons.person, color: Colors.black,),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: S.of(context).emailAddress,
                  hintText: S.of(context).typeYourEmailAddress,
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                    TextStyle(color: Theme.of(context).accentColor),
                  ),
                  suffixIcon: Icon(Icons.email, color: Colors.black,),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: S.of(context).password,
                  suffixIcon: Icon(Icons.lock, color: Colors.black,),
                  hintText: S.of(context).typeYourPassword,
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                    TextStyle(color: Theme.of(context).accentColor),
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
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _register();
                      print(S.of(context).registrationTapped);
                    },
                    child: Text(S.of(context).registration, textScaleFactor: 1.2,),
                  )
                ],
              ),
            ],
          ),
        ),
        Image.asset('assets/img/login_registration_bottom.png')
      ],
    );
  }

  registerPageBody() {
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Color(0xffbe9f71),),
                          labelText: S.of(context).name,
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
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Color(0xffbe9f71),),
                          labelText: S.of(context).email,
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
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Color(0xffbe9f71),),
                          labelText: S.of(context).password,
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
//                    Container(
//                      margin: EdgeInsets.symmetric(horizontal: 10),
//                      child: TextField(
//                        obscureText: !_showPassword,
//                        decoration: InputDecoration(
//                          prefixIcon: Icon(Icons.lock, color: Color(0xffbe9f71),),
//                          labelText: 'Confirm Password',
//                          labelStyle: TextStyle(
//                              color: Colors.black
//                          ),
//                          focusedBorder: OutlineInputBorder(
//                              borderSide: BorderSide(color: Color(0xffbe9f71), width: 2.0),
//                              borderRadius: BorderRadius.all(Radius.circular(32))
//                          ),
//                          enabledBorder: OutlineInputBorder(
//                              borderSide: BorderSide(color: Color(0xff707070), width: 2.0),
//                              borderRadius: BorderRadius.all(Radius.circular(32))
//                          ),
//                        ),
//                      ),
//                    ),
//                    FlatButton(
//                      textColor: Color(0xff1d1d1d),
//                      onPressed: () {print('forgot tapped');},
//                      child: Text(
//                          'Forgot password? Click here'
//                      ),
//                    ),
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
                      print('Register tapped'); _register();},
                    child: Text(S.of(context).register, textScaleFactor: 1.3,)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  previousRegisterPage() {
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Text(S.of(context).signUp,
                        style: Theme.of(context).textTheme.display3),
                    SizedBox(height: 20),
                    new TextField(
                      controller: _usernameController,
                      style: TextStyle(color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        hintText: S.of(context).fullName,
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
                          UiIcons.user_1,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      style: TextStyle(color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        hintText: S.of(context).emailAddress,
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
                        hintText: S.of(context).password,
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
                    SizedBox(height: 40),
                    _isLoading
                        ? CommonUtils.showProgressBar()
                        : FlatButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 70),
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/SignIn');
                        _register();
                      },
                      child: Text(
                        S.of(context).signUp,
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
                      S.of(context).orUsingSocialMedia,
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
              Navigator.of(context).pushNamed('/SignIn');
            },
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.title.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
                children: [
                  TextSpan(text: S.of(context).alreadyHaveAnAccount),
                  TextSpan(
                      text: S.of(context).signIn,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  _register() async {
    setState(() {
      _isLoading = true;
      _postRegistrationData();
    });
  }

  _postRegistrationData() async {
    print("device_type  :  ${device_type}");
    print("token   :  ${token}");
    Map registrationInfo = {
      'name': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'user_type': 'customer',
      'device_id': device_type=='android' ? device_info.id : 'ios',
      "device_type": device_type,
      "device_token": token,
      "phone": widget.mobileNumber

    };

    print(registrationInfo);
    var registrationResponse =
        await RegistrationRepository.postRegistrationInfo(registrationInfo)
            .catchError((error) {
      AwesomeDialog(
              context: context,
              body: Text(Common.handleError(error)),
              dialogType: DialogType.ERROR)
          .show();
    });
    print(registrationResponse.statusCode);

    if (registrationResponse.statusCode == 201) {
      setState(() {
        _isLoading = false;
        _getAndSaveToken();
      });
    } else {
      setState(() {
        _isLoading = false;
        CommonUtils.showErrorDialog(
            context, S.of(context).failure, S.of(context).failedToRegisterTryAgain, S.of(context).close);
      });
    }
  }

  _getAndSaveToken() async {
    var loginInfo = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'device_id': device_type=='android' ? device_info.id : 'ios',
      "device_type": device_type,
      "device_token": token
    };
    print(loginInfo);
    var tokenResponse = await TokenRepository.getToken(loginInfo);

    print("Token Response   ${tokenResponse.token}");

    if (!(tokenResponse.error == "" || tokenResponse.error == null)) {
      setState(() {
        _isLoading = false;
        CommonUtils.showErrorDialog(
            context, S.of(context).failure, S.of(context).failedToLoginTryAgain, S.of(context).close);
      });
    } else {
      print(tokenResponse.token);
      SharedPrefProvider.setString(token_key, tokenResponse.token);
      await UserRepository.getUser().then((user) {
        appUser = user.user;
//        Navigator.of(context).pushNamedAndRemoveUntil(
//            '/Tabs', ModalRoute.withName('/'),
//            arguments: 2);
         Navigator.of(context).pushNamedAndRemoveUntil(
             '/DeliveryMap', ModalRoute.withName('/'),);


      });
      setState(() {
        _isLoading = false;
      });
    }
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
