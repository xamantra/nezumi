import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemListStatus extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterListStatusWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemListStatus, AnimeFilterListStatusData>(AnimeFilterListStatusData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemListStatus, AnimeFilterListStatusData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterListStatusData>();
  }

  @override
  String get title => 'List Status Filter';
}
