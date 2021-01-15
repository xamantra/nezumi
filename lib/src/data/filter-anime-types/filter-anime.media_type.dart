import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterMediaTypeData extends AnimeFilterData {
  AnimeFilterMediaTypeData({
    this.isExclude = false,
    this.selectedMediaTypes = const [],
  });

  final bool isExclude;
  final List<String> selectedMediaTypes;

  @override
  bool match(AnimeDetails animeData) {
    if (selectedMediaTypes.isEmpty) {
      return true;
    }

    var media_type = animeData?.mediaType;
    var exist = selectedMediaTypes.any((x) => x == media_type);

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

  AnimeFilterMediaTypeData copyWith({
    bool isExclude,
    List<String> selectedMediaTypes,
  }) {
    return AnimeFilterMediaTypeData(
      isExclude: isExclude ?? this.isExclude,
      selectedMediaTypes: selectedMediaTypes ?? this.selectedMediaTypes,
    );
  }
}
