import 'package:intl/intl.dart';

import '../data/index.dart';

DateTime animeStartWatchParseDate(AnimeData animeData) {
  // yyyy-mm-dd -> valid (datetime)
  // yyyy-mm -> invalidate (null)
  // yyyy -> invalidate (null)

  var animeWatchStart = animeData?.listStatus?.startDate;
  if (animeWatchStart == null || animeWatchStart.isEmpty) {
    return null;
  }

  var split = animeWatchStart.split('-');
  if (split.length < 3) {
    return null;
  }

  var datetime = DateFormat('yyyy-MM-dd').parse(animeWatchStart);
  return datetime;
}

DateTime animeFinishWatchParseDate(AnimeData animeData) {
  // yyyy-mm-dd -> valid (datetime)
  // yyyy-mm -> invalidate (null)
  // yyyy -> invalidate (null)

  var animeWatchFinish = animeData?.listStatus?.finishDate;
  if (animeWatchFinish == null || animeWatchFinish.isEmpty) {
    return null;
  }

  var split = animeWatchFinish.split('-');
  if (split.length < 3) {
    return null;
  }

  var datetime = DateFormat('yyyy-MM-dd').parse(animeWatchFinish);
  return datetime;
}
