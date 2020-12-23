import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class Toolbar extends StatelessWidget with PreferredSizeWidget {
  const Toolbar({
    Key key,
    @required this.height,
    @required this.title,
    this.actionSpacing,
    this.actions = const [],
    this.leadingIcon,
    this.leadingAction,
  }) : super(key: key);

  final double height;
  final IconData leadingIcon;
  final void Function() leadingAction;
  final String title;
  final double actionSpacing;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            height: this.height,
            width: width,
            color: AppTheme.of(context).primary,
            padding: EdgeInsets.only(left: sy(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leadingIcon == null
                    ? SizedBox()
                    : SizedButton(
                        height: sy(34),
                        width: sy(34),
                        radius: 100,
                        child: Icon(
                          Icons.menu,
                          size: sy(14),
                          color: Colors.white,
                        ),
                        onPressed: leadingAction ?? () {},
                      ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sy(12),
                    ),
                  ),
                ),
                Spacer(),
              ]..addAll((actions ?? [])
                  .map<Widget>(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: sy(actionSpacing ?? 0)),
                      child: e,
                    ),
                  )
                  .toList()),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
