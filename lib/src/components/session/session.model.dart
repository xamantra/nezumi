import 'package:momentum/momentum.dart';

import 'index.dart';

class SessionModel extends MomentumModel<SessionController> {
  SessionModel(SessionController controller) : super(controller);

  @override
  void update() {
    SessionModel(
      controller,
    ).updateMomentum();
  }
}
