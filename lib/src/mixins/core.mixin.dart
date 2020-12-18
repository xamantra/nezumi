import 'package:momentum/momentum.dart';

import '../modules/settings/index.dart';
import '../services/index.dart';

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
