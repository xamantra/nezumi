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
    this.onPressed,
    this.paddingX,
    this.paddingY,
    this.fontWeight,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final String text;
  final double fontSize;
  final double borderRadius;
  final void Function(String) onPressed;
  final double paddingX;
  final double paddingY;
  final BoxShape shape;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return GestureDetector(
          onTap: () {
            if (onPressed != null) {
              onPressed(text);
            }
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sy(paddingX ?? 4), vertical: sy(paddingY ?? 2)),
              decoration: BoxDecoration(
                color: color,
                borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius ?? 10),
                shape: shape,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight ?? FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
