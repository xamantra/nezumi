import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class ToolbarAction extends StatelessWidget {
  const ToolbarAction({
    Key key,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SizedButton(
          child: Icon(
            icon,
            color: Colors.white,
            size: sy(14),
          ),
          radius: 100,
          height: sy(36),
          width: sy(36),
          onPressed: onPressed ?? () {},
        );
      },
    );
  }
}
