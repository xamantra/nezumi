import '../../absract/index.dart';
import '../index.dart';
import '../types/index.dart';

class AnimeFilterEpisodesData extends AnimeFilterData {
  AnimeFilterEpisodesData({
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
          var matched = (animeData?.numEpisodes ?? 0) == exactCount;
          return matched;
          break;
        case CountFilterType.range:
          var eps = animeData?.numEpisodes ?? 0;
          var min = range[0];
          var max = range[1];
          if (eps >= min && eps <= max) {
            return true;
          }
          return false;
          break;
        case CountFilterType.lessThan:
          var eps = animeData?.numEpisodes ?? 0;
          var matched = eps > 0 && eps < lessThan;
          return matched;
          break;
        case CountFilterType.moreThan:
          var matched = (animeData?.numEpisodes ?? 0) > moreThan;
          return matched;
          break;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  AnimeFilterEpisodesData copyWith({
    CountFilterType type,
    int exactCount,
    List<int> range,
    int lessThan,
    int moreThan,
  }) {
    return AnimeFilterEpisodesData(
      type: type ?? this.type,
      exactCount: exactCount ?? this.exactCount,
      range: range ?? this.range,
      lessThan: lessThan ?? this.lessThan,
      moreThan: moreThan ?? this.moreThan,
    );
  }
}
