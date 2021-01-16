import 'package:basic_utils/basic_utils.dart';

import 'index.dart';

class AnimeDetails {
  AnimeDetails({
    this.id,
    this.title,
    this.mainPicture,
    this.alternativeTitles,
    this.startDate,
    this.endDate,
    this.synopsis,
    this.mean,
    this.rank,
    this.popularity,
    this.numListUsers,
    this.numScoringUsers,
    this.nsfw,
    this.createdAt,
    this.updatedAt,
    this.mediaType,
    this.status,
    this.genres,
    this.myListStatus,
    this.numEpisodes,
    this.startSeason,
    this.broadcast,
    this.source,
    this.averageEpisodeDuration,
    this.rating,
    this.pictures,
    this.background,
    this.relatedAnime,
    this.relatedManga,
    this.recommendations,
    this.studios,
    this.statistics,
  });

  final int id;
  final String title;
  final MalPicture mainPicture;
  final AlternativeTitles alternativeTitles;
  final String startDate;
  final String endDate;
  final String synopsis;
  final double mean;
  final int rank;
  final int popularity;
  final int numListUsers;
  final int numScoringUsers;
  final String nsfw;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String mediaType;
  final String status;
  final List<Genre> genres;
  final AnimeListStatus myListStatus;
  final int numEpisodes;
  final StartSeason startSeason;
  final Broadcast broadcast;
  final String source;
  final int averageEpisodeDuration;
  final String rating;
  final List<MalPicture> pictures;
  final String background;
  final List<RelatedAnime> relatedAnime;
  final List<dynamic> relatedManga;
  final List<Recommendation> recommendations;
  final List<Genre> studios;
  final AnimeDetailStatistics statistics;

  AnimeDetails copyWith({
    int id,
    String title,
    MalPicture mainPicture,
    AlternativeTitles alternativeTitles,
    String startDate,
    String endDate,
    String synopsis,
    double mean,
    int rank,
    int popularity,
    int numListUsers,
    int numScoringUsers,
    String nsfw,
    DateTime createdAt,
    DateTime updatedAt,
    String mediaType,
    String status,
    List<Genre> genres,
    AnimeListStatus myListStatus,
    int numEpisodes,
    StartSeason startSeason,
    Broadcast broadcast,
    String source,
    int averageEpisodeDuration,
    String rating,
    List<MalPicture> pictures,
    String background,
    List<RelatedAnime> relatedAnime,
    List<dynamic> relatedManga,
    List<Recommendation> recommendations,
    List<Genre> studios,
    AnimeDetailStatistics statistics,
  }) =>
      AnimeDetails(
        id: id ?? this.id,
        title: title ?? this.title,
        mainPicture: mainPicture ?? this.mainPicture,
        alternativeTitles: alternativeTitles ?? this.alternativeTitles,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        synopsis: synopsis ?? this.synopsis,
        mean: mean ?? this.mean,
        rank: rank ?? this.rank,
        popularity: popularity ?? this.popularity,
        numListUsers: numListUsers ?? this.numListUsers,
        numScoringUsers: numScoringUsers ?? this.numScoringUsers,
        nsfw: nsfw ?? this.nsfw,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mediaType: mediaType ?? this.mediaType,
        status: status ?? this.status,
        genres: genres ?? this.genres,
        myListStatus: myListStatus ?? this.myListStatus,
        numEpisodes: numEpisodes ?? this.numEpisodes,
        startSeason: startSeason ?? this.startSeason,
        broadcast: broadcast ?? this.broadcast,
        source: source ?? this.source,
        averageEpisodeDuration: averageEpisodeDuration ?? this.averageEpisodeDuration,
        rating: rating ?? this.rating,
        pictures: pictures ?? this.pictures,
        background: background ?? this.background,
        relatedAnime: relatedAnime ?? this.relatedAnime,
        relatedManga: relatedManga ?? this.relatedManga,
        recommendations: recommendations ?? this.recommendations,
        studios: studios ?? this.studios,
        statistics: statistics ?? this.statistics,
      );

  factory AnimeDetails.fromJson(Map<String, dynamic> json) => AnimeDetails(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        mainPicture: json["main_picture"] == null ? null : MalPicture.fromJson(json["main_picture"]),
        alternativeTitles: json["alternative_titles"] == null ? null : AlternativeTitles.fromJson(json["alternative_titles"]),
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
        mean: json["mean"] == null ? 0.0 : json["mean"].toDouble(),
        rank: json["rank"] == null ? 0 : json["rank"],
        popularity: json["popularity"] == null ? 0 : json["popularity"],
        numListUsers: json["num_list_users"] == null ? 0 : json["num_list_users"],
        numScoringUsers: json["num_scoring_users"] == null ? 0 : json["num_scoring_users"],
        nsfw: json["nsfw"] == null ? null : json["nsfw"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        mediaType: json["media_type"] == null ? null : json["media_type"],
        status: json["status"] == null ? null : json["status"],
        genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        myListStatus: json["my_list_status"] == null ? null : AnimeListStatus.fromJson(json["my_list_status"]),
        numEpisodes: json["num_episodes"] == null ? null : json["num_episodes"],
        startSeason: json["start_season"] == null ? null : StartSeason.fromJson(json["start_season"]),
        broadcast: json["broadcast"] == null ? null : Broadcast.fromJson(json["broadcast"]),
        source: json["source"] == null ? null : json["source"],
        averageEpisodeDuration: json["average_episode_duration"] == null ? null : json["average_episode_duration"],
        rating: json["rating"] == null ? null : json["rating"],
        pictures: json["pictures"] == null ? null : List<MalPicture>.from(json["pictures"].map((x) => MalPicture.fromJson(x))),
        background: json["background"] == null ? null : json["background"],
        relatedAnime: json["related_anime"] == null ? null : List<RelatedAnime>.from(json["related_anime"].map((x) => RelatedAnime.fromJson(x))),
        relatedManga: json["related_manga"] == null ? null : List<dynamic>.from(json["related_manga"].map((x) => x)),
        recommendations: json["recommendations"] == null ? null : List<Recommendation>.from(json["recommendations"].map((x) => Recommendation.fromJson(x))),
        studios: json["studios"] == null ? null : List<Genre>.from(json["studios"].map((x) => Genre.fromJson(x))),
        statistics: json["statistics"] == null ? null : AnimeDetailStatistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "main_picture": mainPicture == null ? null : mainPicture.toJson(),
        "alternative_titles": alternativeTitles == null ? null : alternativeTitles.toJson(),
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "synopsis": synopsis == null ? null : synopsis,
        "mean": mean == null ? 0.0 : mean,
        "rank": rank == null ? 0 : rank,
        "popularity": popularity == null ? 0 : popularity,
        "num_list_users": numListUsers == null ? 0 : numListUsers,
        "num_scoring_users": numScoringUsers == null ? 0 : numScoringUsers,
        "nsfw": nsfw == null ? null : nsfw,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "media_type": mediaType == null ? null : mediaType,
        "status": status == null ? null : status,
        "genres": genres == null ? null : List<dynamic>.from(genres.map((x) => x.toJson())),
        "my_list_status": myListStatus == null ? null : myListStatus.toJson(),
        "num_episodes": numEpisodes == null ? null : numEpisodes,
        "start_season": startSeason == null ? null : startSeason.toJson(),
        "broadcast": broadcast == null ? null : broadcast.toJson(),
        "source": source == null ? null : source,
        "average_episode_duration": averageEpisodeDuration == null ? null : averageEpisodeDuration,
        "rating": rating == null ? null : rating,
        "pictures": pictures == null ? null : List<dynamic>.from(pictures.map((x) => x.toJson())),
        "background": background == null ? null : background,
        "related_anime": relatedAnime == null ? null : List<dynamic>.from(relatedAnime.map((x) => x.toJson())),
        "related_manga": relatedManga == null ? null : List<dynamic>.from(relatedManga.map((x) => x)),
        "recommendations": recommendations == null ? null : List<dynamic>.from(recommendations.map((x) => x.toJson())),
        "studios": studios == null ? null : List<dynamic>.from(studios.map((x) => x.toJson())),
        "statistics": statistics == null ? null : statistics.toJson(),
      };

  /* Parsers and Converters */
  factory AnimeDetails.fromAnimeDataItem(AnimeDataItem animeDataItem) {
    var from = animeDataItem.node;
    return AnimeDetails(
      id: from.id,
      title: from.title,
      mainPicture: from.mainPicture,
      alternativeTitles: from.alternativeTitles,
      startDate: from.startDate,
      endDate: from.endDate,
      synopsis: from.synopsis,
      mean: from.mean ?? 0.0,
      rank: from.rank ?? 0,
      popularity: from.popularity ?? 0,
      numListUsers: from.numListUsers ?? 0,
      numScoringUsers: from.numScoringUsers ?? 0,
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
      pictures: [],
      background: null,
      relatedAnime: [],
      relatedManga: [],
      recommendations: [],
      studios: from.studios,
      statistics: null,
    );
  }

  factory AnimeDetails.fromAnimeData(AnimeData animeData) {
    var from = animeData.node;
    return AnimeDetails(
      id: from.id,
      title: from.title,
      mainPicture: from.mainPicture,
      alternativeTitles: from.alternativeTitles,
      startDate: from.startDate,
      endDate: from.endDate,
      synopsis: from.synopsis,
      mean: from.mean ?? 0.0,
      rank: from.rank ?? 0,
      popularity: from.popularity ?? 0,
      numListUsers: from.numListUsers ?? 0,
      numScoringUsers: from.numScoringUsers ?? 0,
      nsfw: from.nsfw,
      createdAt: from.createdAt,
      updatedAt: from.updatedAt,
      mediaType: from.mediaType,
      status: from.status,
      genres: from.genres,
      myListStatus: animeData.listStatus,
      numEpisodes: from.numEpisodes,
      startSeason: from.startSeason,
      broadcast: from.broadcast,
      source: from.source,
      averageEpisodeDuration: from.averageEpisodeDuration,
      rating: from.rating,
      pictures: [],
      background: null,
      relatedAnime: [],
      relatedManga: [],
      recommendations: [],
      studios: from.studios,
      statistics: null,
    );
  }
  /* Parsers and Converters */

  /* Getters */
  String get animeStatus {
    try {
      var s = StringUtils.capitalize(status?.replaceAll('_', ' ') ?? '', allWords: true);
      return s;
    } catch (e) {
      return '';
    }
  }

  int get durationPerEpisode {
    try {
      return (averageEpisodeDuration ?? 0) ~/ 60;
    } catch (e) {
      return 0;
    }
  }

  String get episodeCount {
    try {
      if (numEpisodes == 0 && (myListStatus?.numEpisodesWatched ?? 0) == 0) {
        return '?';
      }
      if (numEpisodes == 0 && (myListStatus?.numEpisodesWatched ?? 0) != 0) {
        return myListStatus?.numEpisodesWatched.toString();
      }
      return numEpisodes.toString();
    } catch (e) {
      return '';
    }
  }

  String get realEpisodeCount {
    try {
      return numEpisodes == 0 ? '?' : numEpisodes?.toString() ?? '?';
    } catch (e) {
      return '';
    }
  }

  String get season {
    try {
      var s = StringUtils.capitalize(startSeason?.season ?? "?");
      return '$s ${startSeason?.year ?? "?"}';
    } catch (e) {
      return '';
    }
  }

  String get sourceFormatted {
    try {
      var s = StringUtils.capitalize(source?.replaceAll('_', ' ') ?? '', allWords: true);
      return s;
    } catch (e) {
      return '';
    }
  }

  List<String> get studiosFormatted {
    try {
      return studios?.map((e) => e.name)?.toList() ?? [];
    } catch (e) {
      return [];
    }
  }

  int get totalDuration {
    var eps = numEpisodes ?? 0;
    var avgD = averageEpisodeDuration ?? 0;
    if (eps == 0) {
      eps = myListStatus?.numEpisodesWatched ?? 0;
      if (eps == 0) {
        eps = 1;
      }
    }
    if (avgD == 0) {
      avgD = 1;
    }
    return (eps * avgD) ~/ 60;
  }
  /* Getters */

  /* Logic */

  /// - Check if season string matches with format `"$year $season"` or `"$season $year"`.
  /// - Case not sensitive.
  /// - *Example:* `"2020 Summer"` or `"Summer 2020"`
  bool seasonMatch(String season) {
    return startSeason?.seasonMatch(season) ?? false;
  }

  bool searchMatch(String query) {
    if (query == null || query.isEmpty) {
      return false;
    }
    var source = title;
    source += '\n${alternativeTitles?.en ?? ""}';
    source += '\n${alternativeTitles?.ja ?? ""}';
    (alternativeTitles?.synonyms ?? []).forEach((title) {
      source += '\n${title ?? ""}';
    });
    return (source ?? '').toLowerCase().contains(query?.toLowerCase() ?? '') ?? false;
  }
  /* Logic */
}
