import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../components/app-settings/index.dart';
import '../../../components/my_anime_list/index.dart';
import '../../../data/index.dart';
import '../../../utils/index.dart';
import '../../index.dart';
import '../anime-list/index.dart';

class AnimeTopListExlcudedView extends StatelessWidget {
  const AnimeTopListExlcudedView({
    Key key,
    this.leadBuilder,
    this.trailBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext context, int index, AnimeDataItem anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDataItem anime) trailBuilder;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: MomentumBuilder(
            controllers: [AnimeTopController],
            builder: (context, snapshot) {
              var settings = ctrl<AppSettingsController>(context).model;
              var mal = ctrl<MyAnimeListController>(context).model;
              var animeTop = ctrl<AnimeTopController>(context).model;

              var compactMode = settings.compactMode;
              var list = animeTop.controller.getExcludedList();

              return SafeArea(
                child: Column(
                  children: [
                    Toolbar(
                      height: sy(33),
                      title: 'Excluded Entries',
                      actions: [],
                    ),
                    !animeTop.selectionMode
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.all(sy(6)),
                            child: Row(
                              children: [
                                Text(
                                  '${animeTop.selectedAnimeIDs.length} ',
                                  style: TextStyle(
                                    color: AppTheme.of(context).accent,
                                    fontSize: sy(12),
                                  ),
                                ),
                                Text(
                                  'selected',
                                  style: TextStyle(
                                    color: AppTheme.of(context).text4,
                                    fontSize: sy(12),
                                  ),
                                ),
                                Spacer(),
                                SizedButton(
                                  height: sy(24),
                                  width: sy(100),
                                  radius: 5,
                                  child: Text(
                                    'Include Selected',
                                    style: TextStyle(
                                      color: AppTheme.of(context).accent,
                                      fontSize: sy(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    animeTop.controller.moveSelectionToIncluded();
                                  },
                                ),
                                Spacer(),
                                SizedButton(
                                  height: sy(24),
                                  width: sy(24),
                                  radius: 100,
                                  child: Icon(
                                    Icons.close,
                                    size: sy(14),
                                  ),
                                  onPressed: () {
                                    animeTop.controller.clearSelection();
                                  },
                                ),
                              ],
                            ),
                          ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          var anime = list[index];
                          var inMyList = mal.inMyList(anime?.node?.id);
                          var selected = animeTop.isAnimeSelected(anime.node.id);
                          return AnimeGlobalItemCard(
                            anime: anime,
                            compactMode: compactMode,
                            editMode: inMyList,
                            selected: selected,
                            leadBuilder: leadBuilder != null
                                ? (context, anime) {
                                    return leadBuilder(context, index, anime);
                                  }
                                : null,
                            trailBuilder: trailBuilder != null
                                ? (context, anime) {
                                    return trailBuilder(context, index, anime);
                                  }
                                : null,
                            onPressed: (anime) {
                              if (animeTop.selectionMode) {
                                if (selected) {
                                  animeTop.controller.unselectAnime(anime.node.id);
                                } else {
                                  animeTop.controller.selectAnime(anime.node.id);
                                }
                              }
                            },
                            onLongPress: (anime) {
                              if (selected) {
                                animeTop.controller.unselectAnime(anime.node.id);
                              } else {
                                animeTop.controller.selectAnime(anime.node.id);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
