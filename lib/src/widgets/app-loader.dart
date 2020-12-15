import 'package:flutter/material.dart';

import '../utils/index.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: defaultTheme.secondaryBackground,
        body: Center(
          child: SizedBox(
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
