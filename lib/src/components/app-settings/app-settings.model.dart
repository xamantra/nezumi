import 'package:momentum/momentum.dart';

import 'index.dart';

class AppSettingsModel extends MomentumModel<AppSettingsController> {
  AppSettingsModel(
    AppSettingsController controller, {
    this.compactMode,
  }) : super(controller);

  final bool compactMode;

  @override
  void update({
    bool compactMode,
  }) {
    AppSettingsModel(
      controller,
      compactMode: compactMode ?? this.compactMode,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'compactMode': compactMode,
    };
  }

  AppSettingsModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return AppSettingsModel(
      controller,
      compactMode: json['compactMode'],
    );
  }
}
