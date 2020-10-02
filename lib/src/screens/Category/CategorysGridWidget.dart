import 'package:provider/provider.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sunbulahome/src/screens/Category/CategoryWidget.dart';

class CategorysGridWidget extends StatefulWidget {
  @override
  _CategorysGridWidgetState createState() => _CategorysGridWidgetState();
}

class _CategorysGridWidgetState extends State<CategorysGridWidget> {
  ScrollController _scrollController;

  // var page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    _scrollController = ScrollController()
      ..addListener(() {
        print(_scrollController.position.pixels);
        print(_scrollController.position.maxScrollExtent);

        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100) {
          print("Page Number   ${provider.page}");
          provider.setPage(provider.page + 1);
          provider.Categorypagination(provider.page);
        }
      });

    return StaggeredGridView.countBuilder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 4,
      itemCount: provider.category_list.length,
      itemBuilder: (BuildContext context, int index) {
        Product category = provider.category_list.elementAt(index);

        return InkWell(
          onTap: () {
            provider.setSelectedcategory(category.id);

            provider.CategoryProductsPagination();
/*
            Navigator.of(context).pushNamed('/Brand',
                arguments: new RouteArgument(argumentsList: [category]));*/

            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => CategoryWidget(
                      product: category,
                    )));
          },
          child: Card(
            child: Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.topCenter,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 100,
                    child: Image.network(
                      "${public_path_url + category.icon}",
//                  color: Theme.of(context).backgroundColor,
                      width: 80,
                      height: 80,
                    ),

                  ),
                  Text(
                    category.name,
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  /*   Positioned(
                    right: -50,
                    bottom: -100,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    top: -60,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
    );
  }
}
