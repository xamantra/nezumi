import '../data/index.dart';

bool mustCountOnStats(AnimeDetails anime) {
  var s = anime.myListStatus.status;
  return s != 'plan_to_watch';
}
