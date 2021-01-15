import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterAiringStatusData extends AnimeFilterData {
  AnimeFilterAiringStatusData({
    this.isExclude = false,
    this.selectedStatuses = const [],
  });

  final bool isExclude;
  final List<String> selectedStatuses;

  @override
  bool match(AnimeDetails animeData) {
    if (selectedStatuses.isEmpty) {
      return true;
    }

    var airing_status = animeData?.status;
    var exist = selectedStatuses.any((x) => x == airing_status);

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

  AnimeFilterAiringStatusData copyWith({
    bool isExclude,
    List<String> selectedStatuses,
  }) {
    return AnimeFilterAiringStatusData(
      isExclude: isExclude ?? this.isExclude,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
    );
  }
}
