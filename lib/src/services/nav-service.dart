import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../widgets/pages/anime-list/index.dart';

class NavService extends MomentumService {
  Widget _activeWidget;
  Widget get activeWidget => _activeWidget ?? AnimeListPage();

  void gotoPage(Widget page) {
    _activeWidget = page ?? _activeWidget;
  }
}
