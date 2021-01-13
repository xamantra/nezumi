import 'dart:convert';

import 'index.dart';

class AnimeDetailStatistics {
  AnimeDetailStatistics({
    this.status,
    this.numListUsers,
  });

  final AnimeDetailStatStatus status;
  final int numListUsers;

  AnimeDetailStatistics copyWith({
    AnimeDetailStatStatus status,
    int numListUsers,
  }) =>
      AnimeDetailStatistics(
        status: status ?? this.status,
        numListUsers: numListUsers ?? this.numListUsers,
      );

  factory AnimeDetailStatistics.fromRawJson(String str) => AnimeDetailStatistics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeDetailStatistics.fromJson(Map<String, dynamic> json) => AnimeDetailStatistics(
        status: json["status"] == null ? null : AnimeDetailStatStatus.fromJson(json["status"]),
        numListUsers: json["num_list_users"] == null ? null : json["num_list_users"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status.toJson(),
        "num_list_users": numListUsers == null ? null : numListUsers,
      };
}
