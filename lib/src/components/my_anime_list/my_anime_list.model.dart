import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/myanimelist.user_anime_list.dart';
import 'index.dart';

class MyAnimeListModel extends MomentumModel<MyAnimeListController> {
  MyAnimeListModel(
    MyAnimeListController controller, {
    this.userAnimeList,
    this.userAnimeHistory,
    this.loadingAnimeList,
    this.loadingHistory,
    this.updatingListStatus,
  }) : super(controller);

  final UserAnimeList userAnimeList;
  final UserAnimeHistory userAnimeHistory;
  final bool loadingAnimeList;
  final bool loadingHistory;
  final bool updatingListStatus;

  bool get loading => loadingAnimeList || loadingHistory || updatingListStatus;

  bool inMyList(int animeId) {
    var result = (userAnimeList?.list ?? []).any((x) => x?.id == animeId);
    return result;
  }

  @override
  void update({
    UserAnimeList userAnimeList,
    UserAnimeHistory userAnimeHistory,
    bool loadingAnimeList,
    bool loadingHistory,
    bool updatingListStatus,
  }) {
    MyAnimeListModel(
      controller,
      userAnimeList: userAnimeList ?? this.userAnimeList,
      userAnimeHistory: userAnimeHistory ?? this.userAnimeHistory,
      loadingAnimeList: loadingAnimeList ?? this.loadingAnimeList,
      loadingHistory: loadingHistory ?? this.loadingHistory,
      updatingListStatus: updatingListStatus ?? this.updatingListStatus,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'userAnimeList': userAnimeList?.toJson(),
      'userAnimeHistory': userAnimeHistory?.toJson(),
      'loadingAnimeList': false,
      'loadingHistory': false,
      'updatingListStatus': false,
    };
  }

  MyAnimeListModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return MyAnimeListModel(
      controller,
      userAnimeList: UserAnimeList.fromJson(map['userAnimeList'] ?? {}),
      userAnimeHistory: UserAnimeHistory.fromJson(map['userAnimeHistory'] ?? {}),
      loadingAnimeList: false,
      loadingHistory: false,
      updatingListStatus: false,
    );
  }
}
