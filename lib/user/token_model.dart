class TokenModel {
  final String access_token, token_type;

  TokenModel(
    this.access_token,
    this.token_type,
  );

  TokenModel.fromJson(Map<String, dynamic> json)
      : access_token = json['access_token'],
        token_type = json['token_type'];

  Map<String, dynamic> toJson() => {
        'access_token': access_token,
        'token_type': token_type,
      };
}
