import 'package:momentum/momentum.dart';

import '../_mconfig/index.dart';
import '../data/index.dart';

class AnimeHistoryCacheService extends MomentumService {
  Future<void> setCache(UserAnimeHistory history) async {
    await animeHistoryCacheBox.put('anime_history', history.toRawJson());
  }

  UserAnimeHistory getCache() {
    var raw = animeHistoryCacheBox.get('anime_history');
    var cache = UserAnimeHistory.fromRawJson(raw);
    return cache;
  }
}
