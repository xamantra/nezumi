import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import 'index.dart';

class AnimeStatsModel extends MomentumModel<AnimeStatsController> {
  AnimeStatsModel(
    AnimeStatsController controller, {
    this.orderBy,
    this.sortBy,
  }) : super(controller);

  final OrderBy orderBy;
  final AnimeStatSort sortBy;

  @override
  void update({
    OrderBy orderBy,
    AnimeStatSort sortBy,
  }) {
    AnimeStatsModel(
      controller,
      orderBy: orderBy ?? this.orderBy,
      sortBy: sortBy ?? this.sortBy,
    ).updateMomentum();
  }
}
