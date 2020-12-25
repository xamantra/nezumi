import 'package:momentum/momentum.dart';

import '../../absract/index.dart';
import '../../data/index.dart';
import '../../widgets/pages/anime-list/filter-types/index.dart';
import 'index.dart';

class AnimeFilterModel extends MomentumModel<AnimeFilterController> {
  AnimeFilterModel(
    AnimeFilterController controller, {
    this.animeFilters,
    this.results,
    this.animeGenreFilter,
  }) : super(controller);

  final List<AnimeFilterBase> animeFilters;
  final List<AnimeData> results;

  /* filter types */
  final AnimeGenreFilter animeGenreFilter;
  /* filter types */

  @override
  void update({
    List<AnimeFilterBase> animeFilters,
    List<AnimeData> results,
    AnimeGenreFilter animeGenreFilter,
  }) {
    AnimeFilterModel(
      controller,
      animeFilters: animeFilters ?? this.animeFilters,
      results: results ?? this.results,
      animeGenreFilter: animeGenreFilter ?? this.animeGenreFilter,
    ).updateMomentum();
  }
}