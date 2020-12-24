import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../modules/my_anime_list/index.dart';
import '../modules/settings/index.dart';
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

  SettingsController _settingsCtrl;
  SettingsModel get settings {
    if (_settingsCtrl == null) {
      _settingsCtrl = dependOn<SettingsController>();
    }
    return _settingsCtrl?.model;
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
}
