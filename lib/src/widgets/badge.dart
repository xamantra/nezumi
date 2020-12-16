import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.color,
    @required this.textColor,
    @required this.text,
    @required this.fontSize,
    this.borderRadius,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final String text;
  final double fontSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: sy(4), vertical: sy(2)),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        );
      },
    );
  }
}
