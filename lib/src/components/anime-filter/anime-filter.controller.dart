import 'package:momentum/momentum.dart';

import '../../absract/index.dart';
import '../../data/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeFilterController extends MomentumController<AnimeFilterModel> with CoreMixin {
  @override
  AnimeFilterModel init() {
    return AnimeFilterModel(
      this,
      animeFilters: [],
      results: [],
    );
  }

  List<AnimeData> get animeListSource => mal.userAnimeList?.animeList ?? [];

  void addFilter<T extends AnimeFilterData>(T filter) {
    var animeFilters = List<AnimeFilterData>.from(model.animeFilters);
    var exists = animeFilters.any((x) => x is T);
    if (exists) {
      editFilter(filter);
    } else {
      animeFilters.add(filter);
      model.update(animeFilters: animeFilters);
      _processFilters();
    }
  }

  void editFilter<T extends AnimeFilterData>(T filter) {
    var animeFilters = List<AnimeFilterData>.from(model.animeFilters);
    animeFilters.removeWhere((x) => x is T);
    animeFilters.add(filter);
    model.update(animeFilters: animeFilters);
    _processFilters();
  }

  void removeFilter<T extends AnimeFilterData>() {
    var animeFilters = List<AnimeFilterData>.from(model.animeFilters);
    animeFilters.removeWhere((x) => x is T);
    model.update(animeFilters: animeFilters);
    _processFilters();
  }

  void _processFilters() async {
    var source = animeListSource;
    var filters = model.animeFilters;
    var results = <AnimeData>[];
    await Future.forEach<AnimeData>(source, (anime) {
      var matched = filters.every((x) => x.match(anime));
      if (matched) {
        results.add(anime);
      }
    });
    if (results.length == source.length) {
      model.update(results: []);
      return;
    }
    results.sort((a, b) => a.node.title.compareTo(b.node.title));
    model.update(results: results);
  }

  List<String> allGenre() {
    var result = <String>[];
    for (var anime in animeListSource) {
      var genreList = anime.node?.genres ?? [];
      result.addAll(genreList.map((x) => x.name));
      result = result.toSet().toList();
    }
    result.sort((a, b) => a.compareTo(b));
    return result;
  }

  int resultTotalHours() {
    var totalMinutes = 0.0;
    var results = model.results;
    for (var anime in results) {
      var eps = anime.listStatus.numEpisodesWatched;
      if (eps == null || eps == 0) {
        eps = anime.node.numEpisodes;
      }
      var epDuration = anime.node.averageEpisodeDuration;

      var overallSeconds = epDuration * eps; // total seconds
      var rewatched = anime.listStatus.numTimesRewatched;
      if (rewatched != null) {
        overallSeconds *= (rewatched + 1);
      }
      var overallMinutes = (overallSeconds / 60.0); // total minutes
      totalMinutes += overallMinutes;
    }
    var overallHours = totalMinutes / 60; // total hours
    return trycatch(() => overallHours.round(), 0);
  }

  double resultTotalDays() {
    var hours = resultTotalHours() / 24.0;
    var fixed = hours.toStringAsFixed(1);
    return trycatch(() => double.parse(fixed), 0.0);
  }

  int resultTotalEpisodes() {
    var totalEpisodes = 0;
    var results = model.results;
    for (var anime in results) {
      var eps = anime.listStatus.numEpisodesWatched;
      if (eps == null || eps == 0) {
        eps = anime.node.numEpisodes;
      }

      var overallEpisodes = eps;
      var rewatched = anime.listStatus.numTimesRewatched;
      if (rewatched != null) {
        overallEpisodes *= (rewatched + 1);
      }
      totalEpisodes += overallEpisodes;
    }

    return totalEpisodes;
  }

  int resultEpisodesPerEntry() {
    var results = model.results;
    var result = resultTotalEpisodes() / results.length;
    return trycatch(() => result.round(), 0);
  }

  int minutesPerEpisode() {
    var totalMinutes = resultTotalHours() * 60;
    var result = totalMinutes / resultTotalEpisodes();
    return trycatch(() => result.round(), 0);
  }
}
