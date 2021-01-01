import 'package:momentum/momentum.dart';

import '../modules/anime-filter/index.dart';
import '../modules/anime-search/index.dart';
import '../modules/anime-update/index.dart';
import '../modules/app/index.dart';
import '../modules/login/index.dart';
import '../modules/my_anime_list/index.dart';
import '../modules/settings/index.dart';

List<MomentumController> controllers() {
  return <MomentumController>[
    AppController(),
    LoginController(),
    SettingsController(),
    AnimeFilterController(),
    AnimeUpdateController(),
    AnimeSearchController(),
    MyAnimeListController()
      ..config(
        strategy: BootstrapStrategy.lazyFirstBuild,
        lazy: true,
      ),
  ];
}
