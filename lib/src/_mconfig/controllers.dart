import 'package:momentum/momentum.dart';

import '../components/anime-filter/index.dart';
import '../components/anime-search/index.dart';
import '../components/anime-stats/index.dart';
import '../components/anime-top/index.dart';
import '../components/anime-update/index.dart';
import '../components/app/index.dart';
import '../components/export-list/index.dart';
import '../components/list-sort/index.dart';
import '../components/login/index.dart';
import '../components/my_anime_list/index.dart';
import '../components/session/index.dart';
import '../components/settings/index.dart';

List<MomentumController> controllers() {
  return <MomentumController>[
    AppController(),
    LoginController(),
    SettingsController(),
    ExportListController(),
    AnimeFilterController(),
    AnimeUpdateController(),
    AnimeSearchController(),
    AnimeTopController(),
    ListSortController(),
    AnimeStatsController(),
    SessionController()
      ..config(
        strategy: BootstrapStrategy.lazyFirstCall,
        lazy: true,
      ),
    MyAnimeListController()
      ..config(
        strategy: BootstrapStrategy.lazyFirstBuild,
        lazy: true,
      ),
  ];
}
