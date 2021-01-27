import 'package:momentum/momentum.dart';

import '../_mconfig/index.dart';
import '../data/index.dart';

class AnimeCacheService extends MomentumService {
  List<AnimeDetails> _cached_user_list = [];
  List<AnimeDetails> get user_list => _cached_user_list ?? [];

  List<AnimeDetails> _rendered_user_list = [];
  List<AnimeDetails> get rendered_user_list => _rendered_user_list;

  void renderList(List<AnimeDetails> allAnime) {
    _rendered_user_list = allAnime ?? [];
  }

  List<AnimeDetails> getByStatus(String status) {
    try {
      var result = <AnimeDetails>[];
      result = rendered_user_list?.where((x) => status == 'all' || x?.myListStatus?.status == status)?.toList() ?? [];
      return result;
    } catch (e) {
      return [];
    }
  }

  void _addAnime(
    AnimeDetails anime, {
    bool readonly = false,
  }) async {
    var index = _cached_user_list.indexWhere((x) => x.id == anime.id);
    if (index > -1) {
      _cached_user_list.removeAt(index);
      if (!readonly) {
        await animeCacheBox.deleteAt(index);
      }
    }
    _cached_user_list.add(anime);
    if (!readonly) {
      animeCacheBox.add(anime.toRawJson());
    }
  }

  Future<void> cacheAnime(AnimeDetails anime) async {
    await _addAnime(anime);
  }

  Future<void> cacheAllAnime(List<AnimeDetails> allAnime) async {
    for (var anime in allAnime) {
      await _addAnime(anime);
    }
  }

  Future<void> retrieveAnimeCache() async {
    var count = animeCacheBox.length;
    for (var i = 0; i < count; i++) {
      var raw = animeCacheBox.getAt(i);
      var anime = AnimeDetails.fromRawJson(raw);
      await _addAnime(anime, readonly: true);
    }
    _rendered_user_list = _cached_user_list;
  }

  bool isInitialized() {
    return _cached_user_list != null && _cached_user_list.isNotEmpty;
  }
}
