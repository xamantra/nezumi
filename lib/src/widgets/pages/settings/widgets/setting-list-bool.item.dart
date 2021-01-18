import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../utils/index.dart';
import '../../../index.dart';

class DialogSettingItem extends StatelessWidget {
  const DialogSettingItem({
    Key key,
    @required this.builder,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final Widget Function(BuildContext) builder;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Ripple(
          onPressed: () {
            dialog(context, builder(context));
          },
          radius: 0,
          padding: sy(8),
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: sy(11),
                    color: AppTheme.of(context).text1,
                  ),
                ),
                SizedBox(height: sy(4)),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: sy(9),
                    color: AppTheme.of(context).text4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
