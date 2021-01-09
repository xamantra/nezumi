import 'package:momentum/momentum.dart';

import 'index.dart';

class AppController extends MomentumController<AppModel> {
  @override
  AppModel init() {
    return AppModel(this);
  }

  rebuild() {
    model.triggerRebuild();
  }
}
