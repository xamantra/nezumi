import 'package:momentum/momentum.dart';

import '../services/index.dart';
import '../widgets/pages/index.dart';

List<MomentumService> services() {
  return [
    ApiService(),
    NavService(),
    FilterWigdetService(),
    AnimeFilterListService(),
    MomentumRouter(
      [Login(), Dashboard()],
      enablePersistence: true,
    ),
  ];
}
