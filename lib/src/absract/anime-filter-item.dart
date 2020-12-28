import 'package:flutter/widgets.dart';

abstract class AnimeFilterItem {
  String get title;

  Widget build(BuildContext context);
  void onAddCallback(BuildContext context);
  void onRemoveCallback(BuildContext context);
}
