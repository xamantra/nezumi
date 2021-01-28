import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import '../../mixins/index.dart';
import 'index.dart';

class ListSortController extends MomentumController<ListSortModel> with CoreMixin {
  @override
  ListSortModel init() {
    return ListSortModel(
      this,
      animeListOrderBy: OrderBy.descending,
      animeListSortBy: AnimeListSortBy.lastUpdated,
      animeSearchOrderBy: OrderBy.descending,
      animeSearchSortBy: AnimeListSortBy.lastUpdated,
    );
  }

  void toggleAnimeListOrderBy() {
    switch (model.animeListOrderBy) {
      case OrderBy.ascending:
        model.update(animeListOrderBy: OrderBy.descending);
        break;
      case OrderBy.descending:
        model.update(animeListOrderBy: OrderBy.ascending);
        break;
    }

    mal.controller.sortAnimeList();
  }

  void changeAnimeListSortBy(AnimeListSortBy sortBy) {
    model.update(animeListSortBy: sortBy);

    mal.controller.sortAnimeList();
  }

  void toggleAnimeSearchOrderBy() {
    switch (model.animeSearchOrderBy) {
      case OrderBy.ascending:
        model.update(animeSearchOrderBy: OrderBy.descending);
        break;
      case OrderBy.descending:
        model.update(animeSearchOrderBy: OrderBy.ascending);
        break;
    }

    animeSearch.controller.sortAnimeSearch();
  }

  void changeAnimeSearchSortBy(AnimeListSortBy sortBy) {
    model.update(animeSearchSortBy: sortBy);

    animeSearch.controller.sortAnimeSearch();
  }
}
