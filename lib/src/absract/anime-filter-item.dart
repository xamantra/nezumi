import 'package:flutter/widgets.dart';

// TODO: simplify base class and add an initialize context method
abstract class AnimeFilterItem {
  String get title;

  Widget build(BuildContext context);
  void onAddCallback(BuildContext context);
  void onRemoveCallback(BuildContext context);
}
