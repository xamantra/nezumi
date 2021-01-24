import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemTotalDuration extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterTotalDurationWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemTotalDuration, AnimeFilterTotalDurationData>(AnimeFilterTotalDurationData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemTotalDuration, AnimeFilterTotalDurationData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterTotalDurationData>();
  }

  @override
  String get title => 'Total Duration Filter';
}
