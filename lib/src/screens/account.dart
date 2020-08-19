import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/ProfileProvider/ProfileProvider.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/widgets/ProfileSettingsDialog.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}
//uploads\/products\/photos\/wMKm3nI1USMmkWKsInjxfQ4jdrnWR4bj1K036sqB.jpeg

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
      //builder: (_)=>,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            return Profile(context, provider);
          },
        ),
      ),
    );
  }

  Profile(BuildContext context, ProfileProvider provider) {
    if (provider.profile == null) {
      return Container(
          height: MediaQuery.of(context).size.height - 70,
          width: MediaQuery.of(context).size.width,
          child: Center(child: CircularProgressIndicator()));
    } else {
      return Column(
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        provider.profile.results.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.display2,
                      ),
                      Text(
                        provider.profile.results.email,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
//                SizedBox(
//                    width: 55,
//                    height: 55,
//                    child: InkWell(
//                      borderRadius: BorderRadius.circular(300),
//                      onTap: () {
//                        AwesomeDialog(
//                                context: context,
//                                dialogType: DialogType.INFO,
//                                body: Text(
//                                    'Please use website to update profile picture'))
//                            .show();
//                      },
//                      child: CircleAvatar(
//                        backgroundImage:
//                            CachedNetworkImageProvider(appUser.avatar),
//                      ),
//                    )),
              ],
            ),
          ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 20),
//            decoration: BoxDecoration(
//              color: Theme.of(context).primaryColor,
//              borderRadius: BorderRadius.circular(6),
//              boxShadow: [
//                BoxShadow(
//                    color: Theme.of(context).hintColor.withOpacity(0.15),
//                    offset: Offset(0, 3),
//                    blurRadius: 10)
//              ],
//            ),
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                    onPressed: () {
//                      Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                    },
//                    child: Column(
//                      children: <Widget>[
//                        Icon(UiIcons.heart),
//                        Text(
//                          S.of(context).wishList,
//                          style: Theme.of(context).textTheme.body1,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                    onPressed: () {
//                      //Navigator.of(context).pushNamed('/Tabs', arguments: 0);
//                    },
//                    child: Column(
//                      children: <Widget>[
//                        Icon(UiIcons.favorites),
//                        Text(
//                          S.of(context).following,
//                          style: Theme.of(context).textTheme.body1,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                    onPressed: () {
//                      Navigator.of(context).pushNamed('/Tabs', arguments: 3);
//                    },
//                    child: Column(
//                      children: <Widget>[
//                        Icon(UiIcons.chat_1),
//                        Text(
//                          S.of(context).messages,
//                          style: Theme.of(context).textTheme.body1,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          /*  Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: Icon(UiIcons.inbox),
                  title: Text(
                    'My Orders',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  trailing: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    minWidth: 50.0,
                    height: 25.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Orders');
                      },
                      child: Text(
                        "View all",
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Orders');
                  },
                  dense: true,
                  title: Text(
                    'Unpaid',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '1',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Orders');
                  },
                  dense: true,
                  title: Text(
                    'To be shipped',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '5',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Orders');
                  },
                  dense: true,
                  title: Text(
                    'Shipped',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '3',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Orders');
                  },
                  dense: true,
                  title: Text(
                    'In dispute',
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),*/
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: Icon(UiIcons.user_1),
                  title: Text(
                    S.of(context).profileSettings,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  trailing: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    minWidth: 50.0,
                    height: 25.0,
                    child: ProfileSettingsDialog(
                      user: appUser,
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    S.of(context).fullName,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    provider.profile.results.name,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    S.of(context).email,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    provider.profile.results.email,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Text(
//                    'Gender',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  trailing: Text(
//                    appUser.gender,
//                    style: TextStyle(color: Theme.of(context).focusColor),
//                  ),
//                ),
//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Text(
//                    'Birth Date',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  trailing: Text(
//                    appUser.getDateOfBirth(),
//                    style: TextStyle(color: Theme.of(context).focusColor),
//                  ),
//                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    S.of(context).address,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    "Saudi Arabia",
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    S.of(context).city,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    "Jeddah",
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Text(
//                    'Country',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  trailing: Text(
//                    appUser.country,
//                    style: TextStyle(color: Theme.of(context).focusColor),
//                  ),
//                ),
//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Text(
//                    'Birth Date',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  trailing: Text(
//                    appUser.getDateOfBirth(),
//                    style: TextStyle(color: Theme.of(context).focusColor),
//                  ),
//                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: Icon(UiIcons.settings_1),
                  title: Text(
                    S.of(context).accountSettings,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Row(
//                    children: <Widget>[
//                      Icon(
//                        UiIcons.placeholder,
//                        size: 22,
//                        color: Theme.of(context).focusColor,
//                      ),
//                      SizedBox(width: 10),
//                      Text(
//                        'Shipping Adresses',
//                        style: Theme.of(context).textTheme.body1,
//                      ),
//                    ],
//                  ),
//                ),

                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Languages');
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      Icon(
                        UiIcons.planet_earth,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).languages,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                  trailing: Text(
                    S.of(context).english,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Help');
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      Icon(
                        UiIcons.information,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).helpSupport,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
