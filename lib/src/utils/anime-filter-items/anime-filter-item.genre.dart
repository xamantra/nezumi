import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemGenre extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterGenreWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemGenre, AnimeFilterGenreData>(AnimeFilterGenreData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemGenre, AnimeFilterGenreData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterGenreData>();
  }

  @override
  String get title => 'Genre Filter';
}
