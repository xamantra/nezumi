import 'package:flutter/widgets.dart';

import '../../data/filter-anime-types/index.dart';
import '../../widgets/anime-filter-item-widgets/index.dart';
import '../../widgets/index.dart';

class AnimeFilterItemMediaType extends AnimeFilterItem {
  @override
  Widget build(BuildContext context) {
    return AnimeFilterMediaTypeWidget();
  }

  @override
  void onAddCallback(BuildContext context) {
    add<AnimeFilterItemMediaType, AnimeFilterMediaTypeData>(AnimeFilterMediaTypeData());
    Navigator.pop(context);
  }

  @override
  void onRemoveCallback(BuildContext context) {
    remove<AnimeFilterItemMediaType, AnimeFilterMediaTypeData>();
  }

  @override
  bool filterExist() {
    return exist<AnimeFilterMediaTypeData>();
  }

  @override
  String get title => 'Media Type Filter';
}
