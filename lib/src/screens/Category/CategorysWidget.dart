import 'package:provider/provider.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:smartcommercebd/src/models/brand.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/screens/Category/CategorysGridWidget.dart';
import 'package:smartcommercebd/src/widgets/BrandGridWidget.dart';
import 'package:smartcommercebd/src/widgets/DrawerWidget.dart';
import 'package:smartcommercebd/src/widgets/SearchBarWidget.dart';
import 'package:smartcommercebd/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class CategorysWidget extends StatefulWidget {
  @override
  _CategorysWidgetState createState() => _CategorysWidgetState();
}

class _CategorysWidgetState extends State<CategorysWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            S.of(context).category,
            style: Theme.of(context).textTheme.display1,
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
//            Container(
//                width: 30,
//                height: 30,
//                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//                child: InkWell(
//                  borderRadius: BorderRadius.circular(300),
//                  onTap: () {
//                    Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                  },
//                  child: CircleAvatar(
//                    backgroundImage: AssetImage('assets/img/user2.jpg'),
//                  ),
//                )),
          ],
        ),
        body: Column(
          children: [
          /*  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchBarWidget(),
            ),*/
            Expanded(child: CategorysGridWidget()),
          ],
        ));
  }
}
