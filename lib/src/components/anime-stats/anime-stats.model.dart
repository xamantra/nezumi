import 'package:momentum/momentum.dart';

import 'index.dart';

class AnimeStatsModel extends MomentumModel<AnimeStatsController> {
  AnimeStatsModel(AnimeStatsController controller) : super(controller);

  @override
  void update() {
    AnimeStatsModel(
      controller,
    ).updateMomentum();
  }
}
