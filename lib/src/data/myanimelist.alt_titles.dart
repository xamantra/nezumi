import 'dart:convert';

class AlternativeTitles {
  AlternativeTitles({
    this.synonyms,
    this.en,
    this.ja,
  });

  final List<String> synonyms;
  final String en;
  final String ja;

  AlternativeTitles copyWith({
    List<String> synonyms,
    String en,
    String ja,
  }) =>
      AlternativeTitles(
        synonyms: synonyms ?? this.synonyms,
        en: en ?? this.en,
        ja: ja ?? this.ja,
      );

  factory AlternativeTitles.fromRawJson(String str) => AlternativeTitles.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) => AlternativeTitles(
        synonyms: json["synonyms"] == null ? null : List<String>.from(json["synonyms"].map((x) => x)),
        en: json["en"] == null ? null : json["en"],
        ja: json["ja"] == null ? null : json["ja"],
      );

  Map<String, dynamic> toJson() => {
        "synonyms": synonyms == null ? null : List<dynamic>.from(synonyms.map((x) => x)),
        "en": en == null ? null : en,
        "ja": ja == null ? null : ja,
      };
}
