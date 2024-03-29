import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import 'index.dart';

class ListSortModel extends MomentumModel<ListSortController> {
  ListSortModel(
    ListSortController controller, {
    this.animeListOrderBy,
    this.animeListSortBy,
    this.animeSearchOrderBy,
    this.animeSearchSortBy,
    this.animeYearlyOrderBy,
    this.animeYearlySortBy,
    this.animeFilterOrderBy,
    this.animeFilterSortBy,
  }) : super(controller);

  final OrderBy animeListOrderBy;
  final AnimeListSortBy animeListSortBy;

  final OrderBy animeSearchOrderBy;
  final AnimeListSortBy animeSearchSortBy;

  final OrderBy animeYearlyOrderBy;
  final AnimeListSortBy animeYearlySortBy;

  final OrderBy animeFilterOrderBy;
  final AnimeListSortBy animeFilterSortBy;

  @override
  void update({
    OrderBy animeListOrderBy,
    AnimeListSortBy animeListSortBy,
    OrderBy animeSearchOrderBy,
    AnimeListSortBy animeSearchSortBy,
    OrderBy animeYearlyOrderBy,
    AnimeListSortBy animeYearlySortBy,
    OrderBy animeFilterOrderBy,
    AnimeListSortBy animeFilterSortBy,
  }) {
    ListSortModel(
      controller,
      animeListOrderBy: animeListOrderBy ?? this.animeListOrderBy,
      animeListSortBy: animeListSortBy ?? this.animeListSortBy,
      animeSearchOrderBy: animeSearchOrderBy ?? this.animeSearchOrderBy,
      animeSearchSortBy: animeSearchSortBy ?? this.animeSearchSortBy,
      animeYearlyOrderBy: animeYearlyOrderBy ?? this.animeYearlyOrderBy,
      animeYearlySortBy: animeYearlySortBy ?? this.animeYearlySortBy,
      animeFilterOrderBy: animeFilterOrderBy ?? this.animeFilterOrderBy,
      animeFilterSortBy: animeFilterSortBy ?? this.animeFilterSortBy,
    ).updateMomentum();
  }
}
