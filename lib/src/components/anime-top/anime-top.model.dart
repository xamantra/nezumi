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
    ).updateMomentum();
  }
}
