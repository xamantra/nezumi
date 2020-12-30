import 'package:flutter/material.dart';

import '../widgets/app-theme.dart';

Future<DateTime> selectDate(BuildContext context, [DateTime initialDate]) async {
  var now = DateTime.now();
  var result = await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: now.subtract(Duration(days: 120 * 365)),
    lastDate: now,
    builder: (context, child) {
      return _ThemedDatePicker(child: child);
    },
  );
  return result;
}

class _ThemedDatePicker extends StatelessWidget {
  const _ThemedDatePicker({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var t = AppTheme.of(context);
    return Theme(
      data: ThemeData(
        backgroundColor: t.primaryBackground,
        dialogBackgroundColor: t.primaryBackground,
        colorScheme: ColorScheme.dark(
          primary: t.accent,
          onPrimary: Colors.white,
          secondary: t.accent,
          onSecondary: Colors.white,
          surface: t.accent,
          onSurface: Colors.white,
        ),
        accentColor: t.accent,
      ),
      child: child,
    );
  }
}
