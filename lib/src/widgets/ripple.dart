import 'package:flutter/material.dart';

class Ripple extends StatelessWidget {
  const Ripple({
    Key key,
    @required this.child,
    this.padding,
    this.radius,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final double padding;
  final double radius;
  final void Function() onPressed;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      onLongPress: onLongPress ?? () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 3),
      ),
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        child: child,
      ),
    );
  }
}
