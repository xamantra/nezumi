import 'package:flutter/widgets.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../modules/anime-filter/index.dart';
import '../../modules/app/index.dart';
import '../../services/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../index.dart';

class AnimeFilterItemListStatus extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterListStatusWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    var filterWidgetService = srv<FilterWigdetService>(context);
    var animeFilter = ctrl<AnimeFilterController>(context).model;
    var app = ctrl<AppController>(context).model;

    var exist = animeFilter.filterExist<AnimeFilterListStatusData>();
    if (!exist) {
      filterWidgetService.addFilter(this);
      animeFilter.controller.addFilter(AnimeFilterListStatusData());
      app.triggerRebuild();
    }
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    var filterWidgetService = srv<FilterWigdetService>(context);
    var animeFilterController = ctrl<AnimeFilterController>(context);
    var app = ctrl<AppController>(context);

    filterWidgetService.removeFilter<AnimeFilterItemListStatus>();
    animeFilterController.removeFilter<AnimeFilterListStatusData>();
    app.rebuild();
  }

  @override
  String get title => 'List Status Filter';
}
