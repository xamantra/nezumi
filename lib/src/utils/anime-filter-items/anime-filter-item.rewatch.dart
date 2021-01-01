import 'package:flutter/widgets.dart';

import '../../absract/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';

class AnimeFilterItemRewatch extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterRewatchWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemRewatch, AnimeFilterRewatchData>(AnimeFilterRewatchData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemRewatch, AnimeFilterRewatchData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterRewatchData>();
  }

  @override
  String get title => 'Rewatch Filter';
}
