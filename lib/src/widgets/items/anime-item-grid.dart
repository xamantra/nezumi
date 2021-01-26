import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/anime-update/index.dart';
import '../../data/index.dart';
import '../../utils/index.dart';
import '../app-theme.dart';
import '../index.dart';
import '../pages/anime-list/index.dart';

class AnimeItemGrid extends StatelessWidget {
  const AnimeItemGrid({
    Key key,
    @required this.anime,
    this.compactMode = false,
    this.index,
  }) : super(key: key);

  final AnimeDetails anime;
  final bool compactMode;
  final int index;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: EdgeInsets.all(sy(4)),
                child: GestureDetector(
                  onTap: () {
                    ctrl<AnimeUpdateController>(context).setCurrentAnime(
                      id: anime.id,
                      title: anime.title,
                    );
                    dialog(context, EditAnimeDialog());
                  },
                  child: ImageWidget(
                    url: anime.mainPicture?.medium ?? '',
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
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
        );
      },
    );
  }
}
