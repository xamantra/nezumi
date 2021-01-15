import 'package:dart_extensions/dart_extensions.dart';
import 'package:intl/intl.dart';

import 'index.dart';

class UserAnimeHistory {
  final List<AnimeHistory> list;

  UserAnimeHistory({
    this.list,
  });

  Map<String, dynamic> toJson() {
    return {
      'list': list?.map((x) => x?.toJson())?.toList(),
    };
  }

  factory UserAnimeHistory.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserAnimeHistory(
      list: List<AnimeHistory>.from(map['list']?.map((x) => AnimeHistory.fromJson(x)) ?? []),
    );
  }

  Map<String, List<AnimeHistory>> get groupByDay {
    var result = list.groupBy<AnimeHistory, String>((e) {
      var f = DateFormat('MMMM dd');
      var group = f.format(e.timestamp);
      return group;
    });
    return result;
  }

  UserAnimeHistory bindDurations(UserAnimeList fromList) {
    var binded = <AnimeHistory>[];
    for (var item in list) {
      var anime = fromList?.list?.find((x) => x.id == item.id);
      var d = Duration(seconds: anime?.averageEpisodeDuration ?? 0);
      var n = item.copyWith(durationMins: d.inMinutes);
      binded.add(n);
    }
    return UserAnimeHistory(list: binded);
  }
}

class AnimeHistory {
  final int id;
  final String title;
  final String episode;
  final DateTime timestamp;
  final int durationMins;

  AnimeHistory({
    this.id,
    this.title,
    this.episode,
    this.timestamp,
    this.durationMins,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'episode': episode,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'durationMins': durationMins,
    };
  }

  factory AnimeHistory.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    try {
      return AnimeHistory(
        id: map['id'],
        title: map['title'],
        episode: map['episode'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
        durationMins: map['durationMins'],
      );
    } catch (e) {
      return null;
    }
  }

  AnimeHistory copyWith({
    int id,
    String title,
    String episode,
    DateTime timestamp,
    int durationMins,
  }) {
    return AnimeHistory(
      id: id ?? this.id,
      title: title ?? this.title,
      episode: episode ?? this.episode,
      timestamp: timestamp ?? this.timestamp,
      durationMins: durationMins ?? this.durationMins,
    );
  }
}
