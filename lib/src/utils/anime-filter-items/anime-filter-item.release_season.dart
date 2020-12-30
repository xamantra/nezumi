import 'package:flutter/widgets.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';

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
  String get title => 'Release Season Filter';
}
