import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/product.dart';
import 'package:sunbulahome/src/widgets/BrandHomeTabWidget.dart';
import 'package:sunbulahome/src/widgets/DrawerWidget.dart';
import 'package:sunbulahome/src/widgets/ReviewsListWidget.dart';
import 'package:sunbulahome/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Brand _brand;

  BrandWidget({Key key, this.routeArgument}) {
    _brand = this.routeArgument.argumentsList[0] as Brand;
  }

  @override
  _BrandWidgetState createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  ScrollController _brand_products_scroll_controller;

  //var barndProduct_page = 1;

  @override
  void initState() {
    _tabController =
        TabController(length: 3, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final brand_provider = Provider.of<BrandsProvider>(context);

    _brand_products_scroll_controller = ScrollController()
      ..addListener(() {
        print("Controller listeing ");

        print(_brand_products_scroll_controller.position.pixels);
        print(_brand_products_scroll_controller.position.maxScrollExtent);

        if (_brand_products_scroll_controller.position.pixels ==
            _brand_products_scroll_controller.position.maxScrollExtent - 100) {
          /* setState(() {
            barndProduct_page = barndProduct_page + 1;
          });*/

          brand_provider.setPage(brand_provider.page + 1);

          print("Brand Pageee ${brand_provider.page}");
          print("Brand Pageee  Length  ${brand_provider.brands_list.length}");

          brand_provider.BrandsProductPageination(brand_provider.page);
        }
      });

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(UiIcons.return_icon),
          onPressed: () { Navigator.of(context).pop(); },
        ),
        actions: [
          ShoppingCartButtonWidget()
        ],
      ),
      body: products()
    );
  }

  products() {
    return Consumer<BrandsProvider>(builder: (context, provider, _) {
      print("Product Discription ${provider.brands_product.length} ");
      print("Product Discription ${provider.selectedBrandId} ");

      return provider.brands_product.length > 0
          ? StaggeredGridView.countBuilder(
              //  controller: _brand_products_scroll_controller,
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 15),
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              itemCount: provider.brands_product.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {

                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ProductWidget(product: provider.brands_product[index],)));

                      /* Navigator.of(context).pushNamed('/Product',
                          arguments: new RouteArgument(
                              id: provider.brands_product[index].id,
                              argumentsList: [
                                provider.brands_product[index],
                                "Brands" + provider.brands_product[index].id
                              ]));*/
                    },
                    child: Container(
                      // margin: EdgeInsets.only(left: _marginLeft, right: 20),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          provider.brands_product[index].thumbnail_img == null
                              ? SizedBox(
                                  width: 160,
                                  height: 200,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                    child: Text(
                                      '...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 160,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          "${public_path_url + provider.brands_product[index].thumbnail_img}"),
                                    ),
                                  ),
                                ),
                          Positioned(
                            top: 6,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: Theme.of(context).accentColor),
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                '${provider.brands_product[index].discount} %',
                                style: Theme.of(context).textTheme.body2.merge(
                                    TextStyle(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 170),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            width: 140,
                            height: 113,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.15),
                                      offset: Offset(0, 3),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  provider.brands_product[index].name,
                                  style: Theme.of(context).textTheme.body2,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                                Row(
                                  children: <Widget>[
                                    // The title of the product
                                    Expanded(
                                      child: Text(
                                        '${provider.brands_product[index].sales==null?"0":provider.brands_product[index].available} Sales',
                                        style:
                                            Theme.of(context).textTheme.body1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    Text(
                                      provider.brands_product[index].rate
                                          .toString(),
                                      style: Theme.of(context).textTheme.body2,
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                SizedBox(height: 7),
                                /* Text(
                                    '${provider.brands_product[index].available} Available',
                                    style: Theme.of(context).textTheme.body1,
                                    overflow: TextOverflow.ellipsis,
                                  ),*/
                                /*  AvailableProgressBarWidget(
                                      available: provider
                                          .brands_product[index].available
                                          .toDouble())*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
              },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
