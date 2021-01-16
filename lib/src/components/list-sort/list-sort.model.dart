import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import 'index.dart';

class ListSortModel extends MomentumModel<ListSortController> {
  ListSortModel(
    ListSortController controller, {
    this.orderAnimeBy,
    this.animeListSortBy,
  }) : super(controller);

  final OrderBy orderAnimeBy;
  final AnimeListSortBy animeListSortBy;

  @override
  void update({
    OrderBy orderAnimeBy,
    AnimeListSortBy animeListSortBy,
  }) {
    ListSortModel(
      controller,
      orderAnimeBy: orderAnimeBy ?? this.orderAnimeBy,
      animeListSortBy: animeListSortBy ?? this.animeListSortBy,
    ).updateMomentum();
  }
}
