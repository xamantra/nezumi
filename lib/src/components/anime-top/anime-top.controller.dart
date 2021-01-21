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
      selectedYear: DateTime.now().year,
      loadingYearlyRankings: false,
      yearlyRankingOrderBy: OrderBy.descending,
      yearlyRankingSortBy: TopAnimeSortBy.score,
      fullscreen: false,
      selectionMode: false,
      yearlyRankingsCache: [],
      excludedAnimeIDs: [],
      selectedAnimeIDs: [],
      showOnlyAnimeTypes: showOnlyAnimeTypes,
      malRankings: {
        0: null,
        1: null,
        2: null,
        3: null,
        4: null,
        5: null,
        6: null,
        7: null,
        8: null,
      },
      loading: {
        0: false,
        1: false,
        2: false,
        3: false,
        4: false,
        5: false,
        6: false,
        7: false,
        8: false,
      },
      currentPages: {
        0: 1,
        1: 1,
        2: 1,
        3: 1,
        4: 1,
        5: 1,
        6: 1,
        7: 1,
        8: 1,
      },
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

  List<AnimeDetails> filterAnimeList(int year, List<AnimeDetails> source) {
    var original = List<AnimeDetails>.from(source);
    var filtered = original.where((x) {
      var seasonYear = x?.startSeason?.year ?? -1;
      var matchedYear = seasonYear == year;
      var hasScore = (x?.mean ?? 0) > 0;
      if (!hasScore) {
        var not_yet_aired = x.status == 'not_yet_aired';
        if (not_yet_aired) {
          return matchedYear;
        }
      }
      return matchedYear && hasScore;
    }).toList();
    var noHentaiAndKids = <AnimeDetails>[];
    for (var item in filtered) {
      var genres = item?.genres ?? [];
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

    filtered.sort((a, b) => b.mean.compareTo(a.mean));
    switch (model.yearlyRankingSortBy) {
      case TopAnimeSortBy.title:
        filtered.sort(compareTitle);
        break;
      case TopAnimeSortBy.score:
        filtered.sort(compareMean);
        break;
      case TopAnimeSortBy.member:
        filtered.sort(compareMember);
        break;
      case TopAnimeSortBy.scoringMember:
        filtered.sort(compareScoringMember);
        break;
      case TopAnimeSortBy.totalDuraton:
        filtered.sort(compareTotalDuration);
        break;
    }

    var filterDuplicates = <AnimeDetails>[];
    for (var item in filtered) {
      var exists = filterDuplicates.any((x) => x.id == item.id);
      if (!exists) {
        filterDuplicates.add(item);
      }
    }

    var filterExcluded = <AnimeDetails>[];
    for (var item in filterDuplicates) {
      var e = model.isAnimeExcluded(item.id);
      if (!e) {
        filterExcluded.add(item);
      }
    }

    var filterMediaTypes = <AnimeDetails>[];
    for (var item in filterExcluded) {
      var key = item.mediaType?.toUpperCase() ?? '-';
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

  int compareTitle(AnimeDetails a, AnimeDetails b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return a.title.compareTo(b.title);
        break;
      case OrderBy.descending:
        return b.title.compareTo(a.title);
        break;
    }
    return 0;
  }

  int compareMean(AnimeDetails a, AnimeDetails b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return a.mean.compareTo(b.mean);
        break;
      case OrderBy.descending:
        return b.mean.compareTo(a.mean);
        break;
    }
    return 0;
  }

  int compareScoringMember(AnimeDetails a, AnimeDetails b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return (a.numScoringUsers ?? 0).compareTo(b.numScoringUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.numScoringUsers ?? 0).compareTo(a.numScoringUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareMember(AnimeDetails a, AnimeDetails b) {
    switch (model.yearlyRankingOrderBy) {
      case OrderBy.ascending:
        return (a.numListUsers ?? 0).compareTo(b.numListUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.numListUsers ?? 0).compareTo(a.numListUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareTotalDuration(AnimeDetails a, AnimeDetails b) {
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
      var mean = anime?.mean ?? 0;
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
      var mean = anime?.mean ?? 0;
      if (mean != 0) {
        totalVotes += anime?.numScoringUsers ?? 0;
        scoredEntries += 1;
      }
    }
    var result = totalVotes / scoredEntries;
    return '${result.toInt()}';
  }

  List<AnimeDetails> getAllEntriesYear(int year) {
    var list = model.getAllEntriesYear(year);
    var filtered = filterAnimeList(year, list);
    return filtered;
  }

  List<AnimeDetails> getCurrentYearRankList() {
    var year = model.selectedYear;
    var source = model.getRankingByYear(year);
    var filtered = filterAnimeList(year, source);
    return filtered;
  }

  List<AnimeDetails> getExcludedList() {
    var year = model.selectedYear;
    var result = <AnimeDetails>[];
    var source = getAllEntriesYear(year);
    var excludedList = List<int>.from(model.excludedAnimeIDs);
    for (var item in source) {
      var e = excludedList.any((x) => x == item.id);
      if (e) {
        result.add(item);
      }
    }

    result.sort((a, b) => b.mean.compareTo(a.mean));
    switch (model.yearlyRankingSortBy) {
      case TopAnimeSortBy.title:
        result.sort(compareTitle);
        break;
      case TopAnimeSortBy.score:
        result.sort(compareMean);
        break;
      case TopAnimeSortBy.member:
        result.sort(compareMember);
        break;
      case TopAnimeSortBy.scoringMember:
        result.sort(compareScoringMember);
        break;
      case TopAnimeSortBy.totalDuraton:
        result.sort(compareTotalDuration);
        break;
    }

    var noDuplicates = <AnimeDetails>[];
    for (var item in result) {
      var exists = noDuplicates.any((x) => x.id == item.id);
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

  void changeSortBy(TopAnimeSortBy sortBy) {
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
    var index = source.indexWhere((x) => x.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i < index) {
        selectAnime(source[i].id);
      }
    }
  }

  void selectAllBelowIndex(int selectedAnimeId) {
    var year = model.selectedYear;
    var source = model.getRankingByYear(year);
    var index = source.indexWhere((x) => x.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i > index) {
        selectAnime(source[i].id);
      }
    }
  }

  void selectAllAboveExcludedIndex(int selectedAnimeId) {
    var source = getExcludedList().map<int>((x) => x.id).toList();
    var index = source.indexWhere((x) => x == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i <= index) {
        selectAnime(source[i]);
      }
    }
  }

  void selectAllBelowExcludedIndex(int selectedAnimeId) {
    var source = getExcludedList().map<int>((x) => x.id).toList();
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

  void updateLoadingState(int index, bool state) {
    var loading = Map<int, bool>.from(model.loading);
    loading[index] = state;
    model.update(loading: loading);
  }

  void updateCurrentPageState(int index, int page) {
    var currentPages = Map<int, int>.from(model.currentPages);
    currentPages[index] = page;
    model.update(currentPages: currentPages);
  }

  void updateMalRankingState(int index, AnimeListGlobal rankings) {
    var malRankings = Map<int, AnimeListGlobal>.from(model.malRankings);
    malRankings[index] = rankings;
    model.update(malRankings: malRankings);
  }

  void gotoPrevPageMALSearch(int index) {
    var top = model.getTopByIndex(index);
    gotoPageMALRankings(index, prevPage: top?.paging?.prev);
  }

  void gotoNextPageMalRankings(int index) {
    var top = model.getTopByIndex(index);
    gotoPageMALRankings(index, nextPage: top?.paging?.next);
  }

  Future<void> loadMalRankings(int index) async {
    if (model.isLoading(index)) return;
    updateLoadingState(index, true);
    var slug = trycatch(() => malRankingTabs[index].toLowerCase().trim().replaceAll(' ', ''));
    if (slug == null || slug.isEmpty) {
      updateLoadingState(index, false);
      return;
    }
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: slug,
      offset: (model.currentPage(index) - 1) * ANIME_TOP_LIMIT,
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    updateLoadingState(index, false);
    updateMalRankingState(index, result);
  }

  Future<void> gotoPageMALRankings(int index, {String prevPage, String nextPage}) async {
    updateLoadingState(index, true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      prevPage: prevPage,
      nextPage: nextPage,
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );

    var params = Uri.parse(prevPage ?? nextPage).queryParameters;
    var offset = int.parse(params['offset']);
    var currentPage = (offset ~/ ANIME_TOP_LIMIT) + 1;

    updateLoadingState(index, false);
    updateCurrentPageState(index, currentPage);
    updateMalRankingState(index, result);
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
    print('"$year winter": ${winter?.list?.length ?? 0} entries');

    var spring = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'spring',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year spring": ${spring?.list?.length ?? 0} entries');

    var summer = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'summer',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year summer": ${summer?.list?.length ?? 0} entries');

    var fall = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'fall',
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    print('"$year fall": ${fall?.list?.length ?? 0} entries');

    var combined = <AnimeDetails>[];
    combined.addAll(winter?.list ?? []);
    combined.addAll(spring?.list ?? []);
    combined.addAll(summer?.list ?? []);
    combined.addAll(fall?.list ?? []);

    var yearlyRankingsCache = List<YearlyAnimeRankingsCache>.from(model.yearlyRankingsCache);
    var cache = YearlyAnimeRankingsCache(
      year: year,
      allYearEntries: combined,
      rankings: combined,
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
