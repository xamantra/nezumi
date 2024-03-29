import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

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
  bool filterExist() {
    return exist<AnimeFilterAiringStatusData>();
  }

  @override
  String get title => 'Airing Status Filter';
}
