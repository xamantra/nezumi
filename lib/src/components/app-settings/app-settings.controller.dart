import 'package:momentum/momentum.dart';

import 'index.dart';

class AppSettingsController extends MomentumController<AppSettingsModel> {
  @override
  AppSettingsModel init() {
    return AppSettingsModel(
      this,
      compactMode: false,
    );
  }

  void changeCompactModeState(bool compactMode) {
    model.update(compactMode: compactMode ?? false);
  }
}
