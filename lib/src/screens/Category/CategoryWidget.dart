import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/Category/CategoryHomeTabWidget.dart';
import 'package:sunbulahome/src/screens/Category/Products.dart';
import 'package:sunbulahome/src/widgets/BrandHomeTabWidget.dart';
import 'package:sunbulahome/src/widgets/DrawerWidget.dart';
import 'package:sunbulahome/src/widgets/ReviewsListWidget.dart';
import 'package:sunbulahome/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Product product;

  CategoryWidget({Key key, this.product});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  ScrollController scrollController;

  var Product_page = 1;

  @override
  void initState() {
    _tabController =
        TabController(length: 1, initialIndex: _tabIndex, vsync: this);
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
    final provider = Provider.of<CategoryProvider>(context);

    scrollController = new ScrollController()
      ..addListener(() {
        //print("Scroll controller valueeee  ${scrollController.position}");

        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.position.pixels;
        print('Action scroll');
        print(maxScroll);
        print(currentScroll);
        if (currentScroll == maxScroll) {
          setState(() {
            Product_page = Product_page + 1;
          });

          print("Scrolll  finised  ${Product_page}");

          provider.setPage(Product_page);
          provider.CategoryProductsPagination();
        }
      });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(UiIcons.return_icon),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          ShoppingCartButtonWidget()
        ],
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Products()
        ],
      )
    );
  }
}
