import 'dart:convert';

import 'index.dart';

class AnimeList {
  AnimeList({
    this.list,
    this.paging,
  });

  final List<AnimeDetails> list;
  final MalPaging paging;

  AnimeList copyWith({
    List<AnimeDetails> list,
    MalPaging paging,
  }) =>
      AnimeList(
        list: list ?? this.list,
        paging: paging ?? this.paging,
      );

  factory AnimeList.fromRawJson(String str) => AnimeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static AnimeList fromJson(Map<String, dynamic> json) {
    try {
      List<AnimeDataItem> data = json['data'] == null ? null : List<AnimeDataItem>.from(json['data'].map((x) => AnimeDataItem.fromJson(x)));
      return AnimeList(
        list: (data ?? []).map<AnimeDetails>((x) => AnimeDetails.fromAnimeDataItem(x)).toList(),
        paging: json['paging'] == null ? null : MalPaging.fromJson(json['paging']),
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    var originalFormat = list.map<AnimeDataItem>((x) => AnimeDataItem.fromAnimeDetails(x)).toList();
    return {
      'data': list == null ? null : List<dynamic>.from(originalFormat.map((x) => x.toJson())),
      'paging': paging == null ? null : paging.toJson(),
    };
  }
}

class AnimeDataItem {
  AnimeDataItem({
    this.node,
    this.ranking,
  });

  final SearchNode node;
  final Ranking ranking;

  AnimeDataItem copyWith({
    SearchNode node,
    Ranking ranking,
  }) =>
      AnimeDataItem(
        node: node ?? this.node,
        ranking: ranking ?? this.ranking,
      );

  factory AnimeDataItem.fromRawJson(String str) => AnimeDataItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeDataItem.fromJson(Map<String, dynamic> json) => AnimeDataItem(
        node: json['node'] == null ? null : SearchNode.fromJson(json['node']),
        ranking: json['ranking'] == null ? null : Ranking.fromJson(json['ranking']),
      );

  Map<String, dynamic> toJson() => {
        'node': node == null ? null : node.toJson(),
        'ranking': ranking == null ? null : ranking.toJson(),
      };

  factory AnimeDataItem.fromAnimeDetails(AnimeDetails animeDetails) {
    var from = animeDetails;
    return AnimeDataItem(
      node: SearchNode(
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
        myListStatus: from.myListStatus,
        numEpisodes: from.numEpisodes,
        startSeason: from.startSeason,
        broadcast: from.broadcast,
        source: from.source,
        averageEpisodeDuration: from.averageEpisodeDuration,
        rating: from.rating,
        studios: from.studios,
      ),
      ranking: null,
    );
  }
}

class SearchNode {
  SearchNode({
    this.id,
    this.title,
    this.mainPicture,
    this.myListStatus,
    this.synopsis,
    this.startDate,
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
    this.nsfw,
    this.createdAt,
    this.updatedAt,
    this.mediaType,
    this.startSeason,
    this.broadcast,
    this.averageEpisodeDuration,
    this.endDate,
  });

  final int id;
  final String title;
  final MalPicture mainPicture;
  final AnimeListStatus myListStatus;
  final String synopsis;
  final String startDate;
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
  final String nsfw;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mediaType;
  final StartSeason startSeason;
  final Broadcast broadcast;
  final int averageEpisodeDuration;
  final String endDate;

  SearchNode copyWith({
    int id,
    String title,
    MalPicture mainPicture,
    AnimeListStatus myListStatus,
    String synopsis,
    String startDate,
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
    String nsfw,
    DateTime createdAt,
    DateTime updatedAt,
    String mediaType,
    StartSeason startSeason,
    Broadcast broadcast,
    int averageEpisodeDuration,
    String endDate,
  }) =>
      SearchNode(
        id: id ?? this.id,
        title: title ?? this.title,
        mainPicture: mainPicture ?? this.mainPicture,
        myListStatus: myListStatus ?? this.myListStatus,
        synopsis: synopsis ?? this.synopsis,
        startDate: startDate ?? this.startDate,
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
        nsfw: nsfw ?? this.nsfw,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mediaType: mediaType ?? this.mediaType,
        startSeason: startSeason ?? this.startSeason,
        broadcast: broadcast ?? this.broadcast,
        averageEpisodeDuration: averageEpisodeDuration ?? this.averageEpisodeDuration,
        endDate: endDate ?? this.endDate,
      );

  factory SearchNode.fromRawJson(String str) => SearchNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchNode.fromJson(Map<String, dynamic> json) => SearchNode(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        mainPicture: json['main_picture'] == null ? null : MalPicture.fromJson(json['main_picture']),
        myListStatus: json['my_list_status'] == null ? null : AnimeListStatus.fromJson(json['my_list_status']),
        synopsis: json['synopsis'] == null ? null : json['synopsis'],
        startDate: json['start_date'] == null ? null : json['start_date'],
        alternativeTitles: json['alternative_titles'] == null ? null : AlternativeTitles.fromJson(json['alternative_titles']),
        numEpisodes: json['num_episodes'] == null ? null : json['num_episodes'],
        status: json['status'] == null ? null : json['status'],
        genres: json['genres'] == null ? null : List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
        studios: json['studios'] == null ? null : List<Genre>.from(json['studios'].map((x) => Genre.fromJson(x))),
        rating: json['rating'] == null ? null : json['rating'],
        source: json['source'] == null ? null : json['source'],
        mean: json['mean'] == null ? 0.0 : json['mean'].toDouble(),
        rank: json['rank'] == null ? 0 : json['rank'],
        popularity: json['popularity'] == null ? 0 : json['popularity'],
        numListUsers: json['num_list_users'] == null ? 0 : json['num_list_users'],
        numScoringUsers: json['num_scoring_users'] == null ? 0 : json['num_scoring_users'],
        nsfw: json['nsfw'] == null ? 0 : json['nsfw'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
        mediaType: json['media_type'] == null ? null : json['media_type'],
        startSeason: json['start_season'] == null ? null : StartSeason.fromJson(json['start_season']),
        broadcast: json['broadcast'] == null ? null : Broadcast.fromJson(json['broadcast']),
        averageEpisodeDuration: json['average_episode_duration'] == null ? null : json['average_episode_duration'],
        endDate: json['end_date'] == null ? null : json['end_date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'title': title == null ? null : title,
        'main_picture': mainPicture == null ? null : mainPicture.toJson(),
        'my_list_status': myListStatus == null ? null : myListStatus.toJson(),
        'synopsis': synopsis == null ? null : synopsis,
        'start_date': startDate == null ? null : startDate,
        'alternative_titles': alternativeTitles == null ? null : alternativeTitles.toJson(),
        'num_episodes': numEpisodes == null ? null : numEpisodes,
        'status': status == null ? null : status,
        'genres': genres == null ? null : List<dynamic>.from(genres.map((x) => x.toJson())),
        'studios': studios == null ? null : List<dynamic>.from(studios.map((x) => x.toJson())),
        'rating': rating == null ? null : rating,
        'source': source == null ? null : source,
        'mean': mean == null ? null : mean,
        'rank': rank == null ? null : rank,
        'popularity': popularity == null ? null : popularity,
        'num_list_users': numListUsers == null ? null : numListUsers,
        'num_scoring_users': numScoringUsers == null ? null : numScoringUsers,
        'nsfw': nsfw == null ? null : nsfw,
        'created_at': createdAt == null ? null : createdAt.toIso8601String(),
        'updated_at': updatedAt == null ? null : updatedAt.toIso8601String(),
        'media_type': mediaType == null ? null : mediaType,
        'start_season': startSeason == null ? null : startSeason.toJson(),
        'broadcast': broadcast == null ? null : broadcast.toJson(),
        'average_episode_duration': averageEpisodeDuration == null ? null : averageEpisodeDuration,
        'end_date': endDate == null ? null : endDate,
      };
}
