import 'dart:convert';

class StartSeason {
  StartSeason({
    this.year,
    this.season,
  });

  final int year;
  final String season;

  /// - Check if season string matches with format `"$year $season"` or `"$season $year"`.
  /// - Case not sensitive.
  /// - *Example:* `"2020 Summer"` or `"Summer 2020"`
  bool seasonMatch(String season) {
    if (!seasonValid) return false;
    var s = season.toLowerCase();
    return s == '$year $season' || s == '$season $year';
  }

  bool get seasonValid {
    return year != null && year > 0 && season != null && season.isNotEmpty;
  }

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
