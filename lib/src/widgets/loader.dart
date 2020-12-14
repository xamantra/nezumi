import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'app-theme.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
    this.percent,
  }) : super(key: key);

  final int percent;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          color: AppTheme.of(context).primaryBackground,
          child: Center(
            child: SizedBox(
              height: sy(32),
              width: sy(32),
              child: Stack(
                children: [
                  SizedBox(
                    height: sy(32),
                    width: sy(32),
                    child: CircularProgressIndicator(),
                  ),
                  percent == null
                      ? SizedBox()
                      : Center(
                          child: Text(
                            '$percent %',
                            style: TextStyle(
                              fontSize: sy(8),
                              color: AppTheme.of(context).accent,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
