import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class MyListTabItem extends StatelessWidget {
  const MyListTabItem({
    Key key,
    @required this.label,
    @required this.count,
  }) : super(key: key);

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: sy(9),
                  color: Colors.white,
                ),
              ),
              count == 0
                  ? SizedBox()
                  : Text(
                      ' ($count)',
                      style: TextStyle(
                        fontSize: sy(8),
                        color: AppTheme.of(context).text3,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
