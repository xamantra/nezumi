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
  }) : super(controller);

  final OrderBy animeListOrderBy;
  final AnimeListSortBy animeListSortBy;

  final OrderBy animeSearchOrderBy;
  final AnimeListSortBy animeSearchSortBy;

  @override
  void update({
    OrderBy animeListOrderBy,
    AnimeListSortBy animeListSortBy,
    OrderBy animeSearchOrderBy,
    AnimeListSortBy animeSearchSortBy,
  }) {
    ListSortModel(
      controller,
      animeListOrderBy: animeListOrderBy ?? this.animeListOrderBy,
      animeListSortBy: animeListSortBy ?? this.animeListSortBy,
      animeSearchOrderBy: animeSearchOrderBy ?? this.animeSearchOrderBy,
      animeSearchSortBy: animeSearchSortBy ?? this.animeSearchSortBy,
    ).updateMomentum();
  }
}
