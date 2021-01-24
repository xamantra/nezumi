import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemTags extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterTagsWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemTags, AnimeFilterTagsData>(AnimeFilterTagsData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemTags, AnimeFilterTagsData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterTagsData>();
  }

  @override
  String get title => 'Tags Filter';
}
