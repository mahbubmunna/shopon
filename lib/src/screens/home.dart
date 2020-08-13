import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/BestSellingProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/FlashProvider/FlashProvider.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/BestSell.dart';
import 'package:smartcommercebd/src/models/brand.dart';
import 'package:smartcommercebd/src/models/category.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/screens/product.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:smartcommercebd/src/utils/helper.dart';
import 'package:smartcommercebd/src/widgets/BrandGridWidget.dart';
import 'package:smartcommercebd/src/widgets/BrandsIconsCarouselWidget.dart';
import 'package:smartcommercebd/src/widgets/CategoriesIconsCarouselWidget.dart';
import 'package:smartcommercebd/src/widgets/CategorizedProductsWidget.dart';
import 'package:smartcommercebd/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:smartcommercebd/src/widgets/FlashSalesWidget.dart';
import 'package:smartcommercebd/src/widgets/HomeSliderWidget.dart';
import 'package:smartcommercebd/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:provider/provider.dart';

List<Category> categoriesList;
List<Brand> brandsList;

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  List<Product> _productsOfCategoryList;
  List<Product> _productsOfBrandList;

/*
  ProductsList _productsList = new ProductsList();
*/

  Animation animationOpacity;
  AnimationController animationController;

  ScrollController _brand_scroll_controller;
  ScrollController _brand_products_scroll_controller;
  ScrollController _flash_scroll_controller;
  ScrollController _category_scroll_controller;
  ScrollController _home_scroll_controller;

  //int brand_page = 1;
  int flash_page = 1;
  int category_page = 1;
  int barndProduct_page = 1;

  @override
  void initState() {
    //categoryBloc.getCategories();
    // brandBloc.getBrands();

    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    _home_scroll_controller = new ScrollController()
      ..addListener(() {
        CommonUtils.home_scroll_value = _home_scroll_controller.position.pixels;
      });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    readCats();
    _flash_scroll_controller.dispose();
    _brand_scroll_controller.dispose();
    _category_scroll_controller.dispose();
    _brand_products_scroll_controller.dispose();
    animationController.dispose();
  }

  readCats() async {
    var sp = await SharedPreferences.getInstance();

    if (sp.getStringList(cart_list_key) != null) {
      CommonUtils.cart_list = sp.getStringList(cart_list_key);
    }

    print("Carts List ${CommonUtils.cart_list}");
  }

  @override
  Widget build(BuildContext context) {
    final brand_provider = Provider.of<BrandsProvider>(context);
    final flash_provider = Provider.of<FlashProvider>(context);
    final category_provider = Provider.of<CategoryProvider>(context);

    scroll_operation(brand_provider, flash_provider, category_provider);

    print(" Home  Scrolll   ${CommonUtils.home_scroll_value}");

    return Scaffold(
      body: ListView(
        controller: _home_scroll_controller,
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),*/

          HomeSliderWidget(),

          bestSell(),

//          flashSales(),

          // Heading (Recommended for you)
          Categotys(),
          // Heading (Brands)
          Brands(context, brand_provider)
        ],
      ),
    );
//      ],
//    );
  }

  Column Brands(BuildContext context, BrandsProvider brand_provider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.flag,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              S.of(context).brands,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        StickyHeader(
            header: BrandsIconsCarouselWidget(
              controller: _brand_scroll_controller,
            ),
            content: Container(
              height: MediaQuery.of(context).size.height,
              child: Consumer<BrandsProvider>(builder: (context, provider, _) {
                return !provider.isError
                    ? provider.brands_product.length > 0
                        ? StaggeredGridView.countBuilder(
                            controller: _brand_products_scroll_controller,

                            //  physics: NeverScrollableScrollPhysics(),
                            //physics: _brand_products_scroll_controller!=null ? _brand_products_scroll_controller.position.pixels==0.0 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics() : null,
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 15),
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 2
                                    : 4,
                            itemCount: provider.brands_product.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(new MaterialPageRoute(
                                            builder: (context) => ProductWidget(
                                                  product: provider
                                                      .brands_product[index],
                                                )));

                                    /*Navigator.of(context).pushNamed('/Product',
                                    arguments: new RouteArgument(
                                        id: provider.brands_product[index].id,
                                        argumentsList: [
                                          provider.brands_product[index],
                                          "Brands" +
                                              provider.brands_product[index].id
                                        ]));*/
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(left: _marginLeft, right: 20),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      children: <Widget>[
                                        provider.brands_product[index]
                                                    .thumbnail_img ==
                                                null
                                            ? SizedBox(
                                                width: 160,
                                                height: 200,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.red,
                                                  highlightColor: Colors.yellow,
                                                  child: Text(
                                                    S.of(context).shimmer,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 40.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 160,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                        "${public_path_url}${provider.brands_product[index].thumbnail_img}"),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                                color: Theme.of(context)
                                                    .accentColor),
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            child: Text(
                                              '${provider.brands_product[index].discount} %',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body2
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 175),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          width: 152,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.15),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 10)
                                              ]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: new Container(
                                                  child: Text(
                                                    provider
                                                        .brands_product[index]
                                                        .name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body2,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  // The title of the product
                                                  Expanded(
                                                    child: Text(
                                                      '${provider.brands_product[index].sales == null ? "0" : provider.brands_product[index].sales} ${S.of(context).sales}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .body1,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: false,
                                                    ),
                                                  ),
//                                                  Icon(
//                                                    Icons.star,
//                                                    color: Colors.amber,
//                                                    size: 18,
//                                                  ),
                                                  Text(
                                                    S.of(context).sar+
                                                    provider
                                                        .brands_product[index]
                                                        .price
                                                        .toString(),
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.fit(1),
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )
                    : Center(
                        child: Text(S.of(context).empty),
                      );
              }),
            ))
      ],
    );
  }

  flashSales() {
    return Column(
      children: [
        FlashSalesHeaderWidget(),
        Consumer<FlashProvider>(builder: (context, provider, _) {
          return Container(
            height: 300,
            child: ListView.builder(
              controller: _flash_scroll_controller,
              itemCount: provider.flash_list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => ProductWidget(
                              product: provider.flash_list[index],
                            )));
                    /*   Navigator.of(context).pushNamed('/Product',
                        arguments: new RouteArgument(
                            id: provider.flash_list[index].id,
                            argumentsList: [
                              provider.flash_list[index],
                              "flash" + provider.flash_list[index].id
                            ]));*/
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: _marginLeft, right: 20),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Hero(
                          tag: "flash" + provider.flash_list[index].id,
                          child: provider.flash_list[index].image == null
                              ? SizedBox(
                                  width: 160,
                                  height: 200,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                    child: Text(
                                      S.of(context).shimmer,
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
                                          provider.flash_list[index].image),
                                    ),
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
                              '${provider.flash_list[index].discount} %',
                              style: Theme.of(context).textTheme.body2.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 175),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          width: 152,
                          height: 70,
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: new Container(
                                  child: Text(
                                    provider.flash_list[index].name,
                                    style: Theme.of(context).textTheme.body2,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  // The title of the product
                                  Expanded(
                                    child: Text(
                                      '${provider.flash_list[index].sales == null ? "0" : provider.flash_list[index].sales} ${S.of(context).sales}',
                                      style: Theme.of(context).textTheme.body1,
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
                                    provider.flash_list[index].rate.toString(),
                                    style: Theme.of(context).textTheme.body2,
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              /*SizedBox(height: 7),
                              Text(
                                '${provider.flash_list[index].available} Available',
                                style: Theme.of(context).textTheme.body1,
                                overflow: TextOverflow.ellipsis,
                              ),*/
                              /*    AvailableProgressBarWidget(
                                  available: provider
                                      .flash_list[index].available
                                      .toDouble())*/
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                /*FlashSalesCarouselItemWidget(
            heroTag: this.widget.heroTag,
            marginLeft: _marginLeft,
        product: data.results.elementAt(index),
    )*/
                ;
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        })

/*      FlashSalesCarouselWidget(
          heroTag: 'home_flash_sales',
          productsList: _productsList.flashSalesList),*/
      ],
    );
  }

  bestSell() {
    return Column(
      children: [
        /* FlashSalesHeaderWidget(),*/

        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.megaphone,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              S.of(context).bestSell,
              style: Theme.of(context).textTheme.display1,
            ),
            // trailing: Text('End in $_timer'),
          ),
        ),
        FutureBuilder(
          future: BestSellProvider().getBestSelling(),
          builder: (context, AsyncSnapshot<List<Product>> bestSell) {
            return bestSell.data != null
                ? Container(
                    height: 300,
                    child: ListView.builder(
                      //   controller: _flash_scroll_controller,
                      itemCount: bestSell.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        double _marginLeft = 0;
                        (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ProductWidget(
                                      product: bestSell.data[index],
                                    )));
                            /*   Navigator.of(context).pushNamed('/Product',
                        arguments: new RouteArgument(
                            id: provider.flash_list[index].id,
                            argumentsList: [
                              provider.flash_list[index],
                              "flash" + provider.flash_list[index].id
                            ]));*/
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: _marginLeft, right: 20),
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: <Widget>[
                                bestSell.data[index].thumbnail_img == null
                                    ? SizedBox(
                                        width: 160,
                                        height: 200,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.red,
                                          highlightColor: Colors.yellow,
                                          child: Text(
                                            S.of(context).shimmer,
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                public_path_url +
                                                    bestSell.data[index]
                                                        .thumbnail_img),
                                          ),
                                        ),
                                      ),
                                /*    Positioned(
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
                              '${bestSell.data.results[index].} %',
                              style: Theme.of(context).textTheme.body2.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ),*/
                                Container(
                                  margin: EdgeInsets.only(top: 175),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  width: 152,
                                  height: 70,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          child: Text(
                                            bestSell.data[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2,
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          // The title of the product
                                          Expanded(
                                            child: Text(
                                              '${bestSell.data[index].sales == null ? "0" : bestSell.data[index].sales} ${S.of(context).sales}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                            ),
                                          ),
//                                          Icon(
//                                            Icons.star,
//                                            color: Colors.amber,
//                                            size: 18,
//                                          ),
                                          Text(
                                            S.of(context).sar+bestSell.data[index].price
                                                .toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          )
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                      ),
                                      // SizedBox(height: 7),
                                      /*   Text(
                                '${provider.flash_list[index].available} Available',
                                style: Theme.of(context).textTheme.body1,
                                overflow: TextOverflow.ellipsis,
                              ),*/
                                      /*    AvailableProgressBarWidget(
                                  available: provider
                                      .flash_list[index].available
                                      .toDouble())*/
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        /*FlashSalesCarouselItemWidget(
            heroTag: this.widget.heroTag,
            marginLeft: _marginLeft,
        product: data.results.elementAt(index),
    )*/
                        ;
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                : Container(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, int index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                width: 100,
                                height: 300,
                              ));
                        }),
                  );
          },
        )

/*      FlashSalesCarouselWidget(
          heroTag: 'home_flash_sales',
          productsList: _productsList.flashSalesList),*/
      ],
    );
  }

  Categotys() {
    var provider = Provider.of<CategoryProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.favorites,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              S.of(context).category,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),

        //home_categories_1
        StickyHeader(
            header: CategoriesIconsCarouselWidget(
              heroTag: 'home_categories_1',
              controller: _category_scroll_controller,
            ),
            content:
                Consumer<CategoryProvider>(builder: (context, provider, _) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: CategorizedProductsWidget(
                    animationOpacity: animationOpacity,
                  ));
            })),
      ],
    );
  }

  void scroll_operation(BrandsProvider brand_provider, flash_provider,
      CategoryProvider category_provider) {
    _brand_scroll_controller = ScrollController()
      ..addListener(() {
        print(_brand_scroll_controller.position.pixels);
        print(_brand_scroll_controller.position.maxScrollExtent);

        if (_brand_scroll_controller.position.pixels >
            _brand_scroll_controller.position.maxScrollExtent - 50) {
          /* setState(() {
            brand_page = brand_page + 1;
          });*/

          brand_provider.setPage(brand_provider.page + 1);

          print("Brand Pageee  ${brand_provider.page}");
          print("Brand Pageee  Length   ${brand_provider.brands_list.length}");

          brand_provider.BarndsPageination(brand_provider.page);
        }
      });

    _flash_scroll_controller = ScrollController()
      ..addListener(() {
        print(_flash_scroll_controller.position.pixels);
        print(_flash_scroll_controller.position.maxScrollExtent);

        if (_flash_scroll_controller.position.pixels >
            _flash_scroll_controller.position.maxScrollExtent - 50) {
          setState(() {
            flash_page = flash_page + 1;
          });

          flash_provider.Pageination(flash_page);
        }
      });

    _category_scroll_controller = ScrollController()
      ..addListener(() {
        print(_category_scroll_controller.position.pixels);
        print(_category_scroll_controller.position.maxScrollExtent);

        if (_category_scroll_controller.position.pixels >
            _category_scroll_controller.position.maxScrollExtent - 50) {
          setState(() {
            category_page = category_page + 1;
          });

          category_provider.Categorypagination(category_page);
        }
      });
    _brand_products_scroll_controller = ScrollController()
      ..addListener(() {
        print("Controller listeing ");

        print(_brand_products_scroll_controller.position.pixels);
        print(_brand_products_scroll_controller.position.maxScrollExtent);

        if (_brand_products_scroll_controller.position.pixels ==
            _brand_products_scroll_controller.position.maxScrollExtent) {
          setState(() {
            barndProduct_page = barndProduct_page + 1;
          });

          brand_provider.BrandsProductPageination(barndProduct_page);
        }
      });
  }
}
