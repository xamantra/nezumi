import 'package:momentum/momentum.dart';

import '../widgets/pages/dashboard.dart';
import '../widgets/pages/index.dart';
import 'index.dart';

Router routerService() {
  return createRouter(
    [
      Login(),
      Dashboard(),
    ],
    enablePersistence: true,
  );
}
