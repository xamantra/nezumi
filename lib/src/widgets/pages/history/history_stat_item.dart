import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../index.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    Key key,
    @required this.value,
    @required this.label,
    @required this.valueColor,
  }) : super(key: key);

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Row(
          children: [
            Text(
              '$value ',
              style: TextStyle(
                color: valueColor,
                fontSize: sy(9),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.of(context).text3,
                fontSize: sy(9),
              ),
            ),
          ],
        );
      },
    );
  }
}
