import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemEpisodes extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterEpisodesWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemEpisodes, AnimeFilterEpisodesData>(AnimeFilterEpisodesData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemEpisodes, AnimeFilterEpisodesData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterEpisodesData>();
  }

  @override
  String get title => 'Episodes Filter';
}
