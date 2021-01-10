import 'dart:convert';

class MalPaging {
  MalPaging({
    this.prev,
    this.next,
  });

  final String prev;
  final String next;

  MalPaging copyWith({
    String prev,
    String next,
  }) =>
      MalPaging(
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory MalPaging.fromRawJson(String str) => MalPaging.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MalPaging.fromJson(Map<String, dynamic> json) {
    String prev;
    if (json['prev'] != null) {
      prev = json['prev'];
    }
    if (json['previous'] != null) {
      prev = json['previous'];
    }
    return MalPaging(
      prev: prev,
      next: json["next"] == null ? null : json["next"],
    );
  }

  Map<String, dynamic> toJson() => {
        "prev": prev == null ? null : prev,
        "next": next == null ? null : next,
      };
}
