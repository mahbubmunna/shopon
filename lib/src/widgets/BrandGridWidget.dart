import 'package:provider/provider.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BrandGridWidget extends StatefulWidget {
  @override
  _BrandGridWidgetState createState() => _BrandGridWidgetState();
}

class _BrandGridWidgetState extends State<BrandGridWidget> {
  ScrollController _scrollController;

  //var page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brand_provider = Provider.of<BrandsProvider>(context);

    _scrollController = ScrollController()
      ..addListener(() {
        print(_scrollController.position.pixels);
        print(_scrollController.position.maxScrollExtent);

        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100) {
          brand_provider.setPage(brand_provider.page + 1);

          print("Brand Pageee  ${brand_provider.page}");
          print("Brand Pageee  Length   ${brand_provider.brands_list.length}");

          brand_provider.BarndsPageination(brand_provider.page);
        }
      });

    return StaggeredGridView.countBuilder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 4,
      itemCount: brand_provider.brands_list.length,
      itemBuilder: (BuildContext context, int index) {
        Brand brand = brand_provider.brands_list.elementAt(index);

        return InkWell(
          onTap: () {
            print("Brand Iddd  ${brand.id}");
            brand_provider.selecteBrand(brand.id);

            // provider.BrandsProductPageination(1);

            Navigator.of(context).pushNamed('/Brand',
                arguments: new RouteArgument(argumentsList: [brand]));
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
                      "${public_path_url + brand.logo}",
//                  color: Theme.of(context).backgroundColor,
                      width: 80,
                      height: 80,
                    ),

                  ),
                  Text(
                    brand.name,
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
