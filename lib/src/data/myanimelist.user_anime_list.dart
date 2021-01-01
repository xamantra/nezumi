import 'dart:convert';

import 'index.dart';

class UserAnimeList {
  UserAnimeList({
    this.animeList,
    this.paging,
  });

  final List<AnimeData> animeList;
  final Paging paging;

  List<AnimeData> getByStatus(String status) {
    try {
      var result = <AnimeData>[];
      result = animeList?.where((x) => status == "all" || x?.listStatus?.status == status)?.toList() ?? [];
      return result;
    } catch (e) {
      return [];
    }
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

  final EntryNode node;
  final AnimeListStatus listStatus;

  bool seasonMatch(String season) {
    return node?.seasonMatch(season) ?? false;
  }

  AnimeData copyWith({
    EntryNode node,
    AnimeListStatus listStatus,
  }) =>
      AnimeData(
        node: node ?? this.node,
        listStatus: listStatus ?? this.listStatus,
      );

  AnimeData copyFrom(AnimeUpdateResponse response) {
    return copyWith(
      listStatus: AnimeListStatus(
        status: response.status,
        score: response.score,
        numEpisodesWatched: response.numEpisodesWatched,
        isRewatching: response.isRewatching,
        updatedAt: response.updatedAt,
        comments: response.comments,
        tags: response.tags,
        priority: response.priority,
        numTimesRewatched: response.numTimesRewatched,
        rewatchValue: response.rewatchValue,
        startDate: response.startDate,
        finishDate: response.finishDate,
      ),
    );
  }

  factory AnimeData.fromRawJson(String str) => AnimeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        node: json["node"] == null ? null : EntryNode.fromJson(json["node"]),
        listStatus: json["list_status"] == null ? null : AnimeListStatus.fromJson(json["list_status"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node == null ? null : node.toJson(),
        "list_status": listStatus == null ? null : listStatus.toJson(),
      };
}

class EntryNode {
  EntryNode({
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

  bool seasonMatch(String season) {
    return startSeason?.seasonMatch(season) ?? false;
  }

  EntryNode copyWith({
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
      EntryNode(
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

  factory EntryNode.fromRawJson(String str) => EntryNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntryNode.fromJson(Map<String, dynamic> json) => EntryNode(
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
