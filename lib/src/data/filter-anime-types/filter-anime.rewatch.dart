import '../../absract/index.dart';
import '../index.dart';
import '../types/index.dart';

class AnimeFilterRewatchData extends AnimeFilterData {
  AnimeFilterRewatchData({
    this.type = CountFilterType.none,
    this.exactCount = null,
    this.range = const [null, null],
    this.lessThan = null,
    this.moreThan = null,
  });

  final CountFilterType type;
  final int exactCount;
  final List<int> range;
  final int lessThan;
  final int moreThan;

  String get label {
    return getCountFilterTypeLabel(type);
  }

  @override
  bool match(AnimeDetails animeData) {
    try {
      switch (type) {
        case CountFilterType.none:
          return false;
          break;
        case CountFilterType.exactCount:
          var matched = (animeData.myListStatus?.numTimesRewatched ?? 0) == exactCount;
          return matched;
          break;
        case CountFilterType.range:
          var rw_count = animeData.myListStatus?.numTimesRewatched ?? 0;
          var min = range[0];
          var max = range[1];
          if (rw_count >= min && rw_count <= max) {
            return true;
          }
          return false;
          break;
        case CountFilterType.lessThan:
          var rw_count = animeData.myListStatus?.numTimesRewatched ?? 0;
          var matched = rw_count > 0 && rw_count < lessThan;
          return matched;
          break;
        case CountFilterType.moreThan:
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
    CountFilterType type,
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
