import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsController extends MomentumController<SettingsModel> {
  @override
  SettingsModel init() {
    return SettingsModel(
      this,
      requiredMinsPerEp: 23,
      requiredEpsPerDay: 15,
    );
  }
}
