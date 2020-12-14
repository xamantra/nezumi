import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> {
  SettingsModel(
    SettingsController controller, {
    this.requiredMinsPerEp,
    this.requiredEpsPerDay,
  }) : super(controller);

  final int requiredMinsPerEp;
  final int requiredEpsPerDay;

  @override
  void update({
    int requiredMinsPerEp,
    int requiredEpsPerDay,
  }) {
    SettingsModel(
      controller,
      requiredMinsPerEp: requiredMinsPerEp ?? this.requiredMinsPerEp,
      requiredEpsPerDay: requiredEpsPerDay ?? this.requiredEpsPerDay,
    ).updateMomentum();
  }
}
