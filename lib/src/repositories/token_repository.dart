


import 'package:smartcommercebd/src/models/token.dart';
import 'package:smartcommercebd/src/providers/token_provider.dart';

class TokenRepository {

  static Future<Token> getToken(Map loginInfo) {
    return TokenProvider.getToken(loginInfo);
  }
}