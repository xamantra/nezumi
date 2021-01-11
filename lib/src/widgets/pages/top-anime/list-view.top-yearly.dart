import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../anime-list/index.dart';
import '../anime-list/tabs/anime-filter-widgets/index.dart';

class AnimeTopYearlyView extends StatefulWidget {
  AnimeTopYearlyView({
    Key key,
    @required this.leadBuilder,
    @required this.trailBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext context, int index, AnimeDataItem anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDataItem anime) trailBuilder;

  @override
  _AnimeTopYearlyViewState createState() => _AnimeTopYearlyViewState();
}

class _AnimeTopYearlyViewState extends State<AnimeTopYearlyView> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    var compactMode = appSettings.compactMode;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            if (animeTop.loadingYearlyRankings) {
              return Loader();
            }

            var list = animeTop?.selectedYearRankings?.data ?? [];
            var onlyOneSelectd = animeTop.selectedAnimeIDs.length == 1;
            var selectedAnimeId = -1;
            if (onlyOneSelectd) {
              selectedAnimeId = animeTop.selectedAnimeIDs.first;
            }
            return Column(
              children: [
                animeTop.fullscreen || animeTop.selectionMode
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(sy(6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimeFilterStatItem(
                              title: 'Quantity',
                              icon: Icons.sort,
                              value: animeTop.controller.getEntryCount(),
                              label: 'entries',
                              color: Colors.deepPurple,
                            ),
                            SizedBox(width: sy(8)),
                            AnimeFilterStatItem(
                              title: 'Average',
                              icon: Icons.timeline,
                              value: animeTop.controller.getMeanScore(),
                              label: 'out of 10',
                              color: Colors.pink,
                            ),
                          ],
                        ),
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
                            !onlyOneSelectd
                                ? SizedBox()
                                : SizedButton(
                                    height: sy(24),
                                    width: sy(60),
                                    radius: 5,
                                    child: Text(
                                      'Select Above',
                                      style: TextStyle(
                                        color: AppTheme.of(context).accent,
                                        fontSize: sy(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      animeTop.controller.selectAllAboveIndex(selectedAnimeId);
                                    },
                                  ),
                            SizedBox(width: sy(onlyOneSelectd ? 4 : 0)),
                            SizedButton(
                              height: sy(24),
                              width: sy(65),
                              radius: 5,
                              child: Text(
                                'Exclude Selected',
                                style: TextStyle(
                                  color: AppTheme.of(context).accent,
                                  fontSize: sy(10),
                                ),
                              ),
                              onPressed: () {
                                animeTop.controller.moveSelectionToExcluded();
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
                        leadBuilder: widget.leadBuilder != null
                            ? (context, anime) {
                                return widget.leadBuilder(context, index, anime);
                              }
                            : null,
                        trailBuilder: widget.trailBuilder != null
                            ? (context, anime) {
                                return widget.trailBuilder(context, index, anime);
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
            );
          },
        );
      },
    );
  }
}
