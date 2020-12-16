import 'package:flutter/material.dart';

class Ripple extends StatelessWidget {
  const Ripple({
    Key key,
    @required this.child,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final double padding;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed ?? () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(padding ?? 0),
        child: child,
      ),
    );
  }
}
