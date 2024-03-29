import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:sunbulahome/custom_library/splash_screen.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/user.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/config/app_config.dart' as config;
import 'package:sunbulahome/src/utils/common_utils.dart';

User appUser;

bool isLoggedIn = false;

getUser(BuildContext context) async {
  if (await SharedPrefProvider.getString(token_key) != null &&
      await SharedPrefProvider.getString(token_key) != '') {
    CommonUtils.token = await SharedPrefProvider.getString(token_key);

    print("Token is  ${CommonUtils.token}");

    isLoggedIn = true;
  } else {
    print("Token is null");
  }
  print("Is log in ?  ${isLoggedIn}");
  if (isLoggedIn) {
    await UserRepository.getUser().then((user) {
      appUser = user.user;
      print(appUser.email);

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Tabs', ModalRoute.withName('/'),
          arguments: 0);
    }).catchError((error) {
      /*return AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              body: Text('Network Error'))
          .show();*/
    });
  } else {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/SignIn', ModalRoute.withName('/'));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Splash(
      navigateAfterFuture: getUser(context),
      image: new Image.asset('assets/launcher/icon.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loadingText: Text(S.of(context).loading),
      loaderColor: config.Colors().mainColor(1),
    );
  }
}
