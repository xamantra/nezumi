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

  double get requiredHoursPerDay => double.parse(((requiredMinsPerEp * requiredEpsPerDay) / 60).toStringAsFixed(2));

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

  Map<String, dynamic> toJson() {
    return {
      'requiredMinsPerEp': requiredMinsPerEp,
      'requiredEpsPerDay': requiredEpsPerDay,
    };
  }

  SettingsModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return SettingsModel(
      controller,
      requiredMinsPerEp: json['requiredMinsPerEp'],
      requiredEpsPerDay: json['requiredEpsPerDay'],
    );
  }
}
