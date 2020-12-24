import 'dart:convert';

class Broadcast {
  Broadcast({
    this.dayOfTheWeek,
    this.startTime,
  });

  final String dayOfTheWeek;
  final String startTime;

  Broadcast copyWith({
    String dayOfTheWeek,
    String startTime,
  }) =>
      Broadcast(
        dayOfTheWeek: dayOfTheWeek ?? this.dayOfTheWeek,
        startTime: startTime ?? this.startTime,
      );

  factory Broadcast.fromRawJson(String str) => Broadcast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        dayOfTheWeek: json["day_of_the_week"] == null ? null : json["day_of_the_week"],
        startTime: json["start_time"] == null ? null : json["start_time"],
      );

  Map<String, dynamic> toJson() => {
        "day_of_the_week": dayOfTheWeek == null ? null : dayOfTheWeek,
        "start_time": startTime == null ? null : startTime,
      };
}
