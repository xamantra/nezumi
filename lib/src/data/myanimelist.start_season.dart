import 'dart:convert';

class StartSeason {
  StartSeason({
    this.year,
    this.season,
  });

  final int year;
  final String season;

  StartSeason copyWith({
    int year,
    String season,
  }) =>
      StartSeason(
        year: year ?? this.year,
        season: season ?? this.season,
      );

  factory StartSeason.fromRawJson(String str) => StartSeason.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StartSeason.fromJson(Map<String, dynamic> json) => StartSeason(
        year: json["year"] == null ? null : json["year"],
        season: json["season"] == null ? null : json["season"],
      );

  Map<String, dynamic> toJson() => {
        "year": year == null ? null : year,
        "season": season == null ? null : season,
      };
}
