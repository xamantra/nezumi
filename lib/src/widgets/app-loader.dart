import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../utils/index.dart';
import 'index.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: defaultTheme.primaryBackground,
        body: RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageWidget(
                    url: 'assets/images/icon.png',
                    asset: true,
                    size: sy(72),
                  ),
                  SizedBox(height: sy(6)),
                  SizedBox(
                    height: sy(2),
                    width: sy(70),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
