import 'dart:convert';

class AnimeSearchPaging {
  AnimeSearchPaging({
    this.prev,
    this.next,
  });

  final String prev;
  final String next;

  AnimeSearchPaging copyWith({
    String prev,
    String next,
  }) =>
      AnimeSearchPaging(
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory AnimeSearchPaging.fromRawJson(String str) => AnimeSearchPaging.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeSearchPaging.fromJson(Map<String, dynamic> json) {
    String prev;
    if (json['prev'] != null) {
      prev = json['prev'];
    }
    if (json['previous'] != null) {
      prev = json['previous'];
    }
    return AnimeSearchPaging(
      prev: prev,
      next: json["next"] == null ? null : json["next"],
    );
  }

  Map<String, dynamic> toJson() => {
        "prev": prev == null ? null : prev,
        "next": next == null ? null : next,
      };
}
