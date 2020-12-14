import 'package:flutter/material.dart';

import '../utils/index.dart';

class AppTheme extends InheritedWidget {
  AppTheme({
    Key key,
    @required this.child,
    @required this.theme,
  }) : super(key: key, child: child);

  final Widget child;
  final AppThemeData theme;

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>().theme;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return true;
  }
}
