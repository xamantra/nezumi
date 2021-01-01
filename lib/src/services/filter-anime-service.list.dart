import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../absract/index.dart';
import '../utils/anime-filter-items/index.dart';

class AnimeFilterListService extends MomentumService {
  final List<AnimeFilterItem> filterItemSource = [
    AnimeFilterItemGenre(),
    AnimeFilterItemWatchDate(),
    AnimeFilterItemListStatus(),
    AnimeFilterItemAiringStatus(),
    AnimeFilterItemMediaType(),
    AnimeFilterItemReleaseDate(),
    AnimeFilterItemReleaseSeason(),
    AnimeFilterItemRewatch(),
    // TODO: episodes filter
    // TODO: duration filter
    // TODO: list tags filter
    // TODO: comments filter
  ];

  void init(BuildContext context) {
    for (var item in filterItemSource) {
      item.init(context);
    }
  }
}
