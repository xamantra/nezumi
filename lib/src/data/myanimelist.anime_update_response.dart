// To parse this JSON data, do
//
//     final animeUpdateResponse = animeUpdateResponseFromJson(jsonString);

import 'dart:convert';

class AnimeUpdateResponse {
  AnimeUpdateResponse({
    this.status,
    this.score,
    this.numEpisodesWatched,
    this.isRewatching,
    this.updatedAt,
    this.priority,
    this.numTimesRewatched,
    this.rewatchValue,
    this.tags,
    this.comments,
    this.startDate,
    this.finishDate,
  });

  final String status;
  final int score;
  final int numEpisodesWatched;
  final bool isRewatching;
  final DateTime updatedAt;
  final int priority;
  final int numTimesRewatched;
  final int rewatchValue;
  final List<String> tags;
  final String comments;
  final String startDate;
  final String finishDate;

  AnimeUpdateResponse copyWith({
    String status,
    int score,
    int numEpisodesWatched,
    bool isRewatching,
    DateTime updatedAt,
    int priority,
    int numTimesRewatched,
    int rewatchValue,
    List<dynamic> tags,
    String comments,
    String startDate,
    String finishDate,
  }) =>
      AnimeUpdateResponse(
        status: status ?? this.status,
        score: score ?? this.score,
        numEpisodesWatched: numEpisodesWatched ?? this.numEpisodesWatched,
        isRewatching: isRewatching ?? this.isRewatching,
        updatedAt: updatedAt ?? this.updatedAt,
        priority: priority ?? this.priority,
        numTimesRewatched: numTimesRewatched ?? this.numTimesRewatched,
        rewatchValue: rewatchValue ?? this.rewatchValue,
        tags: tags ?? this.tags,
        comments: comments ?? this.comments,
        startDate: startDate ?? this.startDate,
        finishDate: finishDate ?? this.finishDate,
      );

  factory AnimeUpdateResponse.fromRawJson(String str) => AnimeUpdateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeUpdateResponse.fromJson(Map<String, dynamic> json) => AnimeUpdateResponse(
        status: json['status'] == null ? null : json['status'],
        score: json['score'] == null ? null : json['score'],
        numEpisodesWatched: json['num_episodes_watched'] == null ? null : json['num_episodes_watched'],
        isRewatching: json['is_rewatching'] == null ? null : json['is_rewatching'],
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
        priority: json['priority'] == null ? null : json['priority'],
        numTimesRewatched: json['num_times_rewatched'] == null ? null : json['num_times_rewatched'],
        rewatchValue: json['rewatch_value'] == null ? null : json['rewatch_value'],
        tags: json['tags'] == null ? null : List<String>.from(json['tags'].map((x) => x)),
        comments: json['comments'] == null ? null : json['comments'],
        startDate: json['start_date'] == null ? null : json['start_date'],
        finishDate: json['finish_date'] == null ? null : json['finish_date'],
      );

  Map<String, dynamic> toJson() => {
        'status': status == null ? null : status,
        'score': score == null ? null : score,
        'num_episodes_watched': numEpisodesWatched == null ? null : numEpisodesWatched,
        'is_rewatching': isRewatching == null ? null : isRewatching,
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
        'priority': priority == null ? null : priority,
        'num_times_rewatched': numTimesRewatched == null ? null : numTimesRewatched,
        'rewatch_value': rewatchValue == null ? null : rewatchValue,
        'tags': tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        'comments': comments == null ? null : comments,
        'start_date': startDate == null ? null : startDate,
        'finish_date': finishDate == null ? null : finishDate,
      };
}
