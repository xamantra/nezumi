import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeStatsController extends MomentumController<AnimeStatsModel> with CoreMixin {
  @override
  AnimeStatsModel init() {
    return AnimeStatsModel(
      this,
      orderBy: OrderBy.descending,
      sortBy: AnimeStatSort.mean,
    );
  }

  List<AnimeSummaryStatData> getGenreStatItems() {
    var entries = animeCache?.rendered_user_list ?? [];
    var genreList = getAllGenre(entries);
    var result = <AnimeSummaryStatData>[];
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
      var notEnoughEntries = grouped.length < 10;
      var weight = WeightScores(scores);
      result.add(
        AnimeSummaryStatData(
          name: genre,
          entries: grouped,
          totalEpisodes: totalEpisodes,
          totalHours: totalHours,
          mean: notEnoughEntries ? 0 : weight.getWeightedMean(2),
        ),
      );
    }
    switch (model.sortBy) {
      case AnimeStatSort.mean:
        result.sort(sorter(compareStatMean));
        break;
      case AnimeStatSort.entryCount:
        result.sort(sorter(compareStatEntryCount));
        break;
      case AnimeStatSort.episodeCount:
        result.sort(sorter(compareStatEpisodesWatched));
        break;
      case AnimeStatSort.hoursWatched:
        result.sort(sorter(compareStatHoursWatched));
        break;
    }
    return result;
  }

  List<AnimeSummaryStatData> getSourceMaterialStatItems() {
    var entries = animeCache?.rendered_user_list ?? [];
    var sourceMaterials = getAllSourceMaterials(entries);
    var result = <AnimeSummaryStatData>[];
    for (var sourceMaterial in sourceMaterials) {
      var grouped = entries.where((x) => x.source == sourceMaterial).toList();
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
      var notEnoughEntries = grouped.length < 10;
      var weight = WeightScores(scores);
      result.add(
        AnimeSummaryStatData(
          name: sourceMaterial,
          entries: grouped,
          totalEpisodes: totalEpisodes,
          totalHours: totalHours,
          mean: notEnoughEntries ? 0 : weight.getWeightedMean(2),
        ),
      );
    }
    switch (model.sortBy) {
      case AnimeStatSort.mean:
        result.sort(sorter(compareStatMean));
        break;
      case AnimeStatSort.entryCount:
        result.sort(sorter(compareStatEntryCount));
        break;
      case AnimeStatSort.episodeCount:
        result.sort(sorter(compareStatEpisodesWatched));
        break;
      case AnimeStatSort.hoursWatched:
        result.sort(sorter(compareStatHoursWatched));
        break;
    }
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

  List<String> getAllSourceMaterials(List<AnimeDetails> from) {
    var result = <String>[];
    for (var anime in from) {
      if (anime.source != null) {
        result.add(anime.source);
        result = result.toSet().toList();
      }
    }
    result.sort((a, b) => a.compareTo(b));
    return result;
  }

  void toggleAnimeStatOrderBy() {
    switch (model.orderBy) {
      case OrderBy.ascending:
        model.update(orderBy: OrderBy.descending);
        break;
      case OrderBy.descending:
        model.update(orderBy: OrderBy.ascending);
        break;
    }
  }

  void changeAnimeStatSortBy(AnimeStatSort sortBy) {
    model.update(sortBy: sortBy);
  }

  int Function(AnimeSummaryStatData, AnimeSummaryStatData) sorter(int Function(OrderBy, AnimeSummaryStatData, AnimeSummaryStatData) s) {
    return (a, b) {
      return s(model.orderBy, a, b);
    };
  }
}
