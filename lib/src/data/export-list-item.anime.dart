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

  factory ExportAnimeItem.fromAnimeData(AnimeData data) {
    var episodes = data?.node?.numEpisodes ?? 0;
    var duration = data?.node?.averageEpisodeDuration ?? 0;
    duration = duration ~/ 60; // convert from seconds to minutes.
    var totalDuration = episodes * duration;
    return ExportAnimeItem(
      id: data?.node?.id,
      title: data?.node?.title ?? '',
      mean: data?.node?.mean ?? 0,
      userVotes: data?.node?.numScoringUsers ?? 0,
      popularity: data?.node?.numListUsers ?? 0,
      episodes: episodes,
      duration: duration,
      totalDuration: totalDuration,
    );
  }

  factory ExportAnimeItem.fromAnimeDataItem(AnimeDataItem data) {
    var episodes = data?.node?.numEpisodes ?? 0;
    var duration = data?.node?.averageEpisodeDuration ?? 0;
    duration = duration ~/ 60; // convert from seconds to minutes.
    var totalDuration = episodes * duration;
    return ExportAnimeItem(
      id: data?.node?.id,
      title: data?.node?.title ?? '',
      mean: data?.node?.mean ?? 0,
      userVotes: data?.node?.numScoringUsers ?? 0,
      popularity: data?.node?.numListUsers ?? 0,
      episodes: episodes,
      duration: duration,
      totalDuration: totalDuration,
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
    case 'Total Duration':
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
      return 'Total Duration';
  }
  return null;
}
