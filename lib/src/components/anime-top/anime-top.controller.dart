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
    var original = List<AnimeDataItem>.from(model.selectedYearRankings?.data ?? []);
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

    var result = AnimeListGlobal(data: noDuplicates);
    model.update(selectedYearRankings: result);
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
    var list = model.selectedYearRankings?.data ?? [];
    return list.length.toString();
  }

  String getMeanScore() {
    var list = model.selectedYearRankings?.data ?? [];
    var totalScore = 0.0;
    for (var anime in list) {
      totalScore += anime.node.mean;
    }
    var result = totalScore / list.length;
    return result.toStringAsFixed(3);
  }

  void toggleOrderBy() {
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
    model.update(loadingYearlyRankings: false, selectedYearRankings: result);
    validateAndSortYearlyRankings();
  }
}
