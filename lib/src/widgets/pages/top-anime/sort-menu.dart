import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/types/index.dart';

class YearlyAnimeRankingSortMenu extends StatelessWidget {
  const YearlyAnimeRankingSortMenu({
    Key key,
    @required this.value,
    @required this.orderByIcon,
    @required this.onChanged,
  }) : super(key: key);

  final AnimeSortBy value;
  final IconData orderByIcon;
  final void Function(AnimeSortBy) onChanged;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return PopupMenuButton<AnimeSortBy>(
          tooltip: 'Sort By: ${getAnimeSortByLabel(value)}',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sy(8)),
            child: Icon(
              orderByIcon,
              color: Colors.white,
              size: sy(11),
            ),
          ),
          initialValue: value,
          onSelected: onChanged,
          itemBuilder: (context) {
            return AnimeSortBy.values
                .map(
                  (e) => PopupMenuItem<AnimeSortBy>(
                    value: e,
                    child: Text(
                      getAnimeSortByLabel(e),
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
