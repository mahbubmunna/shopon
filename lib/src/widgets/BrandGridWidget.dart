import 'package:provider/provider.dart';
import 'package:smartcommercebd/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/brand.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
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
      padding: EdgeInsets.only(top: 15),
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
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: AlignmentDirectional.topCenter,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.10),
                        offset: Offset(0, 4),
                        blurRadius: 10)
                  ],
                  /* gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          brand.color,
                          brand.color,
                        ])*/
                ),
                child: Image.network('$public_path_url${brand.logo}',
//                  color: Theme.of(context).backgroundColor,
                  width: 80,
                  height: 80,
                ),
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
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      brand.name,
                      style: Theme.of(context).textTheme.body2,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    /*Row(
                      children: <Widget>[
                        // The title of the product
                        */ /*  Expanded(
                          child: Text(
                            '${brand.products.length} Products',
                            style: Theme.of(context).textTheme.body1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),*/ /*
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        Text(
                          brand.rate.toString(),
                          style: Theme.of(context).textTheme.body2,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),*/
                  ],
                ),
              ),
            ],
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
