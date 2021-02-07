import 'package:momentum/momentum.dart';

import '../services/index.dart';
import '../widgets/index.dart';
import '../widgets/pages/anime-list/tabs/index.dart';
import '../widgets/pages/index.dart';

List<MomentumService> services() {
  return [
    ApiService(),
    FilterWigdetService(),
    AnimeFilterListService(),
    AnimeCacheService(),
    AnimeHistoryCacheService(),
    MomentumRouter(
      [
        Login(),
        PageScaffold(page: MyListTabPage()),
      ],
      enablePersistence: true,
    ),
  ];
}
