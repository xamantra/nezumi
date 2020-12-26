import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

class FilterWigdetService extends MomentumService {
  List<Widget> filterWidgets = [];

  void addFilter<T extends Widget>(T filterWidget) {
    var alreadyExists = filterWidgets.any((x) => x is T);
    if (alreadyExists) return;
    filterWidgets.add(filterWidget);
  }

  void removeFilter<T extends Widget>() {
    try {
      filterWidgets.removeWhere((x) => x is T);
    } catch (e) {
      print(e);
    }
  }
}
