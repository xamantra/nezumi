import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterListStatusData extends AnimeFilterData {
  AnimeFilterListStatusData({
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

    var list_status = animeData?.myListStatus?.status;
    var exist = selectedStatuses.any((x) => x == list_status);

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

  AnimeFilterListStatusData copyWith({
    bool isExclude,
    List<String> selectedStatuses,
  }) {
    return AnimeFilterListStatusData(
      isExclude: isExclude ?? this.isExclude,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
    );
  }
}
