// To parse this JSON data, do
//
//     final userAnimeList = userAnimeListFromJson(jsonString);

import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';

class UserAnimeList {
  UserAnimeList({
    this.animeList,
    this.paging,
  });

  final List<AnimeData> animeList;
  final Paging paging;

  List<AnimeData> getByStatus(String status) {
    var result = <AnimeData>[];
    result = animeList?.where((x) => status == "all" || x?.listStatus?.status == status)?.toList() ?? [];
    return result;
  }

  UserAnimeList copyWith({
    List<AnimeData> data,
    Paging paging,
  }) =>
      UserAnimeList(
        animeList: data ?? this.animeList,
        paging: paging ?? this.paging,
      );

  factory UserAnimeList.fromRawJson(String str) => UserAnimeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static UserAnimeList fromJson(Map<String, dynamic> json) => UserAnimeList(
        animeList: json["data"] == null ? null : List<AnimeData>.from(json["data"].map((x) => AnimeData.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "data": animeList == null ? null : List<dynamic>.from(animeList.map((x) => x.toJson())),
        "paging": paging == null ? null : paging.toJson(),
      };
}

class AnimeData {
  AnimeData({
    this.node,
    this.listStatus,
  });

  final Node node;
  final ListStatus listStatus;

  String get animeStatus {
    var s = StringUtils.capitalize(node?.status?.replaceAll('_', ' ') ?? '', allWords: true);
    return s;
  }

  int get durationPerEpisode {
    return (node?.averageEpisodeDuration ?? 0) ~/ 60;
  }

  String get episodeCount {
    if (node.numEpisodes == 0 && (listStatus?.numEpisodesWatched ?? 0) == 0) {
      return '?';
    }
    if (node.numEpisodes == 0 && (listStatus?.numEpisodesWatched ?? 0) != 0) {
      return listStatus?.numEpisodesWatched.toString();
    }
    return node.numEpisodes.toString();
  }

  String get realEpisodeCount {
    return node.numEpisodes == 0 ? '?' : node.numEpisodes?.toString() ?? '?';
  }

  String get season {
    var s = StringUtils.capitalize(node.startSeason?.season ?? "?");
    return '$s ${node.startSeason?.year ?? "?"}';
  }

  String get source {
    var s = StringUtils.capitalize(node?.source?.replaceAll('_', ' ') ?? '', allWords: true);
    return s;
  }

  List<String> get studios {
    return node?.studios?.map((e) => e.name)?.toList() ?? [];
  }

  AnimeData copyWith({
    Node node,
    ListStatus listStatus,
  }) =>
      AnimeData(
        node: node ?? this.node,
        listStatus: listStatus ?? this.listStatus,
      );

  factory AnimeData.fromRawJson(String str) => AnimeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        node: json["node"] == null ? null : Node.fromJson(json["node"]),
        listStatus: json["list_status"] == null ? null : ListStatus.fromJson(json["list_status"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node == null ? null : node.toJson(),
        "list_status": listStatus == null ? null : listStatus.toJson(),
      };
}

class ListStatus {
  ListStatus({
    this.status,
    this.score,
    this.numEpisodesWatched,
    this.isRewatching,
    this.updatedAt,
    this.comments,
    this.tags,
    this.priority,
    this.numTimesRewatched,
    this.rewatchValue,
    this.startDate,
    this.finishDate,
  });

  final String status;
  final int score;
  final int numEpisodesWatched;
  final bool isRewatching;
  final DateTime updatedAt;
  final String comments;
  final List<String> tags;
  final int priority;
  final int numTimesRewatched;
  final int rewatchValue;
  final String startDate;
  final String finishDate;

  ListStatus copyWith({
    String status,
    int score,
    int numEpisodesWatched,
    bool isRewatching,
    DateTime updatedAt,
    String comments,
    List<String> tags,
    int priority,
    int numTimesRewatched,
    int rewatchValue,
    String startDate,
    String finishDate,
  }) =>
      ListStatus(
        status: status ?? this.status,
        score: score ?? this.score,
        numEpisodesWatched: numEpisodesWatched ?? this.numEpisodesWatched,
        isRewatching: isRewatching ?? this.isRewatching,
        updatedAt: updatedAt ?? this.updatedAt,
        comments: comments ?? this.comments,
        tags: tags ?? this.tags,
        priority: priority ?? this.priority,
        numTimesRewatched: numTimesRewatched ?? this.numTimesRewatched,
        rewatchValue: rewatchValue ?? this.rewatchValue,
        startDate: startDate ?? this.startDate,
        finishDate: finishDate ?? this.finishDate,
      );

  factory ListStatus.fromRawJson(String str) => ListStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListStatus.fromJson(Map<String, dynamic> json) => ListStatus(
        status: json["status"] == null ? null : json["status"],
        score: json["score"] == null ? null : json["score"],
        numEpisodesWatched: json["num_episodes_watched"] == null ? null : json["num_episodes_watched"],
        isRewatching: json["is_rewatching"] == null ? null : json["is_rewatching"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        comments: json["comments"] == null ? null : json["comments"],
        tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
        priority: json["priority"] == null ? null : json["priority"],
        numTimesRewatched: json["num_times_rewatched"] == null ? null : json["num_times_rewatched"],
        rewatchValue: json["rewatch_value"] == null ? null : json["rewatch_value"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        finishDate: json["finish_date"] == null ? null : json["finish_date"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "score": score == null ? null : score,
        "num_episodes_watched": numEpisodesWatched == null ? null : numEpisodesWatched,
        "is_rewatching": isRewatching == null ? null : isRewatching,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "comments": comments == null ? null : comments,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "priority": priority == null ? null : priority,
        "num_times_rewatched": numTimesRewatched == null ? null : numTimesRewatched,
        "rewatch_value": rewatchValue == null ? null : rewatchValue,
        "start_date": startDate == null ? null : startDate,
        "finish_date": finishDate == null ? null : finishDate,
      };
}

class Node {
  Node({
    this.id,
    this.title,
    this.mainPicture,
    this.synopsis,
    this.startDate,
    this.endDate,
    this.alternativeTitles,
    this.numEpisodes,
    this.status,
    this.genres,
    this.studios,
    this.rating,
    this.source,
    this.mean,
    this.rank,
    this.popularity,
    this.numListUsers,
    this.numScoringUsers,
    this.createdAt,
    this.updatedAt,
    this.mediaType,
    this.startSeason,
    this.averageEpisodeDuration,
    this.broadcast,
  });

  final int id;
  final String title;
  final MainPicture mainPicture;
  final String synopsis;
  final String startDate;
  final String endDate;
  final AlternativeTitles alternativeTitles;
  final int numEpisodes;
  final String status;
  final List<Genre> genres;
  final List<Genre> studios;
  final String rating;
  final String source;
  final double mean;
  final int rank;
  final int popularity;
  final int numListUsers;
  final int numScoringUsers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mediaType;
  final StartSeason startSeason;
  final int averageEpisodeDuration;
  final Broadcast broadcast;

  Node copyWith({
    int id,
    String title,
    MainPicture mainPicture,
    String synopsis,
    String startDate,
    String endDate,
    AlternativeTitles alternativeTitles,
    int numEpisodes,
    String status,
    List<Genre> genres,
    List<Genre> studios,
    String rating,
    String source,
    double mean,
    int rank,
    int popularity,
    int numListUsers,
    int numScoringUsers,
    DateTime createdAt,
    DateTime updatedAt,
    String mediaType,
    StartSeason startSeason,
    int averageEpisodeDuration,
    Broadcast broadcast,
  }) =>
      Node(
        id: id ?? this.id,
        title: title ?? this.title,
        mainPicture: mainPicture ?? this.mainPicture,
        synopsis: synopsis ?? this.synopsis,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        alternativeTitles: alternativeTitles ?? this.alternativeTitles,
        numEpisodes: numEpisodes ?? this.numEpisodes,
        status: status ?? this.status,
        genres: genres ?? this.genres,
        studios: studios ?? this.studios,
        rating: rating ?? this.rating,
        source: source ?? this.source,
        mean: mean ?? this.mean,
        rank: rank ?? this.rank,
        popularity: popularity ?? this.popularity,
        numListUsers: numListUsers ?? this.numListUsers,
        numScoringUsers: numScoringUsers ?? this.numScoringUsers,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mediaType: mediaType ?? this.mediaType,
        startSeason: startSeason ?? this.startSeason,
        averageEpisodeDuration: averageEpisodeDuration ?? this.averageEpisodeDuration,
        broadcast: broadcast ?? this.broadcast,
      );

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        mainPicture: json["main_picture"] == null ? null : MainPicture.fromJson(json["main_picture"]),
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        alternativeTitles: json["alternative_titles"] == null ? null : AlternativeTitles.fromJson(json["alternative_titles"]),
        numEpisodes: json["num_episodes"] == null ? null : json["num_episodes"],
        status: json["status"] == null ? null : json["status"],
        genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        studios: json["studios"] == null ? null : List<Genre>.from(json["studios"].map((x) => Genre.fromJson(x))),
        rating: json["rating"] == null ? null : json["rating"],
        source: json["source"] == null ? null : json["source"],
        mean: json["mean"] == null ? null : json["mean"].toDouble(),
        rank: json["rank"] == null ? null : json["rank"],
        popularity: json["popularity"] == null ? null : json["popularity"],
        numListUsers: json["num_list_users"] == null ? null : json["num_list_users"],
        numScoringUsers: json["num_scoring_users"] == null ? null : json["num_scoring_users"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        mediaType: json["media_type"] == null ? null : json["media_type"],
        startSeason: json["start_season"] == null ? null : StartSeason.fromJson(json["start_season"]),
        averageEpisodeDuration: json["average_episode_duration"] == null ? null : json["average_episode_duration"],
        broadcast: json["broadcast"] == null ? null : Broadcast.fromJson(json["broadcast"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "main_picture": mainPicture == null ? null : mainPicture.toJson(),
        "synopsis": synopsis == null ? null : synopsis,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "alternative_titles": alternativeTitles == null ? null : alternativeTitles.toJson(),
        "num_episodes": numEpisodes == null ? null : numEpisodes,
        "status": status == null ? null : status,
        "genres": genres == null ? null : List<dynamic>.from(genres.map((x) => x.toJson())),
        "studios": studios == null ? null : List<dynamic>.from(studios.map((x) => x.toJson())),
        "rating": rating == null ? null : rating,
        "source": source == null ? null : source,
        "mean": mean == null ? null : mean,
        "rank": rank == null ? null : rank,
        "popularity": popularity == null ? null : popularity,
        "num_list_users": numListUsers == null ? null : numListUsers,
        "num_scoring_users": numScoringUsers == null ? null : numScoringUsers,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "media_type": mediaType == null ? null : mediaType,
        "start_season": startSeason == null ? null : startSeason.toJson(),
        "average_episode_duration": averageEpisodeDuration == null ? null : averageEpisodeDuration,
        "broadcast": broadcast == null ? null : broadcast.toJson(),
      };
}

class AlternativeTitles {
  AlternativeTitles({
    this.synonyms,
    this.en,
    this.ja,
  });

  final List<String> synonyms;
  final String en;
  final String ja;

  AlternativeTitles copyWith({
    List<String> synonyms,
    String en,
    String ja,
  }) =>
      AlternativeTitles(
        synonyms: synonyms ?? this.synonyms,
        en: en ?? this.en,
        ja: ja ?? this.ja,
      );

  factory AlternativeTitles.fromRawJson(String str) => AlternativeTitles.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) => AlternativeTitles(
        synonyms: json["synonyms"] == null ? null : List<String>.from(json["synonyms"].map((x) => x)),
        en: json["en"] == null ? null : json["en"],
        ja: json["ja"] == null ? null : json["ja"],
      );

  Map<String, dynamic> toJson() => {
        "synonyms": synonyms == null ? null : List<dynamic>.from(synonyms.map((x) => x)),
        "en": en == null ? null : en,
        "ja": ja == null ? null : ja,
      };
}

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

class Genre {
  Genre({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  Genre copyWith({
    int id,
    String name,
  }) =>
      Genre(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class MainPicture {
  MainPicture({
    this.medium,
    this.large,
  });

  final String medium;
  final String large;

  MainPicture copyWith({
    String medium,
    String large,
  }) =>
      MainPicture(
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );

  factory MainPicture.fromRawJson(String str) => MainPicture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainPicture.fromJson(Map<String, dynamic> json) => MainPicture(
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}

class StartSeason {
  StartSeason({
    this.year,
    this.season,
  });

  final int year;
  final String season;

  StartSeason copyWith({
    int year,
    String season,
  }) =>
      StartSeason(
        year: year ?? this.year,
        season: season ?? this.season,
      );

  factory StartSeason.fromRawJson(String str) => StartSeason.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StartSeason.fromJson(Map<String, dynamic> json) => StartSeason(
        year: json["year"] == null ? null : json["year"],
        season: json["season"] == null ? null : json["season"],
      );

  Map<String, dynamic> toJson() => {
        "year": year == null ? null : year,
        "season": season == null ? null : season,
      };
}

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
