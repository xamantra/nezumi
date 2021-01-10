import 'package:flutter/material.dart';
import 'package:nezumi/src/widgets/app-theme.dart';
import 'package:relative_scale/relative_scale.dart';

class AnimeFilterStatItem extends StatelessWidget {
  const AnimeFilterStatItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.value,
    @required this.label,
    this.color,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          padding: EdgeInsets.all(sy(8)),
          decoration: BoxDecoration(
            color: color ?? AppTheme.of(context).accent,
            borderRadius: BorderRadius.circular(23),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: sy(10),
                    ),
                  ),
                  SizedBox(width: sy(12)),
                  Icon(
                    icon,
                    size: sy(14),
                  ),
                ],
              ),
              SizedBox(height: sy(4)),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: sy(20),
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: sy(9),
                  color: AppTheme.of(context).text3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
