import 'package:flutter/material.dart';

import 'index.dart';
import 'pages/index.dart';

void gotoPage(BuildContext context, Widget page) {
  Navigator.push(context, _PageAdapter(page: page));
}

class _PageAdapter<T extends Widget> extends PageRouteBuilder {
  _PageAdapter({
    @required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              PageScaffold(page: page),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final T page;
}

class PageScaffold extends StatelessWidget {
  const PageScaffold({Key key, this.page}) : super(key: key);

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: page,
      drawer: AppDrawer(),
    );
  }
}
