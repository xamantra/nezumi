import 'package:momentum/momentum.dart';

import '../../data/index.dart';
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

  // String getTop100MeanScore() {
  //   var list = model.selectedYearRankings?.data ?? [];
  //   if (list.length > 100) {
  //     var source = list.getRange(0, 100).toList();
  //     var totalScore = 0.0;
  //     for (var anime in source) {
  //       totalScore += anime.node.mean;
  //     }
  //     var result = totalScore / source.length;
  //     return result.toStringAsFixed(3);
  //   }
  //   return getMeanScore();
  // }

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
