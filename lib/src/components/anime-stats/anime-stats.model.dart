import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import 'index.dart';

class AnimeStatsModel extends MomentumModel<AnimeStatsController> {
  AnimeStatsModel(
    AnimeStatsController controller, {
    this.orderBy,
    this.sortBy,
    this.genreStatItems,
    this.sourceMaterialStatItems,
    this.studioStatItems,
    this.yearStatItems,
    this.seasonStatItems,
    this.formatItems,
    this.ratingItems,
  }) : super(controller);

  final OrderBy orderBy;
  final AnimeStatSort sortBy;

  final List<AnimeSummaryStatData> genreStatItems;
  final List<AnimeSummaryStatData> sourceMaterialStatItems;
  final List<AnimeSummaryStatData> studioStatItems;
  final List<AnimeSummaryStatData> yearStatItems;
  final List<AnimeSummaryStatData> seasonStatItems;
  final List<AnimeSummaryStatData> formatItems;
  final List<AnimeSummaryStatData> ratingItems;

  @override
  void update({
    OrderBy orderBy,
    AnimeStatSort sortBy,
    List<AnimeSummaryStatData> genreStatItems,
    List<AnimeSummaryStatData> sourceMaterialStatItems,
    List<AnimeSummaryStatData> studioStatItems,
    List<AnimeSummaryStatData> yearStatItems,
    List<AnimeSummaryStatData> seasonStatItems,
    List<AnimeSummaryStatData> formatItems,
    List<AnimeSummaryStatData> ratingItems,
  }) {
    AnimeStatsModel(
      controller,
      orderBy: orderBy ?? this.orderBy,
      sortBy: sortBy ?? this.sortBy,
      genreStatItems: genreStatItems ?? this.genreStatItems,
      sourceMaterialStatItems: sourceMaterialStatItems ?? this.sourceMaterialStatItems,
      studioStatItems: studioStatItems ?? this.studioStatItems,
      yearStatItems: yearStatItems ?? this.yearStatItems,
      seasonStatItems: seasonStatItems ?? this.seasonStatItems,
      formatItems: formatItems ?? this.formatItems,
      ratingItems: ratingItems ?? this.ratingItems,
    ).updateMomentum();
  }
}
