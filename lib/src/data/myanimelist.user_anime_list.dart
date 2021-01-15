import 'dart:convert';

import 'index.dart';

class UserAnimeList {
  UserAnimeList({
    this.list,
    this.paging,
  });

  final List<AnimeDetails> list;
  final MalPaging paging;

  List<AnimeDetails> getByStatus(String status) {
    try {
      var result = <AnimeDetails>[];
      result = list?.where((x) => status == "all" || x?.myListStatus?.status == status)?.toList() ?? [];
      return result;
    } catch (e) {
      return [];
    }
  }

  UserAnimeList copyWith({
    List<AnimeDetails> list,
    MalPaging paging,
  }) =>
      UserAnimeList(
        list: list ?? this.list,
        paging: paging ?? this.paging,
      );

  factory UserAnimeList.fromRawJson(String str) => UserAnimeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static UserAnimeList fromJson(Map<String, dynamic> json) {
    try {
      List<AnimeData> data = json["data"] == null ? null : List<AnimeData>.from(json["data"].map((x) => AnimeData.fromJson(x)));
      return UserAnimeList(
        list: (data ?? []).map<AnimeDetails>((x) => AnimeDetails.fromAnimeData(x)).toList(),
        paging: json["paging"] == null ? null : MalPaging.fromJson(json["paging"]),
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    var originalFormat = list.map<AnimeData>((x) => AnimeData.fromAnimeDetails(x)).toList();
    return {
      "data": list == null ? null : List<dynamic>.from(originalFormat.map((x) => x.toJson())),
      "paging": paging == null ? null : paging.toJson(),
    };
  }
}

class AnimeData {
  AnimeData({
    this.node,
    this.listStatus,
  });

  final EntryNode node;
  final AnimeListStatus listStatus;

  AnimeData copyWith({
    EntryNode node,
    AnimeListStatus listStatus,
  }) =>
      AnimeData(
        node: node ?? this.node,
        listStatus: listStatus ?? this.listStatus,
      );

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

  factory AnimeData.fromAnimeDetails(AnimeDetails animeDetails) {
    var from = animeDetails;
    return AnimeData(
      node: EntryNode(
        id: from.id,
        title: from.title,
        mainPicture: from.mainPicture,
        alternativeTitles: from.alternativeTitles,
        startDate: from.startDate,
        endDate: from.endDate,
        synopsis: from.synopsis,
        mean: from.mean,
        rank: from.rank,
        popularity: from.popularity,
        numListUsers: from.numListUsers,
        numScoringUsers: from.numScoringUsers,
        nsfw: from.nsfw,
        createdAt: from.createdAt,
        updatedAt: from.updatedAt,
        mediaType: from.mediaType,
        status: from.status,
        genres: from.genres,
        numEpisodes: from.numEpisodes,
        startSeason: from.startSeason,
        broadcast: from.broadcast,
        source: from.source,
        averageEpisodeDuration: from.averageEpisodeDuration,
        rating: from.rating,
        studios: from.studios,
      ),
      listStatus: animeDetails.myListStatus,
    );
  }
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
    this.nsfw,
  });

  final int id;
  final String title;
  final MalPicture mainPicture;
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
  final String nsfw;

  EntryNode copyWith({
    int id,
    String title,
    MalPicture mainPicture,
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
    String nsfw,
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
        nsfw: nsfw ?? this.nsfw,
      );

  factory EntryNode.fromRawJson(String str) => EntryNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntryNode.fromJson(Map<String, dynamic> json) => EntryNode(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        mainPicture: json["main_picture"] == null ? null : MalPicture.fromJson(json["main_picture"]),
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
        nsfw: json["nsfw"] == null ? null : json["nsfw"],
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
        "nsfw": nsfw == null ? null : nsfw,
      };
}
