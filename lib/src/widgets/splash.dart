import 'package:flutter/material.dart';

import '../utils/index.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: defaultTheme.primaryBackground),
    );
  }
}
