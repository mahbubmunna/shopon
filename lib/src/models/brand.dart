import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/config/app_config.dart' as config;

class Brand {
  String id;
  String name;
  String logo;
  bool selected;
  double rate;
  List<Product> products;
  Color color;

  Brand(
      {this.name,
      this.logo,
      this.color,
      this.selected,
      this.rate,
      this.products,
      this.id});

/*  Brand.fromJson(List<dynamic> json)
  : logo = '$public_path_url${json['logo']}',
  id = json['id'].toString(),
  name = json['name'],
  selected = false,
  rate = 4.3,
  color = config.Colors().mainColor(1),
  products = (json['products'] as List).map((
      item) => Product.formJson(item)).toList();*/
}

class BrandResponse {
  final List<Brand> results;
  final String error;

  /* BrandResponse.fromJson(Map<String, dynamic> json)
      : results = (json['results'] as List).map(
          (item) => Brand.fromJson(item)).toList(),
        error = "";*/

  BrandResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;

  selectById(String id) {
    this.results.forEach((Brand brand) {
      brand.selected = false;
      if (brand.id == id) {
        brand.selected = true;
      }
    });
  }

  void clearSelection() {
    results.forEach((category) {
      category.selected = false;
    });
  }
}

class BrandsList {
  List<Brand> _list;

  List<Brand> get list => _list;

  /*BrandsList() {
    _list = [
      new Brand('Wilson', 'assets/img/logo-03.svg', Colors.greenAccent, true, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Converse', 'assets/img/logo-04.svg', Colors.cyan, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Umbro', 'assets/img/logo-05.svg', Colors.blueAccent, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Nike', 'assets/img/logo-06.svg', Colors.orange, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Puma', 'assets/img/logo-07.svg', Colors.pinkAccent, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Acer', 'assets/img/logo-08.svg', Colors.deepPurpleAccent, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Reebook', 'assets/img/logo-09.svg', Colors.brown, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Adidas', 'assets/img/logo-10.svg', Colors.blueAccent, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
      new Brand('Crocs', 'assets/img/logo-11.svg', Colors.redAccent, false, 4.3, [
        new Product('Zogaa FlameSweater', 'assets/img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Polo Shirt Brand Clothing', 'assets/img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Polo Shirt for Men', 'assets/img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Sport Pants Long Summer', 'assets/img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men\'s Hoodies Pullovers Striped', 'assets/img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Men Double Breasted Suit Vests', 'assets/img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Puimentiua Summer Fashion', 'assets/img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        new Product('Casual Sweater fashion Jacket', 'assets/img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      ]),
    ];
  }*/

  selectById(String id) {
    this._list.forEach((Brand brand) {
      brand.selected = false;
      if (brand.id == id) {
        brand.selected = true;
      }
    });
  }
}
