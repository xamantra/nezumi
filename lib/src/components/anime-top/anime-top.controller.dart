import 'package:momentum/momentum.dart';

import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeTopController extends MomentumController<AnimeTopModel> with AuthMixin, CoreMixin {
  @override
  AnimeTopModel init() {
    return AnimeTopModel(
      this,
      loadingTopAll: false,
      loadingTopAiring: false,
      loadingTopUpcoming: false,
      loadingTopTV: false,
      loadingTopMovies: false,
      loadingTopOVA: false,
      loadingTopSpecials: false,
      loadingTopPopularity: false,
      loadingTopFavorites: false,
    );
  }

  Future<void> loadTopAll() async {
    if (model.loadingTopAll) return;
    model.update(loadingTopAll: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'all',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopAll: false, topAll: result);
  }

  Future<void> loadTopAiring() async {
    if (model.loadingTopAiring) return;
    model.update(loadingTopAiring: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'airing',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopAiring: false, topAiring: result);
  }

  Future<void> loadTopUpcoming() async {
    if (model.loadingTopUpcoming) return;
    model.update(loadingTopUpcoming: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'upcoming',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopUpcoming: false, topUpcoming: result);
  }

  Future<void> loadTopTV() async {
    if (model.loadingTopTV) return;
    model.update(loadingTopTV: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'tv',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopTV: false, topTV: result);
  }

  Future<void> loadTopMovies() async {
    if (model.loadingTopMovies) return;
    model.update(loadingTopMovies: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'movie',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopMovies: false, topMovies: result);
  }

  Future<void> loadTopOVA() async {
    if (model.loadingTopOVA) return;
    model.update(loadingTopOVA: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'ova',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopOVA: false, topOVA: result);
  }

  Future<void> loadTopSpecials() async {
    if (model.loadingTopSpecials) return;
    model.update(loadingTopSpecials: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'special',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopSpecials: false, topSpecials: result);
  }

  Future<void> loadTopPopularity() async {
    if (model.loadingTopPopularity) return;
    model.update(loadingTopPopularity: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'bypopularity',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopPopularity: false, topPopularity: result);
  }

  Future<void> loadTopFavorites() async {
    if (model.loadingTopFavorites) return;
    model.update(loadingTopFavorites: true);
    var result = await api.animeTop(
      accessToken: accessToken,
      timeout: 30000,
      type: 'favorite',
      fields: allAnimeListParams(type: 'my_list_status', omit: [synopsis, background]),
    );
    model.update(loadingTopFavorites: false, topFavorites: result);
  }
}
