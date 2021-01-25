import 'package:flutter/material.dart';
import 'package:nezumi/src/data/index.dart';

import 'index.dart';

class AnimeItem extends StatelessWidget {
  const AnimeItem({
    Key key,
    @required this.anime,
    this.compactMode = false,
    @required this.listMode,
    this.selected = false,
    this.editMode = true,
    this.index,
    this.leadBuilder,
    this.trailBuilder,
    this.fieldsBuilder,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final AnimeDetails anime;
  final bool compactMode;
  final bool listMode;
  final bool selected;
  final bool editMode;
  final int index;
  final Widget Function(BuildContext context, AnimeDetails anime) leadBuilder;
  final Widget Function(BuildContext context, AnimeDetails anime) trailBuilder;
  final Widget Function(BuildContext context, AnimeDetails anime) fieldsBuilder;
  final void Function(AnimeDetails anime) onPressed;
  final void Function(AnimeDetails anime) onLongPress;

  @override
  Widget build(BuildContext context) {
    if (listMode) {
      return AnimeItemList(
        anime: anime,
        compactMode: compactMode,
        selected: selected,
        editMode: editMode,
        index: index,
        leadBuilder: leadBuilder,
        trailBuilder: trailBuilder,
        fieldsBuilder: fieldsBuilder,
        onPressed: onPressed,
        onLongPress: onLongPress,
      );
    }
    return AnimeItemGrid();
  }
}
