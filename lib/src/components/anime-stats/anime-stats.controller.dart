import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeStatsController extends MomentumController<AnimeStatsModel> with CoreMixin {
  @override
  AnimeStatsModel init() {
    return AnimeStatsModel(
      this,
    );
  }

  List<AnimeGenreStatData> getGenreStatItems() {
    var entries = animeCache?.rendered_user_list ?? [];
    var genreList = getAllGenre(entries);
    var result = <AnimeGenreStatData>[];
    for (var genre in genreList) {
      var grouped = entries.where((x) => x.genres.any((g) => g.name == genre) && mustCountOnStats(x)).toList();
      var totalEpisodes = 0;
      var totalHours = 0.0;
      var scores = <ScoreData>[];
      grouped.forEach((anime) {
        var score = anime.myListStatus?.score?.toDouble() ?? 0.0;
        var episodes = anime.myListStatus?.numEpisodesWatched ?? 0;
        var duration = (((anime.averageEpisodeDuration ?? 0.0) / 60)) / 60;
        totalEpisodes += episodes;
        totalHours += duration * episodes;
        if (score > 0) {
          scores.add(
            ScoreData(
              score: anime.myListStatus?.score?.toDouble() ?? 0.0,
              weight: totalHours * 60, // weighted by total minutes watched.
            ),
          );
        }
      });
      var weight = WeightScores(scores);
      result.add(
        AnimeGenreStatData(
          genre: genre,
          entries: grouped,
          totalEpisodes: totalEpisodes,
          totalHours: totalHours,
          weightedMean: weight.getWeightedMean(2),
        ),
      );
    }
    result.sort((a, b) => b.entries.length.compareTo(a.entries.length));
    return result;
  }

  List<String> getAllGenre(List<AnimeDetails> from) {
    var result = <String>[];
    for (var anime in from) {
      var genreList = anime?.genres ?? [];
      result.addAll(genreList.map((x) => x.name));
      result = result.toSet().toList();
    }
    result.sort((a, b) => a.compareTo(b));
    return result;
  }
}
