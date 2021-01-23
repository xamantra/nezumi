import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemEpisodesWatched extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterEpisodesWatchedWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemEpisodesWatched, AnimeFilterEpisodesWatchedData>(AnimeFilterEpisodesWatchedData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemEpisodesWatched, AnimeFilterEpisodesWatchedData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterEpisodesWatchedData>();
  }

  @override
  String get title => 'Episodes Watched Filter';
}
