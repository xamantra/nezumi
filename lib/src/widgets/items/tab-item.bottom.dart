import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../index.dart';

class TabItemBottom extends StatelessWidget {
  const TabItemBottom({
    Key key,
    @required this.active,
    @required this.icon,
    this.iconSize,
    @required this.label,
  }) : super(key: key);

  final bool active;
  final IconData icon;
  final double iconSize;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize ?? sy(13.5),
              color: active ? AppTheme.of(context).accent : AppTheme.of(context).text3,
            ),
            SizedBox(height: sy(3)),
            !active
                ? SizedBox()
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: sy(8),
                      color: active ? AppTheme.of(context).accent : AppTheme.of(context).text3,
                    ),
                  ),
          ],
        );
      },
    );
  }
}
