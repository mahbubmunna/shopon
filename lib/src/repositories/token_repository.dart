


import 'package:sunbulahome/src/models/token.dart';
import 'package:sunbulahome/src/providers/token_provider.dart';

class TokenRepository {

  static Future<Token> getToken(Map loginInfo) {
    return TokenProvider.getToken(loginInfo);
  }
}