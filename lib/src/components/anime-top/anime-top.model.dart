import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import 'index.dart';

class AnimeTopModel extends MomentumModel<AnimeTopController> {
  AnimeTopModel(
    AnimeTopController controller, {
    this.topAll,
    this.topAiring,
    this.topUpcoming,
    this.topTV,
    this.topMovies,
    this.topOVA,
    this.topSpecials,
    this.topPopularity,
    this.topFavorites,
    this.loadingTopAll,
    this.loadingTopAiring,
    this.loadingTopUpcoming,
    this.loadingTopTV,
    this.loadingTopMovies,
    this.loadingTopOVA,
    this.loadingTopSpecials,
    this.loadingTopPopularity,
    this.loadingTopFavorites,
    this.selectedYear,
    this.selectedYearRankings,
    this.selectedYearRankingsAll,
    this.loadingYearlyRankings,
    this.yearlyRankingOrderBy,
    this.yearlyRankingSortBy,
    this.fullscreen,
    this.selectionMode,
    this.excludedAnimeIDs,
    this.selectedAnimeIDs,
    this.showOnlyAnimeTypes,
  }) : super(controller);

  final AnimeListGlobal topAll;
  final AnimeListGlobal topAiring;
  final AnimeListGlobal topUpcoming;
  final AnimeListGlobal topTV;
  final AnimeListGlobal topMovies;
  final AnimeListGlobal topOVA;
  final AnimeListGlobal topSpecials;
  final AnimeListGlobal topPopularity;
  final AnimeListGlobal topFavorites;

  final bool loadingTopAll;
  final bool loadingTopAiring;
  final bool loadingTopUpcoming;
  final bool loadingTopTV;
  final bool loadingTopMovies;
  final bool loadingTopOVA;
  final bool loadingTopSpecials;
  final bool loadingTopPopularity;
  final bool loadingTopFavorites;

  // yearly rankings
  final int selectedYear;
  final List<AnimeDataItem> selectedYearRankings;
  final List<AnimeDataItem> selectedYearRankingsAll;
  final bool loadingYearlyRankings;
  final OrderBy yearlyRankingOrderBy;
  final AnimeSortBy yearlyRankingSortBy;

  // filters
  final Map<String, bool> showOnlyAnimeTypes;
  final List<int> excludedAnimeIDs;
  bool isAnimeExcluded(int id) {
    return excludedAnimeIDs.any((x) => x == id);
  }

  // user interface
  final bool fullscreen;
  final bool selectionMode;
  final List<int> selectedAnimeIDs;
  bool isAnimeSelected(int id) {
    return selectedAnimeIDs.any((x) => x == id);
  }

  bool isLoading(int index) {
    switch (index) {
      case 0:
        return loadingTopAll;
      case 1:
        return loadingTopAiring;
      case 2:
        return loadingTopUpcoming;
      case 3:
        return loadingTopTV;
      case 4:
        return loadingTopMovies;
      case 5:
        return loadingTopOVA;
      case 6:
        return loadingTopSpecials;
      case 7:
        return loadingTopPopularity;
      case 8:
        return loadingTopFavorites;
      default:
        return false;
    }
  }

  AnimeListGlobal getTopByIndex(int index) {
    switch (index) {
      case 0:
        return topAll;
      case 1:
        return topAiring;
      case 2:
        return topUpcoming;
      case 3:
        return topTV;
      case 4:
        return topMovies;
      case 5:
        return topOVA;
      case 6:
        return topSpecials;
      case 7:
        return topPopularity;
      case 8:
        return topFavorites;
      default:
        return AnimeListGlobal(data: []);
    }
  }

  @override
  void update({
    AnimeListGlobal topAll,
    AnimeListGlobal topAiring,
    AnimeListGlobal topUpcoming,
    AnimeListGlobal topTV,
    AnimeListGlobal topMovies,
    AnimeListGlobal topOVA,
    AnimeListGlobal topSpecials,
    AnimeListGlobal topPopularity,
    AnimeListGlobal topFavorites,
    bool loadingTopAll,
    bool loadingTopAiring,
    bool loadingTopUpcoming,
    bool loadingTopTV,
    bool loadingTopMovies,
    bool loadingTopOVA,
    bool loadingTopSpecials,
    bool loadingTopPopularity,
    bool loadingTopFavorites,
    int selectedYear,
    List<AnimeDataItem> selectedYearRankings,
    List<AnimeDataItem> selectedYearRankingsAll,
    bool loadingYearlyRankings,
    OrderBy yearlyRankingOrderBy,
    AnimeSortBy yearlyRankingSortBy,
    bool fullscreen,
    bool selectionMode,
    List<int> excludedAnimeIDs,
    List<int> selectedAnimeIDs,
    Map<String, bool> showOnlyAnimeTypes,
  }) {
    AnimeTopModel(
      controller,
      topAll: topAll ?? this.topAll,
      topAiring: topAiring ?? this.topAiring,
      topUpcoming: topUpcoming ?? this.topUpcoming,
      topTV: topTV ?? this.topTV,
      topMovies: topMovies ?? this.topMovies,
      topOVA: topOVA ?? this.topOVA,
      topSpecials: topSpecials ?? this.topSpecials,
      topPopularity: topPopularity ?? this.topPopularity,
      topFavorites: topFavorites ?? this.topFavorites,
      loadingTopAll: loadingTopAll ?? this.loadingTopAll,
      loadingTopAiring: loadingTopAiring ?? this.loadingTopAiring,
      loadingTopUpcoming: loadingTopUpcoming ?? this.loadingTopUpcoming,
      loadingTopTV: loadingTopTV ?? this.loadingTopTV,
      loadingTopMovies: loadingTopMovies ?? this.loadingTopMovies,
      loadingTopOVA: loadingTopOVA ?? this.loadingTopOVA,
      loadingTopSpecials: loadingTopSpecials ?? this.loadingTopSpecials,
      loadingTopPopularity: loadingTopPopularity ?? this.loadingTopPopularity,
      loadingTopFavorites: loadingTopFavorites ?? this.loadingTopFavorites,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedYearRankings: selectedYearRankings ?? this.selectedYearRankings,
      selectedYearRankingsAll: selectedYearRankingsAll ?? this.selectedYearRankingsAll,
      loadingYearlyRankings: loadingYearlyRankings ?? this.loadingYearlyRankings,
      yearlyRankingOrderBy: yearlyRankingOrderBy ?? this.yearlyRankingOrderBy,
      yearlyRankingSortBy: yearlyRankingSortBy ?? this.yearlyRankingSortBy,
      fullscreen: fullscreen ?? this.fullscreen,
      selectionMode: selectionMode ?? this.selectionMode,
      excludedAnimeIDs: excludedAnimeIDs ?? this.excludedAnimeIDs,
      selectedAnimeIDs: selectedAnimeIDs ?? this.selectedAnimeIDs,
      showOnlyAnimeTypes: showOnlyAnimeTypes ?? this.showOnlyAnimeTypes,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'topAll': topAll?.toJson(),
      'topAiring': topAiring?.toJson(),
      'topUpcoming': topUpcoming?.toJson(),
      'topTV': topTV?.toJson(),
      'topMovies': topMovies?.toJson(),
      'topOVA': topOVA?.toJson(),
      'topSpecials': topSpecials?.toJson(),
      'topPopularity': topPopularity?.toJson(),
      'topFavorites': topFavorites?.toJson(),
      'loadingTopAll': false,
      'loadingTopAiring': false,
      'loadingTopUpcoming': false,
      'loadingTopTV': false,
      'loadingTopMovies': false,
      'loadingTopOVA': false,
      'loadingTopSpecials': false,
      'loadingTopPopularity': false,
      'loadingTopFavorites': false,
      'selectedYear': selectedYear,
      'selectedYearRankings': selectedYearRankings?.map((x) => x?.toJson())?.toList(),
      'selectedYearRankingsAll': selectedYearRankingsAll?.map((x) => x?.toJson())?.toList(),
      'loadingYearlyRankings': false,
      'yearlyRankingOrderBy': orderBy_toJson(yearlyRankingOrderBy),
      'yearlyRankingSortBy': animeSortBy_toJson(yearlyRankingSortBy),
      'showOnlyAnimeTypes': showOnlyAnimeTypes,
      'excludedAnimeIDs': excludedAnimeIDs,
      'fullscreen': fullscreen,
      'selectionMode': selectionMode,
      'selectedAnimeIDs': selectedAnimeIDs,
    };
  }

  AnimeTopModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return AnimeTopModel(
      controller,
      topAll: AnimeListGlobal.fromJson(json['topAll']),
      topAiring: AnimeListGlobal.fromJson(json['topAiring']),
      topUpcoming: AnimeListGlobal.fromJson(json['topUpcoming']),
      topTV: AnimeListGlobal.fromJson(json['topTV']),
      topMovies: AnimeListGlobal.fromJson(json['topMovies']),
      topOVA: AnimeListGlobal.fromJson(json['topOVA']),
      topSpecials: AnimeListGlobal.fromJson(json['topSpecials']),
      topPopularity: AnimeListGlobal.fromJson(json['topPopularity']),
      topFavorites: AnimeListGlobal.fromJson(json['topFavorites']),
      loadingTopAll: json['loadingTopAll'],
      loadingTopAiring: json['loadingTopAiring'],
      loadingTopUpcoming: json['loadingTopUpcoming'],
      loadingTopTV: json['loadingTopTV'],
      loadingTopMovies: json['loadingTopMovies'],
      loadingTopOVA: json['loadingTopOVA'],
      loadingTopSpecials: json['loadingTopSpecials'],
      loadingTopPopularity: json['loadingTopPopularity'],
      loadingTopFavorites: json['loadingTopFavorites'],
      selectedYear: json['selectedYear'],
      selectedYearRankings: List<AnimeDataItem>.from(json['selectedYearRankings']?.map((x) => AnimeDataItem.fromJson(x))),
      selectedYearRankingsAll: List<AnimeDataItem>.from(json['selectedYearRankingsAll']?.map((x) => AnimeDataItem.fromJson(x))),
      loadingYearlyRankings: json['loadingYearlyRankings'],
      yearlyRankingOrderBy: orderBy_fromJson(json['yearlyRankingOrderBy']),
      yearlyRankingSortBy: animeSortBy_fromJson(json['yearlyRankingSortBy']),
      showOnlyAnimeTypes: Map<String, bool>.from(json['showOnlyAnimeTypes']),
      excludedAnimeIDs: List<int>.from(json['excludedAnimeIDs']),
      fullscreen: json['fullscreen'],
      selectionMode: json['selectionMode'],
      selectedAnimeIDs: List<int>.from(json['selectedAnimeIDs']),
    );
  }
}
