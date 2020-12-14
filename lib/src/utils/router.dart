import '../widgets/pages/home.dart';
import '../widgets/pages/index.dart';
import 'index.dart';

final routerService = createRouter(
  [
    Login(),
    HomePage(),
  ],
  enablePersistence: true,
);
