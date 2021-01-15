import 'package:momentum/momentum.dart';

import '../../data/index.dart';
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

  bool _animeListInitialized = false;
  void initializeAnimeList() {
    if (!_animeListInitialized) {
      _animeListInitialized = true;
      if (model.userAnimeList?.list == null) {
        loadAnimeList();
      }
    }
  }

  bool _animeHistoryInitialized = false;
  void initializeAnimeHistory() async {
    if (!_animeHistoryInitialized) {
      _animeHistoryInitialized = true;
      if (model.userAnimeList != null) {
        await loadAnimeHistory();
      } else {
        await loadData();
      }
    }
  }
  /* initializations */

  /* backend functions */
  Future<void> loadData() async {
    await loadAnimeList();
    await loadAnimeHistory();
  }

  Future<void> loadAnimeList() async {
    try {
      model.update(loadingAnimeList: true);
      var result = await api.getUserAnimeList(
        accessToken: accessToken,
        customFields: allAnimeListParams(omit: omitList1),
        timeout: 360000,
      );
      model.update(userAnimeList: result, loadingAnimeList: false);
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
      var current = List<AnimeDetails>.from(model.userAnimeList?.list ?? []);
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
      var userAnimeList = UserAnimeList(paging: result?.paging, list: current);
      model.update(userAnimeList: userAnimeList, loadingAnimeList: false);
    } catch (e) {
      print(e);
    }
    sortAnimeList();
  }

  Future<void> loadAnimeHistory() async {
    model.update(loadingHistory: true);
    var history = await api.getAnimeHistory(username: username);
    history = history?.bindDurations(model.userAnimeList);
    model.update(loadingHistory: false, userAnimeHistory: history);
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
      var result = model.userAnimeList?.list?.firstWhere((x) => x?.id == animeId, orElse: () => null);
      return result;
    } catch (e) {
      return null;
    }
  }
  /* front-end functions */

  // TODO; dynamic sorting (by title, date-update, content length ... DESC/ASC)
  void sortAnimeList() {
    var list = List<AnimeDetails>.from(model.userAnimeList?.list ?? []);
    list.sort((a, b) => b.myListStatus.updatedAt.compareTo(a.myListStatus.updatedAt));
    var sorted = UserAnimeList(paging: model?.userAnimeList?.paging, list: list);
    model.update(userAnimeList: sorted);
  }
}
