import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/services/index.dart';
import 'src/utils/index.dart';
import 'src/widgets/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitializeYearList();
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    child: MyApp(),
    appLoader: AppLoader(),
    restartCallback: main,
    key: UniqueKey(),
    controllers: controllers(),
    services: services(),
    persistSave: persistSave,
    persistGet: persistGet,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    srv<AnimeFilterListService>(context).init(context);
    return AppTheme(
      theme: defaultTheme,
      child: MaterialApp(
        title: 'Nezumi',
        theme: ThemeData(
          primaryColor: defaultTheme.primary,
          accentColor: defaultTheme.accent,
          backgroundColor: defaultTheme.primaryBackground,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardColor: defaultTheme.secondaryBackground,
          cardTheme: CardTheme(
            color: defaultTheme.secondaryBackground,
            elevation: 0,
          ),
          dialogBackgroundColor: defaultTheme.primaryBackground,
        ),
        debugShowCheckedModeBanner: false,
        home: getActivePage(context),
      ),
    );
  }
}
