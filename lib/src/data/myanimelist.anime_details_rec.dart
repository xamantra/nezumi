import 'dart:convert';

import 'index.dart';

class Recommendation {
  Recommendation({
    this.node,
    this.numRecommendations,
  });

  final EntityDetailsNode node;
  final int numRecommendations;

  Recommendation copyWith({
    EntityDetailsNode node,
    int numRecommendations,
  }) =>
      Recommendation(
        node: node ?? this.node,
        numRecommendations: numRecommendations ?? this.numRecommendations,
      );

  factory Recommendation.fromRawJson(String str) => Recommendation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        node: json['node'] == null ? null : EntityDetailsNode.fromJson(json['node']),
        numRecommendations: json['num_recommendations'] == null ? null : json['num_recommendations'],
      );

  Map<String, dynamic> toJson() => {
        'node': node == null ? null : node.toJson(),
        'num_recommendations': numRecommendations == null ? null : numRecommendations,
      };
}
