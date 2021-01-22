import 'dart:convert';

import 'index.dart';

class RelatedAnime {
  RelatedAnime({
    this.node,
    this.relationType,
    this.relationTypeFormatted,
  });

  final EntityDetailsNode node;
  final String relationType;
  final String relationTypeFormatted;

  RelatedAnime copyWith({
    EntityDetailsNode node,
    String relationType,
    String relationTypeFormatted,
  }) =>
      RelatedAnime(
        node: node ?? this.node,
        relationType: relationType ?? this.relationType,
        relationTypeFormatted: relationTypeFormatted ?? this.relationTypeFormatted,
      );

  factory RelatedAnime.fromRawJson(String str) => RelatedAnime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RelatedAnime.fromJson(Map<String, dynamic> json) => RelatedAnime(
        node: json['node'] == null ? null : EntityDetailsNode.fromJson(json['node']),
        relationType: json['relation_type'] == null ? null : json['relation_type'],
        relationTypeFormatted: json['relation_type_formatted'] == null ? null : json['relation_type_formatted'],
      );

  Map<String, dynamic> toJson() => {
        'node': node == null ? null : node.toJson(),
        'relation_type': relationType == null ? null : relationType,
        'relation_type_formatted': relationTypeFormatted == null ? null : relationTypeFormatted,
      };
}
