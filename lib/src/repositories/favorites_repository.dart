

import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/providers/favorite_products_provider.dart';

class FavoritesRepository{

  static Future<FavoritesResponse> getFavorites () {
    return FavoriteApiProvider.getFavorites();
  }

  static Future<dynamic> postDataToCart(Map favoriteData) async{
    return FavoriteApiProvider.postDataToFavorite(favoriteData);
  }
}