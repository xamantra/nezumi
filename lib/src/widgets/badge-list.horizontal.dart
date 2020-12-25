import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class HorizontalBadgeList extends StatelessWidget {
  const HorizontalBadgeList({
    Key key,
    @required this.items,
    @required this.color,
    this.itemCallback,
  }) : super(key: key);

  final List<String> items;
  final Color color;
  final void Function(String) itemCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map<Widget>(
                  (e) => GestureDetector(
                    onTap: () {
                      // updateFilter(false, e, remove: true);
                      if (itemCallback != null) {
                        itemCallback(e);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(sy(4)),
                      margin: EdgeInsets.symmetric(horizontal: sy(2)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: color,
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: sy(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
