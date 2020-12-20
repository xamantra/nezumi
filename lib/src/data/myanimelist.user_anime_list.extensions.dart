import 'package:basic_utils/basic_utils.dart';

import 'index.dart';

extension AnimeDataExtensions on AnimeData {
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
}
