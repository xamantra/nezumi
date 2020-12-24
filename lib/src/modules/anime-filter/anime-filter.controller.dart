import 'package:momentum/momentum.dart';

import 'index.dart';

class AnimeFilterController extends MomentumController<AnimeFilterModel> {
  @override
  AnimeFilterModel init() {
    return AnimeFilterModel(
      this,
      results: [],
    );
  }
}
