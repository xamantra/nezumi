import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/types/index.dart';

class AnimeListSortMenu extends StatelessWidget {
  const AnimeListSortMenu({
    Key key,
    @required this.value,
    @required this.orderByIcon,
    @required this.onChanged,
    this.iconSize,
  }) : super(key: key);

  final AnimeListSortBy value;
  final IconData orderByIcon;
  final double iconSize;
  final void Function(AnimeListSortBy) onChanged;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return PopupMenuButton<AnimeListSortBy>(
          tooltip: 'Sort By: ${getAnimeListSortByLabel(value)}',
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
            return AnimeListSortBy.values
                .map(
                  (e) => PopupMenuItem<AnimeListSortBy>(
                    value: e,
                    child: Text(
                      getAnimeListSortByLabel(e),
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
