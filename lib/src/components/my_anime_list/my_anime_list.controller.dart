import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class MyAnimeListController extends MomentumController<MyAnimeListModel> with CoreMixin, AuthMixin {
  /* initializations */
  @override
  MyAnimeListModel init() {
    return MyAnimeListModel(
      this,
      loadingAnimeList: false,
      loadingHistory: false,
      updatingListStatus: false,
    );
  }

  bool get userListInitialized => animeCache.isInitialized();

  bool _animeListInitialized = false;
  void initializeAnimeList() {
    if (!_animeListInitialized) {
      _animeListInitialized = true;
      if (!userListInitialized) {
        loadAnimeList();
      } else {
        sortAnimeList();
      }
    }
  }

  bool _animeHistoryInitialized = false;
  void initializeAnimeHistory() async {
    if (!_animeHistoryInitialized) {
      _animeHistoryInitialized = true;
      if (userListInitialized) {
        await loadAnimeHistory();
      } else {
        await loadData();
      }
    }
  }
  /* initializations */

  bool inMyList(int animeId) {
    var list = animeCache.user_list;
    var result = (list ?? []).any((x) => x?.id == animeId);
    return result;
  }

  List<AnimeDetails> getByStatus(String status) {
    return animeCache.getByStatus(status);
  }

  /* backend functions */
  Future<void> loadData() async {
    await loadAnimeList();
    await loadAnimeHistory();
  }

  Future<void> loadAnimeList() async {
    try {
      model.update(loadingAnimeList: true);
      await animeCache.retrieveAnimeCache();
      if (userListInitialized) {
        model.update(loadingAnimeList: false);
        sortAnimeList();
        return;
      }
      var result = await api.getUserAnimeList(
        accessToken: accessToken,
        customFields: allAnimeListParams(omit: omitList1),
        timeout: 360000,
      );
      await animeCache.cacheAllAnime(result.list);
      model.update(loadingAnimeList: false);
    } catch (e) {
      print(e);
      model.update(loadingAnimeList: false);
    }
    sortAnimeList();
  }

  Future<void> loadAnimeListByStatus(String status) async {
    try {
      if (status == null) return;
      if (status == 'all') {
        loadAnimeList();
        return;
      }
      var list = animeCache.user_list;
      var current = List<AnimeDetails>.from(list ?? []);
      model.update(loadingAnimeList: true);
      var result = await api.getUserAnimeList(
        accessToken: accessToken,
        status: status,
        customFields: allAnimeListParams(omit: omitList1),
        timeout: 360000,
      );
      var newlyLoaded = result?.list ?? [];
      await Future.forEach<AnimeDetails>(
        newlyLoaded,
        (item) async {
          var index = current.indexWhere((x) => x.id == item.id);
          if (index >= 0) {
            current.replaceRange(index, index + 1, [item]);
          } else {
            current.add(item);
          }
        },
      );
      await animeCache.cacheAllAnime(current);
      model.update(loadingAnimeList: false);
    } catch (e) {
      print(e);
    }
    sortAnimeList();
  }

  Future<void> loadAnimeHistory() async {
    model.update(loadingHistory: true);
    var history = await api.getAnimeHistory(username: username);
    if (history == null) {
      var fromCache = animeHistoryCache.getCache();
      model.update(loadingHistory: false, userAnimeHistory: fromCache);
      return;
    }
    var list = animeCache.user_list;
    history = history?.bindDurations(list);
    model.update(loadingHistory: false, userAnimeHistory: history);
    animeHistoryCache.setCache(history);
  }

  /* backend functions */

  /* front-end functions */
  int getMinutesPerEp() {
    var totalMins = 0;
    var totalEps = 0;
    var group = model.userAnimeHistory?.groupByDay ?? {};
    var lastDay = trycatch(() => group.keys.last);
    group.forEach((key, list) {
      if (key == lastDay) {
        return;
      }
      for (var history in list) {
        totalMins += history.durationMins;
      }
      totalEps += list.length;
    });

    var result = totalMins / totalEps;
    return trycatch(() => result.toInt(), 0);
  }

  int getEpisodesPerDay() {
    var totalEps = 0;
    var group = model.userAnimeHistory?.groupByDay ?? {};
    var lastDay = trycatch(() => group.keys.last);
    var totalDays = group.entries.length - 1;
    group.forEach((key, list) {
      if (key == lastDay) {
        return;
      }
      totalEps += list.length;
    });

    var result = totalEps / totalDays;
    return trycatch(() => result.toInt(), 0);
  }

  double getHoursPerDay() {
    var totalMinutes = getMinutesPerEp() * getEpisodesPerDay();
    var result = double.parse((totalMinutes / 60).toStringAsFixed(2));
    return result;
  }

  bool requiredMinsMet() {
    var requiredMinsPerEp = settings.requiredMinsPerEp;
    var minutesPerEp = getMinutesPerEp();
    var result = minutesPerEp >= requiredMinsPerEp;
    return result;
  }

  bool requiredEpsMet() {
    var requiredEpsPerDay = settings.requiredEpsPerDay;
    var episodesPerDay = getEpisodesPerDay();
    var result = episodesPerDay >= requiredEpsPerDay;
    return result;
  }

  bool requiredHoursMet() {
    var requiredHoursPerDay = settings.requiredHoursPerDay;
    var hoursPerDay = getHoursPerDay();
    var result = hoursPerDay >= requiredHoursPerDay;
    return result;
  }

  List<HistoryGroupData> getGroupedHistoryData() {
    var historyGroup = <HistoryGroupData>[];
    var group = model.userAnimeHistory?.groupByDay;
    var lastDay = trycatch(() => group?.keys?.last);
    group?.forEach((day, historyList) {
      if (lastDay == day) return;
      historyGroup.add(HistoryGroupData(day: day, historyList: historyList));
    });
    return historyGroup;
  }

  AnimeDetails getAnime(int animeId) {
    try {
      var list = animeCache.user_list;
      var result = list?.firstWhere((x) => x?.id == animeId, orElse: () => null);
      return result;
    } catch (e) {
      return null;
    }
  }
  /* front-end functions */

  void sortAnimeList() {
    var list = List<AnimeDetails>.from(animeCache.user_list ?? []);
    switch (listSort.animeListSortBy) {
      case AnimeListSortBy.title:
        list.sort(sorter(compareTitle));
        break;
      case AnimeListSortBy.globalScore:
        list.sort(sorter(compareMean));
        break;
      case AnimeListSortBy.member:
        list.sort(sorter(compareMember));
        break;
      case AnimeListSortBy.userVotes:
        list.sort(sorter(compareScoringMember));
        break;
      case AnimeListSortBy.lastUpdated:
        list.sort(sorter(compareLastUpdated));
        break;
      case AnimeListSortBy.episodesWatched:
        list.sort(sorter(compareEpisodesWatched));
        break;
      case AnimeListSortBy.startWatchDate:
        list.sort(sorter(compareStartWatch));
        break;
      case AnimeListSortBy.finishWatchDate:
        list.sort(sorter(compareFinishWatch));
        break;
      case AnimeListSortBy.personalScore:
        list.sort(sorter(comparePersonalScore));
        break;
      case AnimeListSortBy.totalDuration:
        list.sort(sorter(compareTotalDuration));
        break;
      case AnimeListSortBy.startAirDate:
        list.sort(sorter(compareStartAir));
        break;
      case AnimeListSortBy.endAirDate:
        list.sort(sorter(compareEndAir));
        break;
    }

    animeCache.renderList(list);
    model.rebuild();
  }

  int Function(AnimeDetails, AnimeDetails) sorter(int Function(OrderBy, AnimeDetails, AnimeDetails) sorter) {
    return (a, b) {
      return sorter(listSort.animeListOrderBy, a, b);
    };
  }
}
