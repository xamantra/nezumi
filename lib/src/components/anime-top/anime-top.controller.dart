import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeTopController extends MomentumController<AnimeTopModel> with AuthMixin, CoreMixin {
  @override
  AnimeTopModel init() {
    Map<String, bool> showOnlyAnimeTypes = {};
    for (var item in allAnimeMediaTypeList) {
      showOnlyAnimeTypes.putIfAbsent(item.toUpperCase(), () => true);
    }
    return AnimeTopModel(
      this,
      loadingTopAll: false,
      loadingTopAiring: false,
      loadingTopUpcoming: false,
      loadingTopTV: false,
      loadingTopMovies: false,
      loadingTopOVA: false,
      loadingTopSpecials: false,
      loadingTopPopularity: false,
      loadingTopFavorites: false,
      selectedYear: DateTime.now().year,
      loadingYearlyRankings: false,
      yearlyRankingOrderBy: OrderBy.descending,
      yearlyRankingSortBy: AnimeSortBy.score,
      fullscreen: false,
      selectionMode: false,
      // filteredYearlyRankings: [],
      // selectedYearRankings: [],
      yearlyRankingsCache: [],
      excludedAnimeIDs: [],
      selectedAnimeIDs: [],
      showOnlyAnimeTypes: showOnlyAnimeTypes,
    );
  }

  void changeYear(int year) {
    model.update(selectedYear: year);
    var fromCache = model.getAllEntriesYear(year);
    if (fromCache.isEmpty) {
      loadYearRankings();
    } else {
      validateAndSortYearlyRankings();
    }
  }

  void prevYear() {
    var selected = model.selectedYear;
    model.update(selectedYear: selected - 1);
    var fromCache = model.getAllEntriesYear(model.selectedYear);
    if (fromCache.isEmpty) {
      loadYearRankings();
    } else {
      validateAndSortYearlyRankings();
    }
  }

  void nextYear() {
    var selected = model.selectedYear;
    var now = DateTime.now().year;
    if (selected == now) return;
    model.update(selectedYear: selected + 1);
    var fromCache = model.getAllEntriesYear(model.selectedYear);
    if (fromCache.isEmpty) {
      loadYearRankings();
    } else {
      validateAndSortYearlyRankings();
    }
  }

  List<AnimeDataItem> filterAnimeList(int year, List<AnimeDataItem> source) {
    var original = List<AnimeDataItem>.from(source);
    var filtered = original.where((x) {
      var seasonYear = x?.node?.startSeason?.year ?? -1;
      var matchedYear = seasonYear == year;
      var hasScore = (x?.node?.mean ?? 0) > 0;
      if (!hasScore) {
        var not_yet_aired = x.node.status == 'not_yet_aired';
        if (not_yet_aired) {
          return matchedYear;
        }
      }
      return matchedYear && hasScore;
    }).toList();
    var noHentaiAndKids = <AnimeDataItem>[];
    for (var item in filtered) {
      var genres = item?.node?.genres ?? [];
      if (genres.isNotEmpty) {
        var hentai = genres.any((x) => x.name?.toLowerCase() == 'hentai');
        var kids = genres.any((x) => x.name?.toLowerCase() == 'kids');
        if (!hentai && !kids) {
          noHentaiAndKids.add(item);
        }
      }
    }
    return noHentaiAndKids;
  }

  void validateAndSortYearlyRankings() {
    var year = model.selectedYear;
    var original = model.getAllEntriesYear(year);
    var filtered = filterAnimeList(year, original);

    filtered.sort((a, b) => b.node.mean.compareTo(a.node.mean));
    switch (model.yearlyRankingSortBy) {
      case AnimeSortBy.title:
        filtered.sort(compareTitle);
        break;
      case AnimeSortBy.score:
        filtered.sort(compareMean);
        break;
      case AnimeSortBy.member:
        filtered.sort(compareMember);
        break;
      case AnimeSortBy.scoringMember:
        filtered.sort(compareScoringMember);
        break;
      case AnimeSortBy.totalDuraton:
        filtered.sort(compareTotalDuration);
        break;
    }

    var filterDuplicates = <AnimeDataItem>[];
    for (var item in filtered) {
      var exists = filterDuplicates.any((x) => x.node.id == item.node.id);
      if (!exists) {
        filterDuplicates.add(item);
      }
    }

    var filterExcluded = <AnimeDataItem>[];
    for (var item in filterDuplicates) {
      var e = model.isAnimeExcluded(item.node.id);
      if (!e) {
        filterExcluded.add(item);
      }
    }

    var filterMediaTypes = <AnimeDataItem>[];
    for (var item in filterExcluded) {
      var key = item.node.mediaType?.toUpperCase() ?? '-';
      var matched = model.showOnlyAnimeTypes[key];
      if (key != '-' && matched) {
        filterMediaTypes.add(item);
      }
    }

    var yearlyRankingsCache = List<YearlyAnimeRankingsCache>.from(model.yearlyRankingsCache);
    var cache = YearlyAnimeRankingsCache(
      year: year,
      allYearEntries: original,
      rankings: filterMediaTypes,
    );
    yearlyRankingsCache.removeWhere((x) => x.year == year);
    yearlyRankingsCache.add(cache);

    model.update(yearlyRankingsCache: yearlyRankingsCache);
  }

  int compareTitle(AnimeDataItem a, AnimeDataItem b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return a.node.title.compareTo(b.node.title);
        break;
      case OrderBy.descending:
        return b.node.title.compareTo(a.node.title);
        break;
    }
    return 0;
  }

  int compareMean(AnimeDataItem a, AnimeDataItem b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return a.node.mean.compareTo(b.node.mean);
        break;
      case OrderBy.descending:
        return b.node.mean.compareTo(a.node.mean);
        break;
    }
    return 0;
  }

  int compareScoringMember(AnimeDataItem a, AnimeDataItem b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return (a.node.numScoringUsers ?? 0).compareTo(b.node.numScoringUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.node.numScoringUsers ?? 0).compareTo(a.node.numScoringUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareMember(AnimeDataItem a, AnimeDataItem b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return (a.node.numListUsers ?? 0).compareTo(b.node.numListUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.node.numListUsers ?? 0).compareTo(a.node.numListUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareTotalDuration(AnimeDataItem a, AnimeDataItem b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return a.totalDuration.compareTo(b.totalDuration);
        break;
      case OrderBy.descending:
        return b.totalDuration.compareTo(a.totalDuration);
        break;
    }
    return 0;
  }

  String getEntryCount() {
    var year = model.selectedYear;
    var list = model.getRankingByYear(year);
    return list.length.toString();
  }

  String getMeanScore() {
    var year = model.selectedYear;
    var list = model.getRankingByYear(year);
    if (list.isEmpty) return '0.0';
    var totalScore = 0.0;
    var scoredEntries = 0;
    for (var anime in list) {
      var mean = anime?.node?.mean ?? 0;
      if (mean != 0) {
        totalScore += mean;
        scoredEntries += 1;
      }
    }
    var result = totalScore / scoredEntries;
    return result.toStringAsFixed(3);
  }

  String getVotesPerEntry() {
    var year = model.selectedYear;
    var list = getAllEntriesYear(year);
    if (list.isEmpty) return '0.0';
    var totalVotes = 0;
    var scoredEntries = 0;
    for (var anime in list) {
      var mean = anime?.node?.mean ?? 0;
      if (mean != 0) {
        totalVotes += anime?.node?.numScoringUsers ?? 0;
        scoredEntries += 1;
      }
    }
    var result = totalVotes / scoredEntries;
    return '${result.toInt()}';
  }

  List<AnimeDataItem> getAllEntriesYear(int year) {
    var list = model.getAllEntriesYear(year);
    var filtered = filterAnimeList(year, list);
    return filtered;
  }

  List<AnimeDataItem> getCurrentYearRankList() {
    var year = model.selectedYear;
    var source = model.getRankingByYear(year);
    var filtered = filterAnimeList(year, source);
    return filtered;
  }

  List<AnimeDataItem> getExcludedList() {
    var year = model.selectedYear;
    var result = <AnimeDataItem>[];
    var source = getAllEntriesYear(year);
    var excludedList = List<int>.from(model.excludedAnimeIDs);
    for (var item in source) {
      var e = excludedList.any((x) => x == item.node.id);
      if (e) {
        result.add(item);
      }
    }

    result.sort((a, b) => b.node.mean.compareTo(a.node.mean));
    switch (model.yearlyRankingSortBy) {
      case AnimeSortBy.title:
        result.sort(compareTitle);
        break;
      case AnimeSortBy.score:
        result.sort(compareMean);
        break;
      case AnimeSortBy.member:
        result.sort(compareMember);
        break;
      case AnimeSortBy.scoringMember:
        result.sort(compareScoringMember);
        break;
      case AnimeSortBy.totalDuraton:
        result.sort(compareTotalDuration);
        break;
    }

    var noDuplicates = <AnimeDataItem>[];
    for (var item in result) {
      var exists = noDuplicates.any((x) => x.node.id == item.node.id);
      if (!exists) {
        noDuplicates.add(item);
      }
    }

    var noDuplicatesExcluded = <int>[];
    for (var item in excludedList) {
      var exists = noDuplicatesExcluded.any((x) => x == item);
      if (!exists) {
        noDuplicatesExcluded.add(item);
      }
    }

    var filtered = filterAnimeList(year, noDuplicates);
    model.update(excludedAnimeIDs: noDuplicatesExcluded);

    return filtered;
  }

  void toggleOrderBy() {
    clearSelection();
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        model.update(yearlyRankingOrderBy: OrderBy.descending);
        break;
      case OrderBy.descending:
        model.update(yearlyRankingOrderBy: OrderBy.ascending);
        break;
    }

    validateAndSortYearlyRankings();
  }

  void changeSortBy(AnimeSortBy sortBy) {
    clearSelection();
    model.update(yearlyRankingSortBy: sortBy);
    validateAndSortYearlyRankings();
  }

  void toggleFullscreen() {
    model.update(fullscreen: !model.fullscreen);
    if (model.fullscreen) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  void enableSelectionMode() {
    model.update(selectionMode: true);
  }

  void disableSelectionMode() {
    model.update(selectionMode: false);
  }

  void addToExcludedAnime(int id) {
    var excludedAnimeIDs = List<int>.from(model.excludedAnimeIDs);
    excludedAnimeIDs.add(id);
    excludedAnimeIDs = excludedAnimeIDs.toSet().toList();
    model.update(excludedAnimeIDs: excludedAnimeIDs);
  }

  void removeFromExcludedAnime(int id) {
    var excludedAnimeIDs = List<int>.from(model.excludedAnimeIDs);
    excludedAnimeIDs.removeWhere((x) => x == id);
    model.update(excludedAnimeIDs: excludedAnimeIDs);
  }

  void clearExcluded() {
    var excludedAnimeIDs = List<int>.from(model.excludedAnimeIDs);
    excludedAnimeIDs.clear();
    model.update(excludedAnimeIDs: excludedAnimeIDs);
  }

  void selectAnime(int id) {
    var selectedAnimeIDs = List<int>.from(model.selectedAnimeIDs);
    selectedAnimeIDs.add(id);
    selectedAnimeIDs = selectedAnimeIDs.toSet().toList();
    model.update(selectedAnimeIDs: selectedAnimeIDs, selectionMode: true);
  }

  void unselectAnime(int id) {
    var selectedAnimeIDs = List<int>.from(model.selectedAnimeIDs);
    selectedAnimeIDs.removeWhere((x) => x == id);
    model.update(selectedAnimeIDs: selectedAnimeIDs);
  }

  void clearSelection() {
    var selectedAnimeIDs = List<int>.from(model.selectedAnimeIDs);
    selectedAnimeIDs.clear();
    model.update(selectedAnimeIDs: selectedAnimeIDs, selectionMode: false);
  }

  void moveSelectionToExcluded() {
    var selectedAnimeIDs = List<int>.from(model.selectedAnimeIDs);
    var excludedAnimeIDs = List<int>.from(model.excludedAnimeIDs);

    excludedAnimeIDs.addAll(selectedAnimeIDs);
    excludedAnimeIDs = excludedAnimeIDs.toSet().toList();
    model.update(excludedAnimeIDs: excludedAnimeIDs);
    clearSelection();
    validateAndSortYearlyRankings();
  }

  void moveSelectionToIncluded() {
    var selectedAnimeIDs = List<int>.from(model.selectedAnimeIDs);
    var excludedAnimeIDs = List<int>.from(model.excludedAnimeIDs);

    for (var id in selectedAnimeIDs) {
      var e = excludedAnimeIDs.any((x) => x == id);
      if (e) {
        excludedAnimeIDs.removeWhere((x) => x == id);
      }
    }

    excludedAnimeIDs = excludedAnimeIDs.toSet().toList();
    model.update(excludedAnimeIDs: excludedAnimeIDs);
    clearSelection();
    validateAndSortYearlyRankings();
  }

  void selectAllAboveIndex(int selectedAnimeId) {
    var year = model.selectedYear;
    var source = model.getRankingByYear(year);
    var index = source.indexWhere((x) => x.node.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i < index) {
        selectAnime(source[i].node.id);
      }
    }
  }

  void selectAllBelowIndex(int selectedAnimeId) {
    var year = model.selectedYear;
    var source = model.getRankingByYear(year);
    var index = source.indexWhere((x) => x.node.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i > index) {
        selectAnime(source[i].node.id);
      }
    }
  }

  void selectAllAboveExcludedIndex(int selectedAnimeId) {
    var source = getExcludedList().map<int>((x) => x.node.id).toList();
    var index = source.indexWhere((x) => x == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i <= index) {
        selectAnime(source[i]);
      }
    }
  }

  void selectAllBelowExcludedIndex(int selectedAnimeId) {
    var source = getExcludedList().map<int>((x) => x.node.id).toList();
    var index = source.indexWhere((x) => x == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i >= index) {
        selectAnime(source[i]);
      }
    }
  }

  toggleCheckAnimeTypeFilter(String typeKey) {
    var map = Map<String, bool>.from(model.showOnlyAnimeTypes);
    var currentState = map[typeKey];
    map[typeKey] = !currentState;
    model.update(showOnlyAnimeTypes: map);
    validateAndSortYearlyRankings();
  }

  Future<void> loadTopAll() async {
    if (model.loadingTopAll) return;
    model.update(loadingTopAll: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'all',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopAll: false, topAll: result);
  }

  Future<void> loadTopAiring() async {
    if (model.loadingTopAiring) return;
    model.update(loadingTopAiring: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'airing',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopAiring: false, topAiring: result);
  }

  Future<void> loadTopUpcoming() async {
    if (model.loadingTopUpcoming) return;
    model.update(loadingTopUpcoming: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'upcoming',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopUpcoming: false, topUpcoming: result);
  }

  Future<void> loadTopTV() async {
    if (model.loadingTopTV) return;
    model.update(loadingTopTV: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'tv',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopTV: false, topTV: result);
  }

  Future<void> loadTopMovies() async {
    if (model.loadingTopMovies) return;
    model.update(loadingTopMovies: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'movie',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopMovies: false, topMovies: result);
  }

  Future<void> loadTopOVA() async {
    if (model.loadingTopOVA) return;
    model.update(loadingTopOVA: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'ova',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopOVA: false, topOVA: result);
  }

  Future<void> loadTopSpecials() async {
    if (model.loadingTopSpecials) return;
    model.update(loadingTopSpecials: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'special',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopSpecials: false, topSpecials: result);
  }

  Future<void> loadTopPopularity() async {
    if (model.loadingTopPopularity) return;
    model.update(loadingTopPopularity: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'bypopularity',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopPopularity: false, topPopularity: result);
  }

  Future<void> loadTopFavorites() async {
    if (model.loadingTopFavorites) return;
    model.update(loadingTopFavorites: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'favorite',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    model.update(loadingTopFavorites: false, topFavorites: result);
  }

  Future<void> loadYearRankings() async {
    if (model.loadingYearlyRankings) return;
    model.update(loadingYearlyRankings: true);
    var year = model.selectedYear;
    var winter = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'winter',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year winter": ${winter?.data?.length ?? 0} entries');

    var spring = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'spring',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year spring": ${spring?.data?.length ?? 0} entries');

    var summer = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'summer',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year summer": ${summer?.data?.length ?? 0} entries');

    var fall = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'fall',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year fall": ${fall?.data?.length ?? 0} entries');

    var combined = <AnimeDataItem>[];
    combined.addAll(winter?.data ?? []);
    combined.addAll(spring?.data ?? []);
    combined.addAll(summer?.data ?? []);
    combined.addAll(fall?.data ?? []);

    var result = AnimeListGlobal(data: combined);

    var yearlyRankingsCache = List<YearlyAnimeRankingsCache>.from(model.yearlyRankingsCache);
    var cache = YearlyAnimeRankingsCache(
      year: year,
      allYearEntries: result?.data ?? [],
      rankings: result?.data ?? [],
    );
    yearlyRankingsCache.removeWhere((x) => x.year == year);
    yearlyRankingsCache.add(cache);

    model.update(
      loadingYearlyRankings: false,
      // filteredYearlyRankings: result.data,
      // selectedYearRankings: result.data,
      yearlyRankingsCache: yearlyRankingsCache,
    );
    validateAndSortYearlyRankings();
  }
}
