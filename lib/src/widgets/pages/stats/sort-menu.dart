import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/types/index.dart';

class AnimeStatSortMenu extends StatelessWidget {
  const AnimeStatSortMenu({
    Key key,
    @required this.value,
    @required this.orderByIcon,
    @required this.onChanged,
    this.iconSize,
  }) : super(key: key);

  final AnimeStatSort value;
  final IconData orderByIcon;
  final double iconSize;
  final void Function(AnimeStatSort) onChanged;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return PopupMenuButton<AnimeStatSort>(
          tooltip: 'Sort By: ${getAnimeStatSortByLabel(value)}',
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
            return AnimeStatSort.values
                .map(
                  (e) => PopupMenuItem<AnimeStatSort>(
                    value: e,
                    child: Text(
                      getAnimeStatSortByLabel(e),
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
