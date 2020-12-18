import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({
    Key key,
    this.size,
    this.color,
    this.spacing,
  }) : super(key: key);

  final double size;
  final Color color;
  final EdgeInsets spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 3,
      width: size ?? 3,
      margin: spacing ?? EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.white,
      ),
    );
  }
}
