import 'package:intl/intl.dart';

import '../../absract/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeFilterReleaseDateData extends AnimeFilterData {
  AnimeFilterReleaseDateData({
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

  AnimeFilterReleaseDateData copyWith({
    DateTime started,
    DateTime finished,
  }) {
    return AnimeFilterReleaseDateData(
      started: started ?? this.started,
      finished: finished ?? this.finished,
    );
  }

  @override
  bool match(AnimeData animeData) {
    if (started == null && finished == null) {
      return true;
    }
    var startMatched = startDateMatch(animeData);
    var finishMatched = finishDateMatch(animeData);
    var matched = startMatched && finishMatched;
    return matched;
  }

  bool startDateMatch(AnimeData animeData) {
    var startAir = animeStartAirParseDate(animeData);
    if (startAir == null || started == null) {
      return false;
    }
    var sameMomentOrAfter = isSameDay(startAir, started) || startAir.isAfter(started);
    return sameMomentOrAfter;
  }

  bool finishDateMatch(AnimeData animeData) {
    var endAir = animeFinishAirParseDate(animeData);
    if (endAir == null || finished == null) {
      return false;
    }
    var sameMomentOrBefore = isSameDay(endAir, finished) || endAir.isBefore(finished);
    return sameMomentOrBefore;
  }
}
