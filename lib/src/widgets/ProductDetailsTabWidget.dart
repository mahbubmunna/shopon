import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailsTabWidget extends StatefulWidget {
  Product product;

//  ProductsList _productsList = new ProductsList();

  ProductDetailsTabWidget({this.product});

  @override
  ProductDetailsTabWidgetState createState() => ProductDetailsTabWidgetState();
}

class ProductDetailsTabWidgetState extends State<ProductDetailsTabWidget> {
  @override
  Widget build(BuildContext context) {
    print("Product  ${widget.product}");
    print("Description  ${widget.product.description}");
    print("Description  ${widget.product.meta_description}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.file_2,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              S.of(context).description,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text('${widget.product.description}'),
        ),*/

        widget.product.description != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: SingleChildScrollView(
                  child: Html(data: widget.product.description),
                ),
              )
            : Padding(padding:   const EdgeInsets.symmetric(horizontal: 20, vertical: 8), child: Text("${widget.product.meta_description}") ),
      ],
    );
  }
}

class SelectColorWidget extends StatefulWidget {
  SelectColorWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.black45,
    Colors.orange,
  ];

  Color _selectedColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _colors.map((color) {
        return buildColor(color, _selectedColor);
      }).toList(),
    );
  }

  SizedBox buildColor(color, selectedColor) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: color,
        selectedColor: color,
        selected: selectedColor == color,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            this._selectedColor = color;
          });
        },
      ),
    );
  }
}

class SelectSizeWidget extends StatefulWidget {
  SelectSizeWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectSizeWidgetState createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _sizes.map((size) {
        return buildSize(size, _selectedSize);
      }).toList(),
    );
  }

  SizedBox buildSize(size, selectedSize) {
    return SizedBox(
//      width: 38,
      height: 38,
      child: RawChip(
        label: Text(size),
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
        selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
        selected: selectedSize == size,
        shape: StadiumBorder(
            side: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.05))),
//        avatar: Icon(Icons.check_circle),
        onSelected: (bool value) {
          setState(() {
            this._selectedSize = size;
          });
        },
      ),
    );
  }
}
