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
  }) : super(controller);

  final UserAnimeList userAnimeList;
  final UserAnimeHistory userAnimeHistory;
  final bool loadingAnimeList;
  final bool loadingHistory;

  bool get loading => loadingAnimeList || loadingHistory;

  @override
  void update({
    UserAnimeList userAnimeList,
    UserAnimeHistory userAnimeHistory,
    bool loadingAnimeList,
    bool loadingHistory,
  }) {
    MyAnimeListModel(
      controller,
      userAnimeList: userAnimeList ?? this.userAnimeList,
      userAnimeHistory: userAnimeHistory ?? this.userAnimeHistory,
      loadingAnimeList: loadingAnimeList ?? this.loadingAnimeList,
      loadingHistory: loadingHistory ?? this.loadingHistory,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'userAnimeList': userAnimeList?.toJson(),
      'userAnimeHistory': userAnimeHistory?.toJson(),
      'loadingAnimeList': false,
      'loadingHistory': false,
    };
  }

  MyAnimeListModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return MyAnimeListModel(
      controller,
      userAnimeList: UserAnimeList.fromJson(map['userAnimeList'] ?? {}),
      userAnimeHistory: UserAnimeHistory.fromJson(map['userAnimeHistory'] ?? {}),
      loadingAnimeList: map['loadingAnimeList'],
      loadingHistory: map['loadingHistory'],
    );
  }
}
