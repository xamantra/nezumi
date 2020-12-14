// To parse this JSON data, do
//
//     final userAnimeList = userAnimeListFromJson(jsonString);

import 'dart:convert';

class UserAnimeList {
  UserAnimeList({
    this.animeList,
    this.paging,
  });

  final List<AnimeData> animeList;
  final Paging paging;

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
  });

  final AnimeInfo node;

  AnimeData copyWith({
    AnimeInfo node,
  }) =>
      AnimeData(
        node: node ?? this.node,
      );

  factory AnimeData.fromRawJson(String str) => AnimeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeData.fromJson(Map<String, dynamic> json) => AnimeData(
        node: json["node"] == null ? null : AnimeInfo.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node == null ? null : node.toJson(),
      };
}

class AnimeInfo {
  AnimeInfo({
    this.id,
    this.title,
    this.mainPicture,
    this.averageEpisodeDuration,
    this.numEpisodes,
  });

  final int id;
  final String title;
  final MainPicture mainPicture;
  final int averageEpisodeDuration;
  final int numEpisodes;

  AnimeInfo copyWith({
    int id,
    String title,
    MainPicture mainPicture,
    int averageEpisodeDuration,
    int numEpisodes,
  }) =>
      AnimeInfo(
        id: id ?? this.id,
        title: title ?? this.title,
        mainPicture: mainPicture ?? this.mainPicture,
        averageEpisodeDuration: averageEpisodeDuration ?? this.averageEpisodeDuration,
        numEpisodes: numEpisodes ?? this.numEpisodes,
      );

  factory AnimeInfo.fromRawJson(String str) => AnimeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnimeInfo.fromJson(Map<String, dynamic> json) => AnimeInfo(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        mainPicture: json["main_picture"] == null ? null : MainPicture.fromJson(json["main_picture"]),
        averageEpisodeDuration: json["average_episode_duration"] == null ? null : json["average_episode_duration"],
        numEpisodes: json["num_episodes"] == null ? null : json["num_episodes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "main_picture": mainPicture == null ? null : mainPicture.toJson(),
        "average_episode_duration": averageEpisodeDuration == null ? null : averageEpisodeDuration,
        "num_episodes": numEpisodes == null ? null : numEpisodes,
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
