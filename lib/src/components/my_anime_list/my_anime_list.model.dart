import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class MyAnimeListModel extends MomentumModel<MyAnimeListController> {
  MyAnimeListModel(
    MyAnimeListController controller, {
    int rebuilds,
    this.userAnimeHistory,
    this.loadingAnimeList,
    this.loadingHistory,
    this.updatingListStatus,
  })  : this._rebuilds = rebuilds,
        super(controller);

  final int _rebuilds;

  final UserAnimeHistory userAnimeHistory;
  final bool loadingAnimeList;
  final bool loadingHistory;
  final bool updatingListStatus;

  bool get loading => loadingAnimeList || loadingHistory || updatingListStatus;

  @override
  void update({
    int rebuilds,
    UserAnimeHistory userAnimeHistory,
    bool loadingAnimeList,
    bool loadingHistory,
    bool updatingListStatus,
  }) {
    MyAnimeListModel(
      controller,
      rebuilds: rebuilds ?? this._rebuilds,
      userAnimeHistory: userAnimeHistory ?? this.userAnimeHistory,
      loadingAnimeList: loadingAnimeList ?? this.loadingAnimeList,
      loadingHistory: loadingHistory ?? this.loadingHistory,
      updatingListStatus: updatingListStatus ?? this.updatingListStatus,
    ).updateMomentum();
  }

  void rebuild() {
    update(rebuilds: _rebuilds + 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'rebuilds': 0,
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
      rebuilds: 0,
      userAnimeHistory: UserAnimeHistory.fromJson(map['userAnimeHistory'] ?? {}),
      loadingAnimeList: false,
      loadingHistory: false,
      updatingListStatus: false,
    );
  }
}
