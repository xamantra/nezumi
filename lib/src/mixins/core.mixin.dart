import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../components/anime-filter/index.dart';
import '../components/anime-search/index.dart';
import '../components/anime-top/index.dart';
import '../components/anime-update/index.dart';
import '../components/app/index.dart';
import '../components/export-list/index.dart';
import '../components/list-sort/index.dart';
import '../components/my_anime_list/index.dart';
import '../components/settings/index.dart';
import '../services/index.dart';
import '../utils/index.dart';

mixin CoreMixin<T> on MomentumController<T> {
  ApiService _api;
  ApiService get api {
    if (_api == null) {
      _api = service<ApiService>();
    }
    return _api;
  }

  AnimeCacheService _animeCache;
  AnimeCacheService get animeCache {
    if (_animeCache == null) {
      _animeCache = service<AnimeCacheService>();
    }
    return _animeCache;
  }

  AppController _appCtrl;
  AppModel get app {
    if (_appCtrl == null) {
      _appCtrl = controller<AppController>();
    }
    return _appCtrl?.model;
  }

  SettingsController _settingsCtrl;
  SettingsModel get settings {
    if (_settingsCtrl == null) {
      _settingsCtrl = controller<SettingsController>();
    }
    return _settingsCtrl?.model;
  }

  MyAnimeListController _malCtrl;
  MyAnimeListModel get mal {
    if (_malCtrl == null) {
      _malCtrl = controller<MyAnimeListController>();
    }
    return _malCtrl?.model;
  }

  AnimeFilterController _animeFilterCtrl;
  AnimeFilterModel get animeFilter {
    if (_animeFilterCtrl == null) {
      _animeFilterCtrl = controller<AnimeFilterController>();
    }
    return _animeFilterCtrl?.model;
  }

  ListSortController _listSortCtrl;
  ListSortModel get listSort {
    if (_listSortCtrl == null) {
      _listSortCtrl = controller<ListSortController>();
    }
    return _listSortCtrl?.model;
  }
}

mixin CoreStateMixin<T extends StatefulWidget> on State<T> {
  FilterWigdetService _filterWidgetService;
  FilterWigdetService get filterWidgetService {
    if (_filterWidgetService == null) {
      _filterWidgetService = srv<FilterWigdetService>(context);
    }
    return _filterWidgetService;
  }

  AppController _appCtrl;
  AppModel get app {
    if (_appCtrl == null) {
      _appCtrl = ctrl<AppController>(context);
    }
    return _appCtrl?.model;
  }

  SettingsController _settingsCtrl;
  SettingsModel get settings {
    if (_settingsCtrl == null) {
      _settingsCtrl = ctrl<SettingsController>(context);
    }
    return _settingsCtrl?.model;
  }

  MyAnimeListController _malCtrl;
  MyAnimeListModel get mal {
    if (_malCtrl == null) {
      _malCtrl = ctrl<MyAnimeListController>(context);
    }
    return _malCtrl?.model;
  }

  AnimeFilterController _animeFilterCtrl;
  AnimeFilterModel get animeFilter {
    if (_animeFilterCtrl == null) {
      _animeFilterCtrl = ctrl<AnimeFilterController>(context);
    }
    return _animeFilterCtrl?.model;
  }

  AnimeUpdateController _animeUpdateCtrl;
  AnimeUpdateModel get animeUpdate {
    if (_animeUpdateCtrl == null) {
      _animeUpdateCtrl = ctrl<AnimeUpdateController>(context);
    }
    return _animeUpdateCtrl?.model;
  }

  AnimeSearchController _animeSearchCtrl;
  AnimeSearchModel get animeSearch {
    if (_animeSearchCtrl == null) {
      _animeSearchCtrl = ctrl<AnimeSearchController>(context);
    }
    return _animeSearchCtrl?.model;
  }

  AnimeTopController _animeTopCtrl;
  AnimeTopModel get animeTop {
    if (_animeTopCtrl == null) {
      _animeTopCtrl = ctrl<AnimeTopController>(context);
    }
    return _animeTopCtrl?.model;
  }

  ExportListController _exportListCtrl;
  ExportListModel get exportList {
    if (_exportListCtrl == null) {
      _exportListCtrl = ctrl<ExportListController>(context);
    }
    return _exportListCtrl?.model;
  }

  ListSortController _listSortCtrl;
  ListSortModel get listSort {
    if (_listSortCtrl == null) {
      _listSortCtrl = ctrl<ListSortController>(context);
    }
    return _listSortCtrl?.model;
  }
}
