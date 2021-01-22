import 'dart:convert';

class AnimeDetailStatStatus {
  AnimeDetailStatStatus({
    this.watching,
    this.completed,
    this.onHold,
    this.dropped,
    this.planToWatch,
  });

  final String watching;
  final String completed;
  final String onHold;
  final String dropped;
  final String planToWatch;

  AnimeDetailStatStatus copyWith({
    String watching,
    String completed,
    String onHold,
    String dropped,
    String planToWatch,
  }) =>
      AnimeDetailStatStatus(
        watching: watching ?? this.watching,
        completed: completed ?? this.completed,
        onHold: onHold ?? this.onHold,
        dropped: dropped ?? this.dropped,
        planToWatch: planToWatch ?? this.planToWatch,
      );

  factory AnimeDetailStatStatus.fromRawJson(String str) => AnimeDetailStatStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeDetailStatStatus.fromJson(Map<String, dynamic> json) => AnimeDetailStatStatus(
        watching: json['watching'] == null ? null : json['watching'],
        completed: json['completed'] == null ? null : json['completed'],
        onHold: json['on_hold'] == null ? null : json['on_hold'],
        dropped: json['dropped'] == null ? null : json['dropped'],
        planToWatch: json['plan_to_watch'] == null ? null : json['plan_to_watch'],
      );

  Map<String, dynamic> toJson() => {
        'watching': watching == null ? null : watching,
        'completed': completed == null ? null : completed,
        'on_hold': onHold == null ? null : onHold,
        'dropped': dropped == null ? null : dropped,
        'plan_to_watch': planToWatch == null ? null : planToWatch,
      };
}
