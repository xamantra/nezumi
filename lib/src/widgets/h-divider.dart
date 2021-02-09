import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: sy(30),
          width: 1,
          margin: EdgeInsets.symmetric(horizontal: sy(8)),
          color: AppTheme.of(context).text8,
        );
      },
    );
  }
}
