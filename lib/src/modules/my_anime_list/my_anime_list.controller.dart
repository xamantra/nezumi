import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../services/index.dart';
import '../../utils/index.dart';
import '../login/index.dart';
import '../settings/index.dart';
import 'index.dart';

class MyAnimeListController extends MomentumController<MyAnimeListModel> {
  ApiService get api => getService<ApiService>();

  @override
  MyAnimeListModel init() {
    return MyAnimeListModel(
      this,
      loadingAnimeList: false,
      loadingHistory: false,
    );
  }

  @override
  Future<void> bootstrapAsync() async {
    if (model.userAnimeList != null) {
      await loadAnimeHistory();
    } else {
      await loadData();
    }
  }

  Future<void> loadData() async {
    await loadAnimeList();
    await loadAnimeHistory();
  }

  Future<void> loadAnimeList() async {
    var l = dependOn<LoginController>().getActiveAccount();
    model.update(loadingAnimeList: true);
    var accessToken = l.token.accessToken;
    var result = await api.getUserAnimeList(
      accessToken: accessToken,
      animeParams: [average_episode_duration, num_episodes],
    );
    model.update(userAnimeList: result, loadingAnimeList: false);
  }

  bool _initialized = false;
  void initializeAnimeList() {
    if (!_initialized) {
      _initialized = true;
      if (model.fullUserAnimeList?.animeList == null) {
        loadFullAnimeList();
      }
    }
  }

  Future<void> loadFullAnimeList() async {
    try {
      var l = dependOn<LoginController>().getActiveAccount();
      model.update(loadingAnimeList: true);
      var accessToken = l.token.accessToken;
      var result = await api.getUserAnimeList(
        accessToken: accessToken,
        customFields: allAnimeListParams(),
        timeout: 360000,
      );
      model.update(fullUserAnimeList: result, userAnimeList: result, loadingAnimeList: false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAnimeHistory() async {
    var l = dependOn<LoginController>().getActiveAccount();
    model.update(loadingHistory: true);
    var history = await api.getAnimeHistory(username: l.profile.name);
    history = history?.bindDurations(model.userAnimeList);
    model.update(loadingHistory: false, userAnimeHistory: history);
  }

  int getMinutesPerEp() {
    var totalMins = 0;
    var totalEps = 0;
    var group = model.userAnimeHistory.groupByDay;
    var lastDay = group.keys.last;
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
    return result.toInt();
  }

  int getEpisodesPerDay() {
    var totalEps = 0;
    var group = model.userAnimeHistory.groupByDay;
    var lastDay = group.keys.last;
    var totalDays = group.entries.length - 1;
    group.forEach((key, list) {
      if (key == lastDay) {
        return;
      }
      totalEps += list.length;
    });

    var result = totalEps / totalDays;
    return result.toInt();
  }

  bool requiredMinsMet() {
    var settings = dependOn<SettingsController>().model;
    var requiredMinsPerEp = settings.requiredMinsPerEp;
    var minutesPerEp = getMinutesPerEp();
    var result = minutesPerEp >= requiredMinsPerEp;
    return result;
  }

  bool requiredEpsMet() {
    var settings = dependOn<SettingsController>().model;
    var requiredEpsPerDay = settings.requiredEpsPerDay;
    var episodesPerDay = getEpisodesPerDay();
    var result = episodesPerDay >= requiredEpsPerDay;
    return result;
  }

  List<HistoryGroupData> getGroupedHistoryData() {
    var historyGroup = <HistoryGroupData>[];
    var group = model.userAnimeHistory?.groupByDay;
    var lastDay = group?.keys?.last;
    group?.forEach((day, historyList) {
      if (lastDay == day) return;
      historyGroup.add(HistoryGroupData(day: day, historyList: historyList));
    });
    return historyGroup;
  }
}
