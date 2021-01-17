import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../index.dart';

class BoolSettingItem extends StatelessWidget {
  const BoolSettingItem({
    Key key,
    @required this.value,
    @required this.onChanged,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final bool value;
  final void Function(bool) onChanged;

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Ripple(
          onPressed: () {
            onChanged(!value);
          },
          radius: 0,
          padding: sy(8),
          child: Row(
            children: [
              Expanded(
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
              Checkbox(
                value: value,
                activeColor: AppTheme.of(context).primary,
                onChanged: (compactMode) {
                  onChanged(compactMode);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
