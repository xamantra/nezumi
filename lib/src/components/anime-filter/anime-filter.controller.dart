import 'package:momentum/momentum.dart';

import '../../absract/index.dart';
import '../../data/index.dart';
import '../../data/types/index.dart';
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

  List<AnimeDetails> get animeListSource => animeCache.user_list;

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
    var results = <AnimeDetails>[];
    await Future.forEach<AnimeDetails>(source, (anime) {
      var matched = filters.every((x) => x.match(anime));
      if (matched) {
        results.add(anime);
      }
    });
    if (results.length == source.length) {
      model.update(results: []);
      return;
    }
    results.sort((a, b) => a.title.compareTo(b.title));
    sortResults(source: results);
  }

  void sortResults({List<AnimeDetails> source}) {
    var results = source ?? List<AnimeDetails>.from(model.results);
    switch (listSort.animeFilterSortBy) {
      case AnimeListSortBy.title:
        results.sort(sorter(compareTitle));
        break;
      case AnimeListSortBy.globalScore:
        results.sort(sorter(compareMean));
        break;
      case AnimeListSortBy.member:
        results.sort(sorter(compareMember));
        break;
      case AnimeListSortBy.userVotes:
        results.sort(sorter(compareScoringMember));
        break;
      case AnimeListSortBy.lastUpdated:
        results.sort(sorter(compareLastUpdated));
        break;
      case AnimeListSortBy.episodesWatched:
        results.sort(sorter(compareEpisodesWatched));
        break;
      case AnimeListSortBy.startWatchDate:
        results.sort(sorter(compareStartWatch));
        break;
      case AnimeListSortBy.finishWatchDate:
        results.sort(sorter(compareFinishWatch));
        break;
      case AnimeListSortBy.personalScore:
        results.sort(sorter(comparePersonalScore));
        break;
      case AnimeListSortBy.totalDuration:
        results.sort(sorter(compareTotalDuration));
        break;
      case AnimeListSortBy.startAirDate:
        results.sort(sorter(compareStartAir));
        break;
      case AnimeListSortBy.endAirDate:
        results.sort(sorter(compareEndAir));
        break;
    }
    model.update(results: results);
  }

  int Function(AnimeDetails, AnimeDetails) sorter(int Function(OrderBy, AnimeDetails, AnimeDetails) sorter) {
    return (a, b) {
      return sorter(listSort.animeFilterOrderBy, a, b);
    };
  }

  List<String> allGenre() {
    var result = <String>[];
    for (var anime in animeListSource) {
      var genreList = anime?.genres ?? [];
      result.addAll(genreList.map((x) => x.name));
      result = result.toSet().toList();
    }
    result.sort((a, b) => a.compareTo(b));
    return result;
  }

  List<String> allTag() {
    var result = <String>[];
    for (var anime in animeListSource) {
      var tagList = anime?.myListStatus?.tags ?? [];
      result.addAll(tagList.where((tag) => !(tag?.toLowerCase()?.contains('score:') ?? false)));
      result = result.toSet().toList();
    }
    result.sort((a, b) => a.compareTo(b));
    return result;
  }

  int resultTotalHours() {
    var totalMinutes = 0.0;
    var results = model.results;
    for (var anime in results) {
      var eps = anime.myListStatus.numEpisodesWatched;
      if (eps == null || eps == 0) {
        eps = anime.numEpisodes;
      }
      var epDuration = anime.averageEpisodeDuration;

      var overallSeconds = epDuration * eps; // total seconds
      var rewatched = anime.myListStatus.numTimesRewatched;
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
      var eps = anime.myListStatus.numEpisodesWatched;
      if (eps == null || eps == 0) {
        eps = anime.numEpisodes;
      }

      var overallEpisodes = eps;
      var rewatched = anime.myListStatus.numTimesRewatched;
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
