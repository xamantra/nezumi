import 'package:meta/meta.dart';

import 'index.dart';

class ExportAnimeItem {
  final int id;
  final String title;
  final double mean;
  final int userVotes;
  final int popularity;
  final int episodes;
  final int duration;
  final int totalDuration;

  ExportAnimeItem({
    this.id,
    @required this.title,
    this.mean,
    this.userVotes,
    this.popularity,
    this.episodes,
    this.duration,
    this.totalDuration,
  });

  factory ExportAnimeItem.fromAnimeData(AnimeDetails data) {
    var episodes = data?.numEpisodes ?? 0;
    var duration = data?.averageEpisodeDuration ?? 0;
    duration = duration ~/ 60; // convert from seconds to minutes.
    var totalDuration = episodes * duration;
    return ExportAnimeItem(
      id: data?.id,
      title: data?.title ?? '',
      mean: data?.mean ?? 0,
      userVotes: data?.numScoringUsers ?? 0,
      popularity: data?.numListUsers ?? 0,
      episodes: episodes,
      duration: duration,
      totalDuration: totalDuration,
    );
  }

  factory ExportAnimeItem.fromAnimeDataItem(AnimeDetails data) {
    var episodes = data?.numEpisodes ?? 0;
    var duration = data?.averageEpisodeDuration ?? 0;
    duration = duration ~/ 60; // convert from seconds to minutes.
    var totalDuration = episodes * duration;
    return ExportAnimeItem(
      id: data?.id,
      title: data?.title ?? '',
      mean: data?.mean ?? 0,
      userVotes: data?.numScoringUsers ?? 0,
      popularity: data?.numListUsers ?? 0,
      episodes: episodes,
      duration: duration,
      totalDuration: totalDuration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'mean': mean,
      'userVotes': userVotes,
      'popularity': popularity,
      'episodes': episodes,
      'duration': duration,
      'totalDuration': totalDuration,
    };
  }

  factory ExportAnimeItem.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ExportAnimeItem(
      id: json['id'],
      title: json['title'],
      mean: json['mean'],
      userVotes: json['userVotes'],
      popularity: json['popularity'],
      episodes: json['episodes'],
      duration: json['duration'],
      totalDuration: json['totalDuration'],
    );
  }
}

enum ExportAnimeField {
  id,
  title,
  mean,
  userVotes,
  popularity,
  episodes,
  duration,
  totalDuration,
}

ExportAnimeField toExportAnimeField(String label) {
  switch (label) {
    case 'Id':
      return ExportAnimeField.id;
    case 'Title':
      return ExportAnimeField.title;
    case 'Mean':
      return ExportAnimeField.mean;
    case 'User Votes':
      return ExportAnimeField.userVotes;
    case 'Popularity':
      return ExportAnimeField.popularity;
    case 'Episodes':
      return ExportAnimeField.episodes;
    case 'Duration':
      return ExportAnimeField.duration;
    case 'Total Duration (mins)':
      return ExportAnimeField.totalDuration;
  }
  return null;
}

String toLabelExportAnimeField(ExportAnimeField field) {
  switch (field) {
    case ExportAnimeField.id:
      return 'Id';
    case ExportAnimeField.title:
      return 'Title';
    case ExportAnimeField.mean:
      return 'Mean';
    case ExportAnimeField.userVotes:
      return 'User Votes';
    case ExportAnimeField.popularity:
      return 'Popularity';
    case ExportAnimeField.episodes:
      return 'Episodes';
    case ExportAnimeField.duration:
      return 'Duration';
    case ExportAnimeField.totalDuration:
      return 'Total Duration (mins)';
  }
  return null;
}

enum ExportAnimeType {
  markdownTable,
  json,
  jsonForCsvExport,
}

ExportAnimeType toExportAnimeType(String label) {
  switch (label) {
    case 'Markdown Table':
      return ExportAnimeType.markdownTable;
    case 'JSON':
      return ExportAnimeType.json;
    case 'JSON for CSV Export':
      return ExportAnimeType.jsonForCsvExport;
  }
  return null;
}

String toLabelExportAnimeType(ExportAnimeType type) {
  switch (type) {
    case ExportAnimeType.markdownTable:
      return 'Markdown Table';
    case ExportAnimeType.json:
      return 'JSON';
    case ExportAnimeType.jsonForCsvExport:
      return 'JSON for CSV Export';
  }
  return null;
}
