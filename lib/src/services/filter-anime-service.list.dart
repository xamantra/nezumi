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
    // TODO: release season filter
    // TODO: episodes filter
    // TODO: duration filter
  ];

  void init(BuildContext context) {
    for (var item in filterItemSource) {
      item.initContext(context);
    }
  }
}
