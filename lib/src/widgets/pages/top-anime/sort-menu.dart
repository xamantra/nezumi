import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/types/index.dart';

class YearlyAnimeRankingSortMenu extends StatelessWidget {
  const YearlyAnimeRankingSortMenu({
    Key key,
    @required this.value,
    @required this.orderByIcon,
    @required this.onChanged,
    this.iconSize,
  }) : super(key: key);

  final TopAnimeSortBy value;
  final IconData orderByIcon;
  final double iconSize;
  final void Function(TopAnimeSortBy) onChanged;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return PopupMenuButton<TopAnimeSortBy>(
          tooltip: 'Sort By: ${getAnimeSortByLabel(value)}',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sy(8)),
            child: Icon(
              orderByIcon,
              color: Colors.white,
              size: iconSize ?? sy(11),
            ),
          ),
          initialValue: value,
          onSelected: onChanged,
          itemBuilder: (context) {
            return TopAnimeSortBy.values
                .map(
                  (e) => PopupMenuItem<TopAnimeSortBy>(
                    value: e,
                    child: Text(
                      getAnimeSortByLabel(e),
                      style: TextStyle(
                        fontSize: sy(9),
                      ),
                    ),
                  ),
                )
                .toList();
          },
        );
      },
    );
  }
}
