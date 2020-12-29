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

DateTime animeStartAirParseDate(AnimeData animeData) {
  var startDate = animeData?.node?.startDate;
  if (startDate == null || startDate.isEmpty) {
    return null;
  }

  var split = startDate.split('-');
  if (split.length < 3) {
    return null;
  }

  var datetime = DateFormat('yyyy-MM-dd').parse(startDate);
  return datetime;
}

DateTime animeFinishAirParseDate(AnimeData animeData) {
  var endDate = animeData?.node?.endDate;
  if (endDate == null || endDate.isEmpty) {
    return null;
  }

  var split = endDate.split('-');
  if (split.length < 3) {
    return null;
  }

  var datetime = DateFormat('yyyy-MM-dd').parse(endDate);
  return datetime;
}
