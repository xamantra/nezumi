import 'dart:convert';

class MalPicture {
  MalPicture({
    this.medium,
    this.large,
  });

  final String medium;
  final String large;

  MalPicture copyWith({
    String medium,
    String large,
  }) =>
      MalPicture(
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );

  factory MalPicture.fromRawJson(String str) => MalPicture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MalPicture.fromJson(Map<String, dynamic> json) => MalPicture(
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}
