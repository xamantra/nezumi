// To parse this JSON data, do
//
//     final myAnimeListToken = myAnimeListTokenFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class MyAnimeListToken {
  MyAnimeListToken({
    @required this.tokenType,
    @required this.expiresIn,
    @required this.accessToken,
    @required this.refreshToken,
  });

  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  MyAnimeListToken copyWith({
    String tokenType,
    int expiresIn,
    String accessToken,
    String refreshToken,
  }) =>
      MyAnimeListToken(
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory MyAnimeListToken.fromRawJson(String str) => MyAnimeListToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyAnimeListToken.fromJson(Map<String, dynamic> json) {
    try {
      return MyAnimeListToken(
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'token_type': tokenType,
        'expires_in': expiresIn,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
