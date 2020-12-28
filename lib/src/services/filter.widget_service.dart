import 'package:momentum/momentum.dart';

import '../absract/index.dart';
import '../utils/anime-filter-items/index.dart';

class FilterWigdetService extends MomentumService {
  final List<AnimeFilterItemBase> filterItemSource = [
    AnimeGenreFilterItem(),
    WatchDateFilterItem(),
  ];
  List<AnimeFilterItemBase> filterWidgets = [];

  void addFilter<T extends AnimeFilterItemBase>(T filterWidget) {
    var alreadyExists = filterWidgets.any((x) => x is T);
    if (alreadyExists) return;
    filterWidgets.add(filterWidget);
  }

  void removeFilter<T extends AnimeFilterItemBase>() {
    try {
      filterWidgets.removeWhere((x) => x is T);
    } catch (e) {
      print(e);
    }
  }
}
