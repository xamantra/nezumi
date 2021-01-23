import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemDurationPerEp extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterDurationPerEpWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemDurationPerEp, AnimeFilterDurationPerEpData>(AnimeFilterDurationPerEpData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemDurationPerEp, AnimeFilterDurationPerEpData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterDurationPerEpData>();
  }

  @override
  String get title => 'Duration/ep Filter';
}
