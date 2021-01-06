import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'app-theme.dart';

class EditFieldInfoRow extends StatelessWidget {
  const EditFieldInfoRow({
    Key key,
    @required this.label,
    @required this.child,
    this.verticalPadding = 0,
    this.expand = false,
  }) : super(key: key);

  final String label;
  final Widget child;
  final bool expand;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: sy(2)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: sy(4)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                expand ? SizedBox() : Spacer(),
                expand ? Expanded(child: child) : child,
              ],
            ),
          ),
        );
      },
    );
  }
}
