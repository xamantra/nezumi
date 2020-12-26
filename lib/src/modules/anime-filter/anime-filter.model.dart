import 'package:momentum/momentum.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../data/index.dart';
import 'index.dart';

class AnimeFilterModel extends MomentumModel<AnimeFilterController> {
  AnimeFilterModel(
    AnimeFilterController controller, {
    this.animeFilters,
    this.results,
    this.animeGenreFilter,
    this.animeWatchDateFilter,
  }) : super(controller);

  final List<AnimeFilterBase> animeFilters;
  final List<AnimeData> results;

  /* filter types */
  final AnimeGenreFilter animeGenreFilter;
  final AnimeWatchDateFilter animeWatchDateFilter;
  /* filter types */

  @override
  void update({
    List<AnimeFilterBase> animeFilters,
    List<AnimeData> results,
    AnimeGenreFilter animeGenreFilter,
    AnimeWatchDateFilter animeWatchDateFilter,
  }) {
    AnimeFilterModel(
      controller,
      animeFilters: animeFilters ?? this.animeFilters,
      results: results ?? this.results,
      animeGenreFilter: animeGenreFilter ?? this.animeGenreFilter,
      animeWatchDateFilter: animeWatchDateFilter ?? this.animeWatchDateFilter,
    ).updateMomentum();
  }
}
