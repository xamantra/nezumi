import 'package:momentum/momentum.dart';

import '../modules/login/index.dart';
import '../modules/my_anime_list/index.dart';
import '../modules/settings/index.dart';

List<MomentumController> controllers() {
  return <MomentumController>[
    LoginController(),
    SettingsController(),
    MyAnimeListController()
      ..config(
        strategy: BootstrapStrategy.lazyFirstBuild,
        lazy: true,
      ),
  ];
}
