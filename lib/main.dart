import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/utils/index.dart';
import 'src/widgets/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    child: MyApp(),
    restartCallback: main,
    key: UniqueKey(),
    controllers: controllers,
    services: services,
    persistSave: persistSave,
    persistGet: persistGet,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      theme: defaultTheme,
      child: MaterialApp(
        title: 'Nezumi',
        theme: ThemeData(
          primaryColor: defaultTheme.primary,
          accentColor: defaultTheme.accent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: getActivePage(context),
      ),
    );
  }
}
