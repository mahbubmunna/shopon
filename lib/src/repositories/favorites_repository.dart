

import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/providers/favorite_products_provider.dart';

class FavoritesRepository{

  static Future<FavoritesResponse> getFavorites () {
    return FavoriteApiProvider.getFavorites();
  }

  static Future<dynamic> postDataToCart(Map favoriteData) async{
    return FavoriteApiProvider.postDataToFavorite(favoriteData);
  }
}