import '../../absract/index.dart';
import '../index.dart';
import '../types/index.dart';

class AnimeFilterEpisodesWatchedData extends AnimeFilterData {
  AnimeFilterEpisodesWatchedData({
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
      var w = animeData?.myListStatus?.numEpisodesWatched ?? 0;
      switch (type) {
        case CountFilterType.none:
          return false;
          break;
        case CountFilterType.exactCount:
          var matched = w == exactCount;
          return matched;
          break;
        case CountFilterType.range:
          var min = range[0];
          var max = range[1];
          if (w >= min && w <= max) {
            return true;
          }
          return false;
          break;
        case CountFilterType.lessThan:
          var matched = w > 0 && w < lessThan;
          return matched;
          break;
        case CountFilterType.moreThan:
          var matched = w > moreThan;
          return matched;
          break;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  AnimeFilterEpisodesWatchedData copyWith({
    CountFilterType type,
    int exactCount,
    List<int> range,
    int lessThan,
    int moreThan,
  }) {
    return AnimeFilterEpisodesWatchedData(
      type: type ?? this.type,
      exactCount: exactCount ?? this.exactCount,
      range: range ?? this.range,
      lessThan: lessThan ?? this.lessThan,
      moreThan: moreThan ?? this.moreThan,
    );
  }
}
