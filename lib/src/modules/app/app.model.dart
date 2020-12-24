import 'package:momentum/momentum.dart';

import 'index.dart';

class AppModel extends MomentumModel<AppController> {
  AppModel(
    AppController controller, {
    this.i,
  }) : super(controller);

  final int i;

  @override
  void update() {
    AppModel(
      controller,
      i: this.i,
    ).updateMomentum();
  }

  void triggerRebuild() {
    AppModel(
      controller,
      i: (this.i ?? 0) + 1,
    ).updateMomentum();
  }
}
