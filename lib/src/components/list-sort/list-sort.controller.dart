import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import '../../mixins/index.dart';
import 'index.dart';

class ListSortController extends MomentumController<ListSortModel> with CoreMixin {
  @override
  ListSortModel init() {
    return ListSortModel(
      this,
      orderAnimeBy: OrderBy.descending,
      animeListSortBy: AnimeListSortBy.lastUpdated,
    );
  }

  void toggleOrderBy() {
    switch (model.orderAnimeBy) {
      case OrderBy.ascending:
        model.update(orderAnimeBy: OrderBy.descending);
        break;
      case OrderBy.descending:
        model.update(orderAnimeBy: OrderBy.ascending);
        break;
    }

    mal.controller.sortAnimeList();
  }

  void changeSortBy(AnimeListSortBy sortBy) {
    model.update(animeListSortBy: sortBy);

    mal.controller.sortAnimeList();
  }
}
