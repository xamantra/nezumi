import '../../absract/index.dart';
import '../index.dart';

enum AnimeFilterRewatchType {
  none,
  anyRewatched,
  exactCount,
  range,
  lessThan,
  moreThan,
}

String getRewatchFilterTypeLabel(AnimeFilterRewatchType type) {
  switch (type) {
    case AnimeFilterRewatchType.none:
      return 'No Filter';
      break;
    case AnimeFilterRewatchType.anyRewatched:
      return 'Any Rewatched';
      break;
    case AnimeFilterRewatchType.exactCount:
      return 'Exact Count';
      break;
    case AnimeFilterRewatchType.range:
      return 'Between Range';
      break;
    case AnimeFilterRewatchType.lessThan:
      return 'Less Than';
      break;
    case AnimeFilterRewatchType.moreThan:
      return 'More Than';
      break;
  }
  return 'Any Rewatched';
}

class AnimeFilterRewatchData extends AnimeFilterData {
  AnimeFilterRewatchData({
    this.type = AnimeFilterRewatchType.none,
    this.exactCount = null,
    this.range = const [null, null],
    this.lessThan = null,
    this.moreThan = null,
  });

  final AnimeFilterRewatchType type;
  final int exactCount;
  final List<int> range;
  final int lessThan;
  final int moreThan;

  String get label {
    return getRewatchFilterTypeLabel(type);
  }

  @override
  bool match(AnimeDetails animeData) {
    try {
      switch (type) {
        case AnimeFilterRewatchType.none:
          return false;
          break;
        case AnimeFilterRewatchType.anyRewatched:
          var matched = (animeData.myListStatus?.numTimesRewatched ?? 0) > 0;
          return matched;
          break;
        case AnimeFilterRewatchType.exactCount:
          var matched = (animeData.myListStatus?.numTimesRewatched ?? 0) == exactCount;
          return matched;
          break;
        case AnimeFilterRewatchType.range:
          var rw_count = animeData.myListStatus?.numTimesRewatched ?? 0;
          var min = range[0];
          var max = range[1];
          if (rw_count >= min && rw_count <= max) {
            return true;
          }
          return false;
          break;
        case AnimeFilterRewatchType.lessThan:
          var rw_count = animeData.myListStatus?.numTimesRewatched ?? 0;
          var matched = rw_count > 0 && rw_count < lessThan;
          return matched;
          break;
        case AnimeFilterRewatchType.moreThan:
          var matched = (animeData.myListStatus?.numTimesRewatched ?? 0) > moreThan;
          return matched;
          break;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  AnimeFilterRewatchData copyWith({
    AnimeFilterRewatchType type,
    int exactCount,
    List<int> range,
    int lessThan,
    int moreThan,
  }) {
    return AnimeFilterRewatchData(
      type: type ?? this.type,
      exactCount: exactCount ?? this.exactCount,
      range: range ?? this.range,
      lessThan: lessThan ?? this.lessThan,
      moreThan: moreThan ?? this.moreThan,
    );
  }
}
