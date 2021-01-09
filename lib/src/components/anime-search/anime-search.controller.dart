import 'package:momentum/momentum.dart';

import 'index.dart';

class AnimeSearchController extends MomentumController<AnimeSearchModel> {
  @override
  AnimeSearchModel init() {
    return AnimeSearchModel(
      this,
      query: '',
    );
  }
}
