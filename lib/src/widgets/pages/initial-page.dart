import 'package:flutter/material.dart';

import '../app-theme.dart';
import 'anime-list/index.dart';
import 'index.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: AnimeListPage(),
      drawer: AppDrawer(),
    );
  }
}
