import 'dart:convert';

class Paging {
  Paging({
    this.next,
  });

  final String next;

  Paging copyWith({
    String next,
  }) =>
      Paging(
        next: next ?? this.next,
      );

  factory Paging.fromRawJson(String str) => Paging.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next == null ? null : next,
      };
}
