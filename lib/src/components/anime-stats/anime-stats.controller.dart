import 'dart:async';

import 'package:meta/meta.dart';
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
      genreStatItems: [],
      sourceMaterialStatItems: [],
      studioStatItems: [],
      yearStatItems: [],
      seasonStatItems: [],
      formatItems: [],
      ratingItems: [],
    );
  }

  Future<List<AnimeSummaryStatData>> _getAnimeStatListAsync<T>({
    @required List<T> source,
    @required List<AnimeDetails> Function(T) iterator,
    @required String Function(T) labeler,
  }) async {
    var result = <AnimeSummaryStatData>[];
    await Future.forEach<T>(source, (item) async {
      var grouped = iterator(item);
      var totalEpisodes = 0;
      var totalHours = 0.0;
      var scores = <ScoreData>[];
      await Future.forEach(grouped, (anime) {
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
      if (grouped.isNotEmpty) {
        result.add(
          AnimeSummaryStatData(
            name: labeler(item),
            entries: grouped,
            totalEpisodes: totalEpisodes,
            totalHours: totalHours,
            mean: notEnoughEntries ? 0 : weight.getWeightedMean(2),
          ),
        );
      }
    });

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

  /// Load all anime stats while avoiding ui freeze when opening anime stats page.
  void loadAllStats() async {
    await Future.delayed(Duration(milliseconds: 1500));
    loadGenreStatItems();
    loadSourceMaterialStatItems();
    loadStudioStatItems();
    loadYearStatItems();
    loadSeasonStatItems();
    loadFormatStatItems();
    loadRatingStatItems();
  }

  void loadGenreStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var genreList = await getAllGenre(entries);
    var result = await _getAnimeStatListAsync(
      source: genreList,
      iterator: (genre) {
        return entries.where((x) => (x.genres ?? []).any((g) => g.name == genre) && mustCountOnStats(x)).toList();
      },
      labeler: (_) => _,
    );
    model.update(genreStatItems: result);
  }

  void loadSourceMaterialStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var sourceMaterials = await getAllSourceMaterials(entries);
    var result = await _getAnimeStatListAsync(
      source: sourceMaterials,
      iterator: (sourceMaterial) {
        return entries.where((x) => x.source == sourceMaterial && mustCountOnStats(x)).toList();
      },
      labeler: (_) => _,
    );
    model.update(sourceMaterialStatItems: result);
  }

  void loadStudioStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var studios = await getAllStudio(entries);
    var result = await _getAnimeStatListAsync(
      source: studios,
      iterator: (studio) {
        return entries.where((x) => (x.studios ?? []).any((s) => s.name == studio) && mustCountOnStats(x)).toList();
      },
      labeler: (_) => _,
    );
    model.update(studioStatItems: result);
  }

  void loadYearStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var years = await getAllYears(entries);
    var result = await _getAnimeStatListAsync(
      source: years,
      iterator: (year) {
        return entries.where((x) {
          var y = x.startSeason?.year ?? parseDate(x.startDate)?.year;
          return y == year && mustCountOnStats(x);
        }).toList();
      },
      labeler: (_) => _.toString(),
    );
    model.update(yearStatItems: result);
  }

  void loadSeasonStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var seasons = await getAllSeason(entries);
    var result = await _getAnimeStatListAsync(
      source: seasons,
      iterator: (season) {
        return entries.where(
          (x) {
            var ss = x?.startSeason;
            if (ss != null && ss.season != null && ss.year != null) {
              var s = '${ss.season} ${ss.year}';
              return s == season && mustCountOnStats(x);
            }
            return false;
          },
        ).toList();
      },
      labeler: (_) => _,
    );
    model.update(seasonStatItems: result);
  }

  void loadFormatStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var formats = await getAllFormat(entries);
    var result = await _getAnimeStatListAsync(
      source: formats,
      iterator: (format) {
        return entries.where((x) => x.mediaType == format && mustCountOnStats(x)).toList();
      },
      labeler: (_) => _,
    );
    model.update(formatItems: result);
  }

  void loadRatingStatItems() async {
    var entries = animeCache?.rendered_user_list ?? [];
    var ratings = await getAllRating(entries);
    var result = await _getAnimeStatListAsync(
      source: ratings,
      iterator: (rating) {
        return entries.where((x) => x.rating == rating && mustCountOnStats(x)).toList();
      },
      labeler: (_) => _,
    );
    model.update(ratingItems: result);
  }

  Future<List<String>> getAllGenre(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var genreList = anime?.genres ?? [];
      result.addAll(genreList.map((x) => x.name));
      result = result.toSet().toList();
    });
    return result;
  }

  Future<List<String>> getAllSourceMaterials(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      if (anime.source != null) {
        result.add(anime.source);
        result = result.toSet().toList();
      }
    });
    return result;
  }

  Future<List<String>> getAllStudio(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var studios = anime?.studios ?? [];
      if (studios.isNotEmpty) {
        result.addAll(studios.map((x) => x.name));
        result = result.toSet().toList();
      }
    });
    return result;
  }

  Future<List<int>> getAllYears(List<AnimeDetails> from) async {
    var result = <int>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var year = anime.startSeason?.year ?? parseDate(anime.startDate)?.year;
      if (year != null) {
        result.add(year);
        result = result.toSet().toList();
      }
    });
    return result;
  }

  Future<List<String>> getAllSeason(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var ss = anime?.startSeason;
      if (ss != null && ss.season != null && ss.year != null) {
        var season = '${ss.season} ${ss.year}';
        result.add(season);
        result = result.toSet().toList();
      }
    });
    return result;
  }

  Future<List<String>> getAllFormat(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var mediaType = anime?.mediaType;
      if (mediaType != null && mediaType.isNotEmpty) {
        result.add(mediaType);
        result = result.toSet().toList();
      }
    });
    return result;
  }

  Future<List<String>> getAllRating(List<AnimeDetails> from) async {
    var result = <String>[];
    await Future.forEach<AnimeDetails>(from, (anime) {
      var rating = anime?.rating;
      if (rating != null && rating.isNotEmpty) {
        result.add(rating);
        result = result.toSet().toList();
      }
    });
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
