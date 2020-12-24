import 'dart:convert';

class MainPicture {
  MainPicture({
    this.medium,
    this.large,
  });

  final String medium;
  final String large;

  MainPicture copyWith({
    String medium,
    String large,
  }) =>
      MainPicture(
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );

  factory MainPicture.fromRawJson(String str) => MainPicture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainPicture.fromJson(Map<String, dynamic> json) => MainPicture(
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}
