import 'package:momentum/momentum.dart';

import '../components/anime-filter/index.dart';
import '../components/anime-search/index.dart';
import '../components/anime-update/index.dart';
import '../components/app/index.dart';
import '../components/login/index.dart';
import '../components/my_anime_list/index.dart';
import '../components/settings/index.dart';

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