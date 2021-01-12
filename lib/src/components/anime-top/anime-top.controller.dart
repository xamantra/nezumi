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
      selectedYearRankings: [],
      selectedYearRankingsAll: [],
      excludedAnimeIDs: [],
      selectedAnimeIDs: [],
    );
  }

  void prevYear() {
    var selected = model.selectedYear;
    model.update(selectedYear: selected - 1);
    loadYearRankings();
  }

  void nextYear() {
    var selected = model.selectedYear;
    var now = DateTime.now().year;
    if (selected == now) return;
    model.update(selectedYear: selected + 1);
    loadYearRankings();
  }

  void validateAndSortYearlyRankings() {
    var year = model.selectedYear;
    var original = List<AnimeDataItem>.from(model.selectedYearRankingsAll ?? []);
    var filtered = original.where((x) {
      var d = parseDate(x.node.startDate);
      var matchedYear = d?.year == year;
      var hasScore = (x?.node?.mean ?? 0) > 0;
      return matchedYear && hasScore;
    }).toList();

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

    var noDuplicates = <AnimeDataItem>[];
    for (var item in filtered) {
      var exists = noDuplicates.any((x) => x.node.id == item.node.id);
      if (!exists) {
        noDuplicates.add(item);
      }
    }

    var filterExcluded = <AnimeDataItem>[];
    for (var item in noDuplicates) {
      var e = model.isAnimeExcluded(item.node.id);
      if (!e) {
        filterExcluded.add(item);
      }
    }

    var noHentai = <AnimeDataItem>[];
    for (var item in filterExcluded) {
      var hentai = item.node.genres.any((x) => x.name?.toLowerCase() == 'hentai');
      if (!hentai) {
        noHentai.add(item);
      }
    }

    model.update(selectedYearRankings: noHentai);
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
    var list = model.selectedYearRankings ?? [];
    return list.length.toString();
  }

  String getMeanScore() {
    var list = model.selectedYearRankings ?? [];
    if (list.isEmpty) return '0.0';
    var totalScore = 0.0;
    for (var anime in list) {
      totalScore += anime.node.mean;
    }
    var result = totalScore / list.length;
    return result.toStringAsFixed(3);
  }

  List<AnimeDataItem> getExcludedList() {
    var result = <AnimeDataItem>[];
    var source = List<AnimeDataItem>.from(model.selectedYearRankingsAll ?? []);
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

    var sortedExcludedIDs = result.map<int>((x) => x.node.id).toList();
    model.update(excludedAnimeIDs: sortedExcludedIDs);

    return result;
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

    model.update(excludedAnimeIDs: excludedAnimeIDs);
    clearSelection();
    validateAndSortYearlyRankings();
  }

  void selectAllAboveIndex(int selectedAnimeId) {
    var source = List<AnimeDataItem>.from(model.selectedYearRankings ?? []);
    var index = source.indexWhere((x) => x.node.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i < index) {
        selectAnime(source[i].node.id);
      }
    }
  }

  void selectAllBelowIndex(int selectedAnimeId) {
    var source = List<AnimeDataItem>.from(model.selectedYearRankings ?? []);
    var index = source.indexWhere((x) => x.node.id == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i > index) {
        selectAnime(source[i].node.id);
      }
    }
  }

  void selectAllAboveExcludedIndex(int selectedAnimeId) {
    var source = List<int>.from(model.excludedAnimeIDs ?? []);
    var index = source.indexWhere((x) => x == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i <= index) {
        selectAnime(source[i]);
      }
    }
  }

  void selectAllBelowExcludedIndex(int selectedAnimeId) {
    var source = List<int>.from(model.excludedAnimeIDs ?? []);
    var index = source.indexWhere((x) => x == selectedAnimeId);

    for (var i = 0; i < source.length; i++) {
      if (i >= index) {
        selectAnime(source[i]);
      }
    }
  }

  Future<void> loadTopAll() async {
    if (model.loadingTopAll) return;
    model.update(loadingTopAll: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'all',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
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
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    print('"$year winter": ${winter?.data?.length ?? 0} entries');

    var spring = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'spring',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    print('"$year spring": ${spring?.data?.length ?? 0} entries');

    var summer = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'summer',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    print('"$year summer": ${summer?.data?.length ?? 0} entries');

    var fall = await api.animeSeason(
      accessToken: accessToken,
      timeout: 30000,
      year: year,
      season: 'fall',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    print('"$year fall": ${fall?.data?.length ?? 0} entries');

    var combined = <AnimeDataItem>[];
    combined.addAll(winter?.data ?? []);
    combined.addAll(spring?.data ?? []);
    combined.addAll(summer?.data ?? []);
    combined.addAll(fall?.data ?? []);

    var result = AnimeListGlobal(data: combined);
    model.update(
      loadingYearlyRankings: false,
      selectedYearRankings: result.data,
      selectedYearRankingsAll: result.data,
    );
    validateAndSortYearlyRankings();
  }
}
