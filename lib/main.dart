import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/_mconfig/index.dart';
import 'src/services/index.dart';
import 'src/utils/index.dart';
import 'src/widgets/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitializeYearList();
  await initStorage();
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    initializer: initStorage,
    child: MyApp(),
    appLoader: Splash(),
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
          colorScheme: ColorScheme.dark(
            primary: defaultTheme.primary,
            secondary: defaultTheme.accent,
            onSecondary: Colors.white,
          ),
          backgroundColor: defaultTheme.primaryBackground,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardColor: defaultTheme.secondaryBackground,
          cardTheme: CardTheme(
            color: defaultTheme.secondaryBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          dialogBackgroundColor: defaultTheme.primaryBackground,
        ),
        debugShowCheckedModeBanner: false,
        home: MomentumRouter.getActivePage(context),
      ),
    );
  }
}
