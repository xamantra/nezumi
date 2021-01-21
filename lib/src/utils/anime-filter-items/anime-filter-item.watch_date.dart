import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemWatchDate extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterWatchDateWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemWatchDate, AnimeFilterWatchDateData>(AnimeFilterWatchDateData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemWatchDate, AnimeFilterWatchDateData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterWatchDateData>();
  }

  @override
  String get title => 'Watch Date Filter';
}
