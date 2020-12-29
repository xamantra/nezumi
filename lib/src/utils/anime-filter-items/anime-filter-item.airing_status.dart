import 'package:flutter/widgets.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';

class AnimeFilterItemAiringStatus extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterAiringStatusWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemAiringStatus, AnimeFilterAiringStatusData>(AnimeFilterAiringStatusData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemAiringStatus, AnimeFilterAiringStatusData>();
  }

  @override
  String get title => 'Airing Status Filter';
}
