import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/FlashProvider/FlashProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/NotificationProvider.dart';
import 'package:smartcommercebd/src/models/user.dart';
import 'package:smartcommercebd/src/screens/account.dart';
import 'package:smartcommercebd/src/screens/chat.dart';
import 'package:smartcommercebd/src/screens/favorites.dart';
import 'package:smartcommercebd/src/screens/home.dart';
import 'package:smartcommercebd/src/screens/messages.dart';
import 'package:smartcommercebd/src/screens/notifications.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/widgets/DrawerWidget.dart';
import 'package:smartcommercebd/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// ignore: must_be_immutable
class TabsWidget extends StatefulWidget {
  int currentTab = 0;
  int selectedTab = 0;
  String currentTitle = 'Home';
  final User user;
  Widget currentPage = HomeWidget();

  TabsWidget({Key key, this.currentTab, this.user}) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool test = true;

  @override
  initState() {
    _selectTab(widget.currentTab);
    super.initState();
  }

  @override
  void didUpdateWidget(TabsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = S.current.home;
          widget.currentPage = MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => BrandsProvider(1)),
              ChangeNotifierProvider(create: (_) => FlashProvider(1)),
              ChangeNotifierProvider(create: (_) => CategoryProvider()),
              ChangeNotifierProvider(create: (_) => Notificationprovider()),

              //  Provider<BrandsProvider>(create: (_) => BrandsProvider(1)),
              //Provider<FlashProvider>(create: (_) => FlashProvider(1)),
            ],
            child: HomeWidget(),
          );
          break;
        case 1:
          widget.currentTitle = S.current.favorites;
          widget.currentPage = FavoritesWidget();
          break;
        case 2:
          widget.currentTitle = S.current.account;
          widget.currentPage = AccountWidget();
          break;
//        case 3:
//          widget.currentTitle = 'Messages';
//          widget.currentPage = MessagesWidget();
//          break;
        case 3:
          widget.currentTitle = S.current.notifications;
          widget.currentPage = NotificationsWidget();
          break;
        /*case 5:
          widget.selectedTab = 3;
          widget.currentTitle = 'Chat';
          widget.currentPage = ChatWidget();
          break;*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User _user;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      // endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
//        leading: new IconButton(
//          icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
//          onPressed: () => Navigator.of(context).pop(),
//        ),
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.currentTitle,
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
//          Container(
//              width: 30,
//              height: 30,
//              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//              child: InkWell(
//                  borderRadius: BorderRadius.circular(300),
//                  onTap: () {
//                    Navigator.of(context).pushNamed('/Tabs', arguments: 4);
//                  },
//                  child: CircleAvatar(
//                    backgroundImage: CachedNetworkImageProvider(appUser.avatar),
//                  )
////                FutureBuilder(
////                  future: UserRepository.getUser(),
////                  builder: (
////                      BuildContext context,
////                      AsyncSnapshot<UserResponse> snapshot) {
////                    if (snapshot.hasData) {
////                      if(snapshot.data.error.length > 0 && snapshot.data.error != null) {
////                        print(snapshot.data.error);
////                      }
////                      _user = snapshot.data.user;
////                      return CircleAvatar(
////                        backgroundImage: NetworkImage(_user.avatar),
////                      );
////                    } else if (snapshot.hasError) return Text(
////                      snapshot.data.error
////                    );
////                    else return CircleAvatar(
////                        backgroundImage: NetworkImage(appUser.avatar),
////                      );
////                  },
////                ),
//                  )),
        ],
      ),
      body: widget.currentPage,
//      bottomNavigationBar: CurvedNavigationBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        buttonBackgroundColor: Theme.of(context).accentColor,
//        color: Theme.of(context).focusColor.withOpacity(0.2),
//        height: 60,
//        index: widget.selectedTab,
//        onTap: (int i) {
//          this._selectTab(i);
//        },
//        items: <Widget>[
//          Icon(
//            UiIcons.bell,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.user_1,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.home,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.chat,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.heart,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//        ],
//      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 8,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: widget.selectedTab,
        onTap: (int i) {
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child: new Icon(UiIcons.home,
                    color: Theme.of(context).primaryColor),
              )),
          BottomNavigationBarItem(
            icon: new Icon(UiIcons.heart),
            title: new Container(height: 0.0),
          ),
//          BottomNavigationBarItem(
//            icon: new Icon(UiIcons.chat),
//            title: new Container(height: 0.0),
//          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.user_1),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.bell),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
