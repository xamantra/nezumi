import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  const SizedButton({
    Key key,
    @required this.height,
    @required this.width,
    this.radius,
    this.onPressed,
    @required this.child,
    this.materialTapTargetSize,
    this.padding,
    this.color,
  })  : assert(height != null),
        assert(width != null),
        super(key: key);

  final double height;
  final double width;
  final double radius;
  final void Function() onPressed;
  final Widget child;
  final MaterialTapTargetSize materialTapTargetSize;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: FlatButton(
        onPressed: onPressed ?? () {},
        color: color ?? Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
        materialTapTargetSize: materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
