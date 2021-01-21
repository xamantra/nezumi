import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemReleaseDate extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterReleaseDateWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemReleaseDate, AnimeFilterReleaseDateData>(AnimeFilterReleaseDateData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemReleaseDate, AnimeFilterReleaseDateData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterReleaseDateData>();
  }

  @override
  String get title => 'Airing Dates Filter';
}
