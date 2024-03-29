import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemReleaseSeason extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterReleaseSeasonWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemReleaseSeason, AnimeFilterReleaseSeasonData>(AnimeFilterReleaseSeasonData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemReleaseSeason, AnimeFilterReleaseSeasonData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterReleaseSeasonData>();
  }

  @override
  String get title => 'Release Season Filter';
}
