import 'package:momentum/momentum.dart';

import '../absract/index.dart';

class FilterWigdetService extends MomentumService {
  List<AnimeFilterItem> filterWidgets = [];

  void addFilter<T extends AnimeFilterItem>(T filterWidget) {
    var alreadyExists = filterWidgets.any((x) => x is T);
    if (alreadyExists) return;
    filterWidgets.add(filterWidget);
  }

  void removeFilter<T extends AnimeFilterItem>() {
    try {
      filterWidgets.removeWhere((x) => x is T);
    } catch (e) {
      print(e);
    }
  }
}
