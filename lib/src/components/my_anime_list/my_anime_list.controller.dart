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

  bool _animeListInitialized = false;
  void initializeAnimeList() {
    if (!_animeListInitialized) {
      _animeListInitialized = true;
      if (model.userAnimeList?.list == null) {
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

  void sortAnimeList() {
    var list = List<AnimeDetails>.from(model.userAnimeList?.list ?? []);
    switch (listSort.animeListSortBy) {
      case AnimeListSortBy.title:
        list.sort(compareTitle);
        break;
      case AnimeListSortBy.globalScore:
        list.sort(compareMean);
        break;
      case AnimeListSortBy.member:
        list.sort(compareMember);
        break;
      case AnimeListSortBy.userVotes:
        list.sort(compareScoringMember);
        break;
      case AnimeListSortBy.lastUpdated:
        list.sort(compareLastUpdated);
        break;
      case AnimeListSortBy.episodesWatched:
        list.sort(compareEpisodesWatched);
        break;
      case AnimeListSortBy.startWatchDate:
        list.sort(compareStartWatch);
        break;
      case AnimeListSortBy.finishWatchDate:
        list.sort(compareFinishWatch);
        break;
      case AnimeListSortBy.personalScore:
        list.sort(comparePersonalScore);
        break;
      case AnimeListSortBy.totalDuration:
        list.sort(compareTotalDuration);
        break;
    }

    model.update(
      userAnimeList: UserAnimeList(
        list: list,
        paging: model.userAnimeList?.paging,
      ),
    );
  }

  int compareTitle(AnimeDetails a, AnimeDetails b) {
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return a.title.compareTo(b.title);
        break;
      case OrderBy.descending:
        return b.title.compareTo(a.title);
        break;
    }
    return 0;
  }

  int comparePersonalScore(AnimeDetails a, AnimeDetails b) {
    var a_Score = a.myListStatus.score ?? 0;
    var b_Score = b.myListStatus.score ?? 0;
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return a_Score.compareTo(b_Score);
        break;
      case OrderBy.descending:
        return b_Score.compareTo(a_Score);
        break;
    }
    return 0;
  }

  int compareMean(AnimeDetails a, AnimeDetails b) {
    switch (listSort.orderAnimeBy) {
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
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return (a.numScoringUsers ?? 0).compareTo(b.numScoringUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.numScoringUsers ?? 0).compareTo(a.numScoringUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareLastUpdated(AnimeDetails a, AnimeDetails b) {
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return a.myListStatus.updatedAt.compareTo(b.myListStatus.updatedAt);
        break;
      case OrderBy.descending:
        return b.myListStatus.updatedAt.compareTo(a.myListStatus.updatedAt);
        break;
    }
    return 0;
  }

  int compareMember(AnimeDetails a, AnimeDetails b) {
    switch (listSort.orderAnimeBy) {
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
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return a.totalDuration.compareTo(b.totalDuration);
        break;
      case OrderBy.descending:
        return b.totalDuration.compareTo(a.totalDuration);
        break;
    }
    return 0;
  }

  int compareEpisodesWatched(AnimeDetails a, AnimeDetails b) {
    var a_Eps = a.myListStatus?.numEpisodesWatched ?? 0;
    var b_Eps = b.myListStatus?.numEpisodesWatched ?? 0;
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        return a_Eps.compareTo(b_Eps);
        break;
      case OrderBy.descending:
        return b_Eps.compareTo(a_Eps);
        break;
    }
    return 0;
  }

  int compareStartWatch(AnimeDetails a, AnimeDetails b) {
    var a_Start = a.myListStatus.startDate;
    var b_Start = b.myListStatus.startDate;
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        if (a_Start == null) {
          return -1;
        }
        if (b_Start == null) {
          return 1;
        }
        return a_Start.compareTo(b_Start);
        break;
      case OrderBy.descending:
        if (a_Start == null) {
          return 1;
        }
        if (b_Start == null) {
          return -1;
        }
        return b_Start.compareTo(a_Start);
        break;
    }
    return 0;
  }

  int compareFinishWatch(AnimeDetails a, AnimeDetails b) {
    var a_Finish = a.myListStatus.finishDate;
    var b_Finish = b.myListStatus.finishDate;
    switch (listSort.orderAnimeBy) {
      case OrderBy.ascending:
        if (a_Finish == null) {
          return -1;
        }
        if (b_Finish == null) {
          return 1;
        }
        return a_Finish.compareTo(b_Finish);
        break;
      case OrderBy.descending:
        if (a_Finish == null) {
          return 1;
        }
        if (b_Finish == null) {
          return -1;
        }
        return b_Finish.compareTo(a_Finish);
        break;
    }
    return 0;
  }
}
