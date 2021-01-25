import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/anime-update/index.dart';
import '../../data/index.dart';
import '../../utils/index.dart';
import '../index.dart';
import '../pages/anime-list/index.dart';

class AnimeItemCard extends StatelessWidget {
  const AnimeItemCard({
    Key key,
    @required this.anime,
    this.compactMode = false,
    this.selected = false,
    this.editMode = true,
    this.leadBuilder,
    this.trailBuilder,
    @required this.fieldsBuilder,
    this.onPressed,
    this.onLongPress,
    this.index,
  }) : super(key: key);

  final AnimeDetails anime;
  final bool compactMode;
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
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        var actions = [
          Container(
            padding: EdgeInsets.symmetric(vertical: sy(4)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: IconSlideAction(
                color: Colors.transparent,
                iconWidget: Icon(
                  editMode ? Icons.edit : Icons.add,
                  size: sy(20),
                  color: Colors.blue,
                ),
                onTap: () {
                  ctrl<AnimeUpdateController>(context).setCurrentAnime(
                    id: anime.id,
                    title: anime.title,
                  );
                  dialog(context, EditAnimeDialog());
                },
                closeOnTap: false,
              ),
            ),
          ),
        ];
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            width: width,
            margin: EdgeInsets.symmetric(vertical: sy(compactMode ? 0 : 4)),
            color: selected ? AppTheme.of(context).text7 : Colors.transparent,
            child: Ripple(
              padding: sy(2),
              onPressed: () {
                if (onPressed != null) {
                  onPressed(anime);
                }
              },
              onLongPress: () {
                if (onLongPress != null) {
                  onLongPress(anime);
                }
              },
              radius: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leadBuilder != null ? leadBuilder(context, anime) : SizedBox(),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(sy(4)),
                        child: SymmetricImage(
                          url: anime?.mainPicture?.medium ?? '',
                          size: sy(compactMode ? 22 : 32),
                        ),
                      ),
                      index == null
                          ? SizedBox()
                          : Badge(
                              color: AppTheme.of(context).accent,
                              textColor: Colors.white,
                              text: '${index + 1}',
                              fontSize: sy(compactMode ? 6.5 : 8),
                              paddingX: 3,
                              paddingY: 3,
                              shape: BoxShape.circle,
                            ),
                    ],
                  ),
                  SizedBox(width: sy(2)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime?.title,
                          style: TextStyle(
                            color: AppTheme.of(context).text3,
                            fontWeight: FontWeight.w600,
                            fontSize: sy(10),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: fieldsBuilder == null ? SizedBox() : fieldsBuilder(context, anime),
                        ),
                      ],
                    ),
                  ),
                  trailBuilder != null ? trailBuilder(context, anime) : SizedBox(),
                ],
              ),
            ),
          ),
          actions: actions,
          secondaryActions: actions,
        );
      },
    );
  }
}
