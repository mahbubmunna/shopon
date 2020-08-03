import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/repositories/favorites_repository.dart';
import 'package:smartcommercebd/src/utils/helper.dart';
import 'package:smartcommercebd/src/widgets/EmptyFavoritesWidget.dart';
import 'package:smartcommercebd/src/widgets/FavoriteListItemWidget.dart';
import 'package:smartcommercebd/src/widgets/ProductGridItemWidget.dart';
import 'package:smartcommercebd/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  String layout = 'grid';
  List<Product> _productsList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FavoritesRepository.getFavorites(),
      builder:
          (BuildContext context, AsyncSnapshot<FavoritesResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error.length > 0 && snapshot.data.error != null) {
            Common.buildErrorWidget(snapshot.data.error);
          }
          _productsList = snapshot.data.results;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
               /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBarWidget(),
                ),*/
                SizedBox(height: 10),
                Offstage(
                  offstage: _productsList.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.heart,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Wish List',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                this.layout = 'list';
                              });
                            },
                            icon: Icon(
                              Icons.format_list_bulleted,
                              color: this.layout == 'list'
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).focusColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                this.layout = 'grid';
                              });
                            },
                            icon: Icon(
                              Icons.apps,
                              color: this.layout == 'grid'
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).focusColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: this.layout != 'list' || _productsList.isEmpty,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _productsList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return FavoriteListItemWidget(
                        heroTag: 'favorites_list',
                        product: _productsList.elementAt(index),
                        onDismissed: () {
                          setState(() {
                            _productsList.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: this.layout != 'grid' || _productsList.isEmpty,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: new StaggeredGridView.countBuilder(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: _productsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = _productsList.elementAt(index);
                        return ProductGridItemWidget(
                          product: product,
                          heroTag: 'favorites_grid',
                        );
                      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                  ),
                ),
                Offstage(
                  offstage: _productsList.isNotEmpty,
                  child: EmptyFavoritesWidget(),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
