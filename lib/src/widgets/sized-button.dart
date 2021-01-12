import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'app-theme.dart';

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
    this.tooltip,
    this.enabled = true,
  })  : assert(height != null),
        super(key: key);

  final double height;
  final double width;
  final double radius;
  final void Function() onPressed;
  final Widget child;
  final MaterialTapTargetSize materialTapTargetSize;
  final EdgeInsetsGeometry padding;
  final Color color;
  final bool enabled;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    Widget container;
    if (height != null && width != null) {
      container = Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: FlatButton(
          onPressed: !enabled ? null : onPressed ?? () {},
          color: color ?? Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
          materialTapTargetSize: materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      );
    } else if (height != null && width == null) {
      container = Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: FlatButton(
          onPressed: !enabled ? null : onPressed ?? () {},
          color: color ?? Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
          materialTapTargetSize: materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      );
    }
    if (tooltip != null) {
      return RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Tooltip(
            message: tooltip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.of(context).primaryBackground,
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: sy(10),
            ),
            child: container,
          );
        },
      );
    }
    return container;
  }
}
