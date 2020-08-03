

class Token {
  final String token;
  final String error;

  Token(this.token,this.error);

  Token.fromJson(Map<String, dynamic> json)
      : token = json['results'],
        error = "";

  Token.withError(String errorValue)
      : token = "",
        error = errorValue;
}


