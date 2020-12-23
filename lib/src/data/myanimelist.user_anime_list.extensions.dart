import 'package:basic_utils/basic_utils.dart';

import 'index.dart';

extension AnimeDataExtensions on AnimeData {
  String get animeStatus {
    try {
      var s = StringUtils.capitalize(node?.status?.replaceAll('_', ' ') ?? '', allWords: true);
      return s;
    } catch (e) {
      return '';
    }
  }

  int get durationPerEpisode {
    try {
      return (node?.averageEpisodeDuration ?? 0) ~/ 60;
    } catch (e) {
      return 0;
    }
  }

  String get episodeCount {
    try {
      if (node.numEpisodes == 0 && (listStatus?.numEpisodesWatched ?? 0) == 0) {
        return '?';
      }
      if (node.numEpisodes == 0 && (listStatus?.numEpisodesWatched ?? 0) != 0) {
        return listStatus?.numEpisodesWatched.toString();
      }
      return node.numEpisodes.toString();
    } catch (e) {
      return '';
    }
  }

  String get realEpisodeCount {
    try {
      return node.numEpisodes == 0 ? '?' : node.numEpisodes?.toString() ?? '?';
    } catch (e) {
      return '';
    }
  }

  String get season {
    try {
      var s = StringUtils.capitalize(node.startSeason?.season ?? "?");
      return '$s ${node.startSeason?.year ?? "?"}';
    } catch (e) {
      return '';
    }
  }

  String get source {
    try {
      var s = StringUtils.capitalize(node?.source?.replaceAll('_', ' ') ?? '', allWords: true);
      return s;
    } catch (e) {
      return '';
    }
  }

  List<String> get studios {
    try {
      return node?.studios?.map((e) => e.name)?.toList() ?? [];
    } catch (e) {
      return [];
    }
  }
}
