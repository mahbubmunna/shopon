import 'package:cached_network_image/cached_network_image.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/screens/Category/CategorysWidget.dart';
import 'package:sunbulahome/src/screens/home.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
              accountName: Text(
                appUser.name,
                style: Theme.of(context).textTheme.title,
              ),
              accountEmail: Text(
                appUser.email,
                style: Theme.of(context).textTheme.caption,
              ),
//              currentAccountPicture: CircleAvatar(
//                backgroundColor: Theme.of(context).accentColor,
//                backgroundImage: CachedNetworkImageProvider(appUser.avatar),
//              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).home,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 3);
            },
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).notifications,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Orders', arguments: 0);
            },
            leading: Icon(
              UiIcons.inbox,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).myOrders,
              style: Theme.of(context).textTheme.subhead,
            ),
            /*  trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '8',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),*/
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.heart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).wishList,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              S.of(context).products,
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => CategorysWidget()));

              /*Navigator.of(context).pushNamed('/Categories', arguments:
              RouteArgument(argumentsList: categoriesList));*/
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).categories,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Brands',
          //         arguments: RouteArgument(argumentsList: brandsList));
          //   },
          //   leading: Icon(
          //     UiIcons.folder_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     S.of(context).brands,
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            dense: true,
            title: Text(
              S.of(context).applicationPreferences,
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Help');
          //   },
          //   leading: Icon(
          //     UiIcons.information,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Help & Support",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.settings_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).settings,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              UiIcons.planet_earth,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).languages,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              await SharedPrefProvider.setString(token_key, '');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/SignIn', ModalRoute.withName('/'));
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              S.of(context).logOut,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Version 0.0.1",
          //     style: Theme.of(context).textTheme.body1,
          //   ),
          //   trailing: Icon(
          //     Icons.remove,
          //     color: Theme.of(context).focusColor.withOpacity(0.3),
          //   ),
          // ),
        ],
      ),
    );
  }
}
