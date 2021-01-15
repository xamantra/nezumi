import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterReleaseSeasonData extends AnimeFilterData {
  AnimeFilterReleaseSeasonData({
    this.isExclude = false,
    this.selectedSeasons = const [],
  });

  final bool isExclude;

  /// List of `"$season $year"` strings.
  final List<String> selectedSeasons;

  @override
  bool match(AnimeDetails animeData) {
    if (selectedSeasons.isEmpty) {
      return true;
    }

    var exist = selectedSeasons.any((x) => animeData.seasonMatch(x));

    if (exist) {
      if (isExclude) {
        return false;
      }
      return true;
    } else {
      if (isExclude) {
        return true;
      }
      return false;
    }
  }

  AnimeFilterReleaseSeasonData copyWith({
    bool isExclude,
    List<String> selectedSeasons,
  }) {
    return AnimeFilterReleaseSeasonData(
      isExclude: isExclude ?? this.isExclude,
      selectedSeasons: selectedSeasons ?? this.selectedSeasons,
    );
  }
}
