import 'package:momentum/momentum.dart';

import '../services/index.dart';
import '../utils/index.dart';

List<MomentumService> services() {
  return [
    ApiService(),
    NavService(),
    FilterWigdetService(),
    AnimeFilterListService(),
    routerService(),
  ];
}
