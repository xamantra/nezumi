import 'package:intl/intl.dart';

import '../../absract/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeWatchDateFilter extends AnimeFilterBase {
  AnimeWatchDateFilter({
    this.started,
    this.finished,
  });

  final DateTime started;
  final DateTime finished;

  String get startFormatted {
    try {
      return DateFormat('yyyy-MM-dd').format(started);
    } catch (e) {
      return null;
    }
  }

  String get finishFormatted {
    try {
      return DateFormat('yyyy-MM-dd').format(finished);
    } catch (e) {
      return null;
    }
  }

  AnimeWatchDateFilter copyWith({
    DateTime started,
    DateTime finished,
  }) {
    return AnimeWatchDateFilter(
      started: started ?? this.started,
      finished: finished ?? this.finished,
    );
  }

  @override
  bool match(AnimeData animeData) {
    var startMatched = startDateMatch(animeData);
    var finishMatched = finishDateMatch(animeData);
    var matched = startMatched && finishMatched;
    return matched;
  }

  bool startDateMatch(AnimeData animeData) {
    var animeWatchStart = animeStartWatchParseDate(animeData);
    if (animeWatchStart == null || started == null) {
      return false;
    }
    // animeData.node.id == 40550
    var sameMomentOrAfter = isSameDay(animeWatchStart, started) || animeWatchStart.isAfter(started);
    return sameMomentOrAfter;
  }

  bool finishDateMatch(AnimeData animeData) {
    var animeWatchFinish = animeFinishWatchParseDate(animeData);
    if (animeWatchFinish == null || finished == null) {
      return false;
    }
    var sameMomentOrBefore = isSameDay(animeWatchFinish, finished) || animeWatchFinish.isBefore(finished);
    return sameMomentOrBefore;
  }
}
