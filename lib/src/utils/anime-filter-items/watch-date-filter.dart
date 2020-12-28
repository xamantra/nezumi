import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../modules/anime-filter/index.dart';
import '../../modules/app/index.dart';
import '../../services/index.dart';
import '../../widgets/pages/anime-list/filter-types/index.dart';
import '../index.dart';

class WatchDateFilterItem extends AnimeFilterItemBase {
  @override
  Widget build(BuildContext context) {
    return WatchDateFilterWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    var filterWidgetService = srv<FilterWigdetService>(context);
    var animeFilter = ctrl<AnimeFilterController>(context).model;
    var app = ctrl<AppController>(context).model;

    var exist = animeFilter.filterExist<AnimeWatchDateFilter>();
    if (!exist) {
      filterWidgetService.addFilter(this);
      animeFilter.controller.addFilter(AnimeWatchDateFilter());
      app.triggerRebuild();
    }
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    var filterWidgetService = srv<FilterWigdetService>(context);
    var animeFilterController = ctrl<AnimeFilterController>(context);
    var app = ctrl<AppController>(context);

    filterWidgetService.removeFilter<WatchDateFilterItem>();
    animeFilterController.removeFilter<AnimeWatchDateFilter>();
    app.rebuild();
  }

  @override
  String get title => 'Watch Date Filter';
}
