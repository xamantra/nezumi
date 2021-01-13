import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../../items/index.dart';
import '../anime-list/tabs/anime-filter-widgets/index.dart';
import 'index.dart';

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
  RefreshController controller = RefreshController();

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
            var list = animeTop?.controller?.getCurrentYearRankList() ?? [];
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
                              title: 'Filtered',
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
                              label: 'filtered entries',
                              color: Colors.pink,
                            ),
                            SizedBox(width: sy(8)),
                            AnimeFilterStatItem(
                              title: 'Votes',
                              icon: Icons.people,
                              value: animeTop.controller.getVotesPerEntry(),
                              label: 'per entry',
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                SelectionToolWidget(
                  actionIcon: CustomIcons.eye_slash,
                  actionSize: sy(10),
                  actionTooltip: 'Exclude all selected',
                  onActionCallback: () {
                    animeTop.controller.moveSelectionToExcluded();
                  },
                  onSelectAbove: () {
                    animeTop.controller.selectAllAboveIndex(selectedAnimeId);
                  },
                  onSelectBelow: () {
                    animeTop.controller.selectAllBelowIndex(selectedAnimeId);
                  },
                ),
                Expanded(
                  child: SmartRefresher(
                    physics: BouncingScrollPhysics(),
                    controller: controller,
                    onRefresh: () {
                      animeTop.controller.loadYearRankings();
                    },
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}
