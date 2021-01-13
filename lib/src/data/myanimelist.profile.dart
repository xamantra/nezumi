// To parse this JSON data, do
//
//     final myAnimeListProfile = myAnimeListProfileFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class MyAnimeListProfile {
  MyAnimeListProfile({
    @required this.id,
    @required this.name,
    @required this.gender,
    @required this.birthday,
    @required this.location,
    @required this.joinedAt,
    @required this.picture,
    @required this.animeStatistics,
  });

  final int id;
  final String name;
  final String gender;
  final DateTime birthday;
  final String location;
  final DateTime joinedAt;
  final String picture;
  final Map<String, double> animeStatistics;

  MyAnimeListProfile copyWith({
    int id,
    String name,
    String gender,
    DateTime birthday,
    String location,
    DateTime joinedAt,
    String picture,
    Map<String, double> animeStatistics,
  }) =>
      MyAnimeListProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        location: location ?? this.location,
        joinedAt: joinedAt ?? this.joinedAt,
        picture: picture ?? this.picture,
        animeStatistics: animeStatistics ?? this.animeStatistics,
      );

  factory MyAnimeListProfile.fromRawJson(String str) => MyAnimeListProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyAnimeListProfile.fromJson(Map<String, dynamic> json) {
    try {
      return MyAnimeListProfile(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        location: json["location"],
        joinedAt: json["joined_at"] == null ? null : DateTime.parse(json["joined_at"]),
        picture: json["picture"],
        animeStatistics: json["anime_statistics"] == null ? null : Map.from(json["anime_statistics"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "birthday": birthday == null ? null : "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "location": location,
        "joined_at": joinedAt?.toIso8601String(),
        "picture": picture,
        "anime_statistics": animeStatistics == null ? null : Map.from(animeStatistics).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
