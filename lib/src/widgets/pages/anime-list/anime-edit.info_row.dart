import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../app-theme.dart';

class AnimeEditInfoRow extends StatelessWidget {
  const AnimeEditInfoRow({
    Key key,
    @required this.label,
    @required this.child,
    this.expand = false,
  }) : super(key: key);

  final String label;
  final Widget child;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Row(
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
        );
      },
    );
  }
}
