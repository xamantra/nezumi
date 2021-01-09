import 'package:flutter/widgets.dart';

import '../components/anime-filter/index.dart';
import '../components/app/index.dart';
import '../services/index.dart';
import '../utils/index.dart';
import 'index.dart';

abstract class AnimeFilterItem {
  String get title;

  FilterWigdetService filterWidgetService;
  AnimeFilterController animeFilter;
  AppController app;
  void init(BuildContext context) {
    filterWidgetService = srv<FilterWigdetService>(context);
    animeFilter = ctrl<AnimeFilterController>(context);
    app = ctrl<AppController>(context);
  }

  void add<I extends AnimeFilterItem, D extends AnimeFilterData>(D data) {
    var exist = animeFilter.model.filterExist<D>();
    if (!exist) {
      filterWidgetService.addFilter<I>(this);
      animeFilter.addFilter(data);
      app.rebuild();
    }
  }

  void remove<I extends AnimeFilterItem, D extends AnimeFilterData>() {
    filterWidgetService.removeFilter<I>();
    animeFilter.removeFilter<D>();
    app.rebuild();
  }

  @protected
  bool exist<D extends AnimeFilterData>() {
    var e = animeFilter.model.filterExist<D>();
    return e;
  }

  Widget build(BuildContext context);
  void onAddCallback(BuildContext context);
  void onRemoveCallback(BuildContext context);
  bool filterExist();
}
