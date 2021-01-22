import 'dart:convert';

import 'index.dart';

class EntityDetailsNode {
  EntityDetailsNode({
    this.id,
    this.title,
    this.mainPicture,
  });

  final int id;
  final String title;
  final MalPicture mainPicture;

  EntityDetailsNode copyWith({
    int id,
    String title,
    MalPicture mainPicture,
  }) =>
      EntityDetailsNode(
        id: id ?? this.id,
        title: title ?? this.title,
        mainPicture: mainPicture ?? this.mainPicture,
      );

  factory EntityDetailsNode.fromRawJson(String str) => EntityDetailsNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityDetailsNode.fromJson(Map<String, dynamic> json) => EntityDetailsNode(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        mainPicture: json['main_picture'] == null ? null : MalPicture.fromJson(json['main_picture']),
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'title': title == null ? null : title,
        'main_picture': mainPicture == null ? null : mainPicture.toJson(),
      };
}
