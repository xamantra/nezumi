import 'package:flutter/foundation.dart';

import 'index.dart';

class Account {
  Account({
    @required this.token,
    @required this.profile,
    this.csrfToken,
  });

  final MyAnimeListToken token;
  final MyAnimeListProfile profile;
  final String csrfToken;

  Map<String, dynamic> toJson() {
    return {
      'token': token?.toJson(),
      'profile': profile?.toJson(),
      'csrfToken': csrfToken,
    };
  }

  factory Account.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return Account(
      token: MyAnimeListToken.fromJson(map['token']),
      profile: MyAnimeListProfile.fromJson(map['profile']),
      csrfToken: map['csrfToken'],
    );
  }
}
