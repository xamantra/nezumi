import 'package:nezumi/src/widgets/pages/dashboard.dart';

import '../widgets/pages/index.dart';
import 'index.dart';

final routerService = createRouter(
  [
    Login(),
    Dashboard(),
  ],
  enablePersistence: true,
);
