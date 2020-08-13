import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/src/FlutterProvider/CartProvider/CartProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/RelatedProductProvider.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/RelatedProduct.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/repositories/favorites_repository.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:smartcommercebd/src/utils/helper.dart';
import 'package:smartcommercebd/src/widgets/DrawerWidget.dart';
import 'package:smartcommercebd/src/widgets/HomeSliderWidget.dart';
import 'package:smartcommercebd/src/widgets/ImageZoomingView.dart';
import 'package:smartcommercebd/src/widgets/ProductDetailsTabWidget.dart';
import 'package:smartcommercebd/src/widgets/ProductHomeTabWidget.dart';
import 'package:smartcommercebd/src/widgets/ProductSliderWdget.dart';
import 'package:smartcommercebd/src/widgets/RelatedProductView.dart';
import 'package:smartcommercebd/src/widgets/ReviewsListWidget.dart';
import 'package:smartcommercebd/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Product product;

  Results results;

  ProductWidget({this.results, this.product});

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  int _quantity = 1;

  List<dynamic> _images_list = new List<String>();

  @override
  void initState() {
    _tabController =
        TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);

    if (widget.product.photos != null) {
      _images_list = json.decode(widget.product.photos);

      //print("Imagesss    ${_images_list[0]}");
    }

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

  int current_image = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
/*  print("Product Colors  ${widget.product.price}");
    print("Product  variations ${widget.product.variations}");*/

    print("Result  ==> ${widget.results}");
    print("Product  ==> ${widget.product.photos}");

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.15),
                blurRadius: 5,
                offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              elevation: 16,
              onPressed: () {
                setState(() {
                  print("Cart operation start");
                  addProductToCart(provider, _quantity, widget.product.id);
                });
              },
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Container(
                width: 240,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Add to Cart',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) --_quantity;
                        });
                      },
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(_quantity.toString(),
                        style: Theme.of(context).textTheme.subhead.merge(
                            TextStyle(color: Theme.of(context).primaryColor))),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          ++_quantity;
                        });
                      },
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
//          snap: true,
          floating: true,
//          pinned: true,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
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
          backgroundColor: Theme.of(context).primaryColor,
          expandedHeight: 300,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: InkWell(
              onTap: () {
                print("Image  clicked  ");
                showDialog(
                  context: context,
                  builder: (_) => _images_list.length != 0
                      ? ImageZoomingView(
                          public_path_url + _images_list[current_image])
                      : ImageZoomingView(widget.product.thumbnail_img != null
                          ? public_path_url + widget.product.thumbnail_img
                          : widget.product.image),
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _images_list.length != 0
                      ? new ProductSliderWidget(
                          data: _images_list,
                          changeIndex: (value) {
                            setState(() {
                              current_image = value;
                            });
                            print("The value is  ${value}");
                          },
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  widget.product.thumbnail_img != null
                                      ? public_path_url +
                                          widget.product.thumbnail_img
                                      : widget.product.image),
                            ),
                          ),
                        ),
                  /*Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Theme.of(context).primaryColor,
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0),
                            Theme.of(context).scaffoldBackgroundColor
                          ],
                              stops: [
                            0.0,
                            0.0,
                            0.0,
                            0.0
                          ])),
                    ),*/
                  widget.product.discount != null
                      ? Positioned(
                          top: 80,
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
                              '${widget.product.discount} %',
                              style: Theme.of(context).textTheme.body2.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 15),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2),
                              width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Product"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2),
                              width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Detail"),
                      ),
                    ),
                  ),
//                  Tab(
//                    child: Container(
//                      padding: EdgeInsets.symmetric(horizontal: 5),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(50),
//                          border: Border.all(
//                              color: Theme.of(context)
//                                  .accentColor
//                                  .withOpacity(0.2),
//                              width: 1)),
//                      child: Align(
//                        alignment: Alignment.center,
//                        child: Text("Review"),
//                      ),
//                    ),
//                  ),
                ]),
            Offstage(
              offstage: 0 != _tabIndex,
              child: Column(
                children: <Widget>[
                  ProductHomeTabWidget(product: widget.product),
                ],
              ),
            ),
            Offstage(
              offstage: 1 != _tabIndex,
              child: Column(
                children: <Widget>[
                  ProductDetailsTabWidget(
                    product: widget.product,
                  )
                ],
              ),
            ),
            Offstage(
              offstage: 2 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Product Reviews',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  ReviewsListWidget(
                    product_id: widget.product.id,
                  )
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }


  void addProductToCart(CartProvider provider, quantity, id) async {
    //print("Imageeeeeeeeeeeeeeeee   ${widget.product.thumbnail_img}");

    if (!checkTheProductExist()) {
      print("is_exist ==>  false");

      Map<String, dynamic> cart = {
        "id": widget.product == null ? widget.results.id : widget.product.id,
        "name":
            widget.product == null ? widget.results.name : widget.product.name,
        "images": widget.product == null
            ? widget.results.thumbnailImg.toString()
            : widget.product.image != null
                ? widget.product.image
                : widget.product.thumbnail_img,
        "flashDealDiscount":
            widget.product == null ? "0" : widget.product.discount,
        "productDiscount":
            widget.product == null ? "null" : widget.product.meta_description,
        //  'choice1' : widget.product==null ? "null" : "null",
        //"choice2" : ,
        "quantity": _quantity,
        "unitPrice": widget.product == null
            ? widget.results.unitPrice
            : widget.product.price,
      };

      CommonUtils.cart_list.add(json.encode(cart));

      print("The List  ${CommonUtils.cart_list}");
    }

    await SharedPrefProvider.addCart(CommonUtils.cart_list);

    AwesomeDialog(
            btnOkOnPress: () {},
            context: context,
            dialogType: DialogType.SUCCES,
            body: Text('successfully added to cart'))
        .show();

    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });

    //   print(response.then((value) => print(value)));
  }

  bool checkTheProductExist() {
    bool is_exist = false;

    Map<String, dynamic> cart = {
      "id": widget.product == null ? widget.results.id : widget.product.id,
      "name":
          widget.product == null ? widget.results.name : widget.product.name,
      "images": widget.product == null
          ? widget.results.thumbnailImg.toString()
          : widget.product.image.toString(),
      "flashDealDiscount":
          widget.product == null ? "0" : widget.product.discount,
      "productDiscount":
          widget.product == null ? "null" : widget.product.meta_description,
      /* 'choice1' : widget.product==null ? "null" : "null",
    "choice2" : ,*/
      "quantity": _quantity,
      "unitPrice": widget.product == null
          ? widget.results.unitPrice
          : widget.product.price,
    };

    /*for(int i=0;i< CommonUtils.cart_list.length;i++){
      
      if(CommonUtils.cart_list[i]["id"] == )
    }*/

    CommonUtils.cart_list.forEach((element) async {
      print(
          "Cheeeekk   ${json.decode(element)["id"].toString().contains(widget.product.id)}");
      if (json.decode(element)["id"].toString().contains(widget.product.id)) {
        print("The IDDD is  ${CommonUtils.cart_list.indexOf(element)}");

        //CommonUtils.cart_list.removeAt(CommonUtils.cart_list.indexOf(element));

        CommonUtils.cart_list[CommonUtils.cart_list.indexOf(element)] =
            json.encode(cart);

        print("Cart List   => ${CommonUtils.cart_list} ");
        /*      CommonUtils.cart_list
            .insert(CommonUtils.cart_list.indexOf(element), json.encode(cart));*/

        is_exist = true;
      }

      //print("idd  ${json.decode(element)["id"]}");
    });

    print("is_exist=> ${is_exist}");

    return is_exist;
  }
}
