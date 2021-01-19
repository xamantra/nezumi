import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class MyListTabItem extends StatelessWidget {
  const MyListTabItem({
    Key key,
    @required this.label,
    this.count,
    @required this.active,
  }) : super(key: key);

  final String label;
  final int count;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (active ?? false) ? 1 : 0.55,
      child: Tab(
        child: RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: sy((active ?? false) ? 11 : 9),
                    color: Colors.white,
                    fontWeight: (active ?? false) ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                (count ?? 0) == 0
                    ? SizedBox()
                    : Text(
                        ' ($count)',
                        style: TextStyle(
                          fontSize: sy(8),
                          color: AppTheme.of(context).text6,
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
