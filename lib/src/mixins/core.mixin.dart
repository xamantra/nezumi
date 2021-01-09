import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../components/anime-filter/index.dart';
import '../components/anime-search/index.dart';
import '../components/anime-update/index.dart';
import '../components/app/index.dart';
import '../components/my_anime_list/index.dart';
import '../components/settings/index.dart';
import '../services/index.dart';
import '../utils/index.dart';

mixin CoreMixin<T> on MomentumController<T> {
  ApiService _api;
  ApiService get api {
    if (_api == null) {
      _api = getService<ApiService>();
    }
    return _api;
  }

  AppController _appCtrl;
  AppModel get app {
    if (_appCtrl == null) {
      _appCtrl = dependOn<AppController>();
    }
    return _appCtrl?.model;
  }

  SettingsController _settingsCtrl;
  SettingsModel get settings {
    if (_settingsCtrl == null) {
      _settingsCtrl = dependOn<SettingsController>();
    }
    return _settingsCtrl?.model;
  }

  MyAnimeListController _malCtrl;
  MyAnimeListModel get mal {
    if (_malCtrl == null) {
      _malCtrl = dependOn<MyAnimeListController>();
    }
    return _malCtrl?.model;
  }

  AnimeFilterController _animeFilterCtrl;
  AnimeFilterModel get animeFilter {
    if (_animeFilterCtrl == null) {
      _animeFilterCtrl = dependOn<AnimeFilterController>();
    }
    return _animeFilterCtrl?.model;
  }
}

mixin CoreStateMixin<T extends StatefulWidget> on State<T> {
  NavService _nav;
  NavService get nav {
    if (_nav == null) {
      _nav = srv<NavService>(context);
    }
    return _nav;
  }

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
}
