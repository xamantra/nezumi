import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class ToolbarAction extends StatelessWidget {
  const ToolbarAction({
    Key key,
    @required this.icon,
    this.size,
    this.iconSize,
    this.onPressed,
    this.tooltip,
  }) : super(key: key);

  final double size;
  final IconData icon;
  final double iconSize;
  final void Function() onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        var sizedButton = SizedButton(
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize ?? sy(14),
          ),
          radius: 100,
          height: size ?? sy(36),
          width: size ?? sy(36),
          onPressed: onPressed ?? () {},
        );
        if (tooltip == null) {
          return sizedButton;
        }
        return Tooltip(
          message: tooltip ?? '',
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: sy(9),
          ),
          child: sizedButton,
        );
      },
    );
  }
}
