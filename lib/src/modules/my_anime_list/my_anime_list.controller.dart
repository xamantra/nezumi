import 'package:flutter/foundation.dart';
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
      if (model.userAnimeList?.animeList == null) {
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
        customFields: allAnimeListParams(omit: [synopsis, background]),
        timeout: 360000,
      );
      model.update(userAnimeList: result, loadingAnimeList: false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAnimeListByStatus(String status) async {
    try {
      if (status == null) return;
      if (status == 'all') {
        loadAnimeList();
        return;
      }
      var current = List<AnimeData>.from(model.userAnimeList?.animeList ?? []);
      model.update(loadingAnimeList: true);
      var result = await api.getUserAnimeList(
        accessToken: accessToken,
        status: status,
        customFields: allAnimeListParams(),
        timeout: 360000,
      );
      var newlyLoaded = result?.animeList ?? [];
      await Future.forEach<AnimeData>(
        newlyLoaded,
        (item) async {
          var index = current.indexWhere((x) => x.node.id == item.node.id);
          if (index >= 0) {
            current.replaceRange(index, index + 1, [item]);
          } else {
            current.add(item);
          }
        },
      );
      current.sort((a, b) => a.node.title.compareTo(b.node.title));
      var userAnimeList = UserAnimeList(paging: result?.paging, animeList: current);
      model.update(userAnimeList: userAnimeList, loadingAnimeList: false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAnimeHistory() async {
    model.update(loadingHistory: true);
    var history = await api.getAnimeHistory(username: username);
    history = history?.bindDurations(model.userAnimeList);
    model.update(loadingHistory: false, userAnimeHistory: history);
  }

  Future<void> updateAnimeStatus({
    @required int animeId,
    String status,
    bool is_rewatching,
    int score,
    int num_watched_episodes,
    int priority,
    int num_times_rewatched,
    int rewatch_value,
    List<String> tags,
    String comments,
    String start_date,
    String finish_date,
  }) async {
    model.update(updatingListStatus: true);
    var response = await api.updateAnimeStatus(
      accessToken: accessToken,
      animeId: animeId,
      num_watched_episodes: num_watched_episodes,
    );
    if (response != null) {
      var currentList = List<AnimeData>.from(model.userAnimeList?.animeList ?? []);
      var selectedAnime = currentList.firstWhere((x) => x.node.id == animeId, orElse: () => null);
      var updated = selectedAnime.copyWith(
        listStatus: ListStatus(
          status: response.status,
          score: response.score,
          numEpisodesWatched: response.numEpisodesWatched,
          isRewatching: response.isRewatching,
          updatedAt: response.updatedAt,
          comments: response.comments,
          tags: response.tags,
          priority: response.priority,
          numTimesRewatched: response.numTimesRewatched,
          rewatchValue: response.rewatchValue,
          startDate: response.startDate,
          finishDate: response.finishDate,
        ),
      );
      var index = currentList.indexWhere((x) => x.node.id == animeId);
      currentList[index] = updated;
      var newList = model.userAnimeList.copyWith(data: currentList);
      model.update(userAnimeList: newList);
    }
    model.update(updatingListStatus: false);
  }

  void incrementEpisode(int animeId) {
    var anime = (model.userAnimeList?.animeList ?? []).firstWhere((x) => x.node.id == animeId, orElse: () => null);
    var episode = (anime?.listStatus?.numEpisodesWatched ?? 0) + 1;
    updateAnimeStatus(animeId: animeId, num_watched_episodes: episode);
  }

  void decrementEpisode(int animeId) {
    var anime = (model.userAnimeList?.animeList ?? []).firstWhere((x) => x.node.id == animeId, orElse: () => null);
    var episode = (anime?.listStatus?.numEpisodesWatched ?? 0) - 1;
    updateAnimeStatus(animeId: animeId, num_watched_episodes: episode);
  }
  /* backend functions */

  /* front-end functions */
  int getMinutesPerEp() {
    var totalMins = 0;
    var totalEps = 0;
    var group = model.userAnimeHistory.groupByDay;
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
    var group = model.userAnimeHistory.groupByDay;
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

  AnimeData getAnime(int animeId) {
    try {
      var result = model.userAnimeList?.animeList?.firstWhere((x) => x.node?.id == animeId, orElse: () => null);
      return result;
    } catch (e) {
      return null;
    }
  }
  /* front-end functions */
}
