import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import 'index.dart';

class AnimeTopModel extends MomentumModel<AnimeTopController> {
  AnimeTopModel(
    AnimeTopController controller, {
    this.malRankings,
    this.loading,
    this.selectedYear,
    this.yearlyRankingsCache,
    this.loadingYearlyRankings,
    this.yearlyRankingOrderBy,
    this.yearlyRankingSortBy,
    this.fullscreen,
    this.selectionMode,
    this.excludedAnimeIDs,
    this.selectedAnimeIDs,
    this.showOnlyAnimeTypes,
    this.currentPages,
  }) : super(controller);

  final Map<int, AnimeListGlobal> malRankings;
  final Map<int, bool> loading;
  final Map<int, int> currentPages;

  // yearly rankings
  final int selectedYear;
  final List<YearlyAnimeRankingsCache> yearlyRankingsCache;
  final bool loadingYearlyRankings;
  final OrderBy yearlyRankingOrderBy;
  final TopAnimeSortBy yearlyRankingSortBy;
  List<AnimeDetails> getRankingByYear(int year) {
    var find = yearlyRankingsCache.firstWhere((x) => x.year == year, orElse: () => null);
    var result = List<AnimeDetails>.from(find?.rankings ?? []);
    return result;
  }

  List<AnimeDetails> getAllEntriesYear(int year) {
    var find = yearlyRankingsCache.firstWhere((x) => x.year == year, orElse: () => null);
    var result = List<AnimeDetails>.from(find?.allYearEntries ?? []);
    return result;
  }

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
    try {
      return loading[index];
    } catch (e) {
      return false;
    }
  }

  AnimeListGlobal getTopByIndex(int index) {
    try {
      return malRankings[index];
    } catch (e) {
      return AnimeListGlobal(list: []);
    }
  }

  int currentPage(int index) {
    try {
      return currentPages[index];
    } catch (e) {
      return 1;
    }
  }

  bool prevPageEnabled(int index) {
    try {
      return (malRankings[index].paging?.prev ?? '').isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  bool nextPageEnabled(int index) {
    try {
      return (malRankings[index].paging?.next ?? '').isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  void update({
    Map<int, AnimeListGlobal> malRankings,
    Map<int, bool> loading,
    int selectedYear,
    List<YearlyAnimeRankingsCache> yearlyRankingsCache,
    bool loadingYearlyRankings,
    OrderBy yearlyRankingOrderBy,
    TopAnimeSortBy yearlyRankingSortBy,
    bool fullscreen,
    bool selectionMode,
    List<int> excludedAnimeIDs,
    List<int> selectedAnimeIDs,
    Map<String, bool> showOnlyAnimeTypes,
    Map<int, int> currentPages,
  }) {
    AnimeTopModel(
      controller,
      malRankings: malRankings ?? this.malRankings,
      loading: loading ?? this.loading,
      selectedYear: selectedYear ?? this.selectedYear,
      yearlyRankingsCache: yearlyRankingsCache ?? this.yearlyRankingsCache,
      loadingYearlyRankings: loadingYearlyRankings ?? this.loadingYearlyRankings,
      yearlyRankingOrderBy: yearlyRankingOrderBy ?? this.yearlyRankingOrderBy,
      yearlyRankingSortBy: yearlyRankingSortBy ?? this.yearlyRankingSortBy,
      fullscreen: fullscreen ?? this.fullscreen,
      selectionMode: selectionMode ?? this.selectionMode,
      excludedAnimeIDs: excludedAnimeIDs ?? this.excludedAnimeIDs,
      selectedAnimeIDs: selectedAnimeIDs ?? this.selectedAnimeIDs,
      showOnlyAnimeTypes: showOnlyAnimeTypes ?? this.showOnlyAnimeTypes,
      currentPages: currentPages ?? this.currentPages,
    ).updateMomentum();
  }
}
