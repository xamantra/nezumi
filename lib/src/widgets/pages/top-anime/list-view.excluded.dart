import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../components/app-settings/index.dart';
import '../../../components/my_anime_list/index.dart';
import '../../../components/settings/index.dart';
import '../../../data/index.dart';
import '../../../data/types/index.dart';
import '../../../utils/index.dart';
import '../../builders/index.dart';
import '../../index.dart';
import '../../items/index.dart';
import 'index.dart';

class AnimeTopListExlcudedView extends StatelessWidget {
  const AnimeTopListExlcudedView({
    Key key,
    this.leadBuilder,
    this.trailBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext context, int index, AnimeDetails anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDetails anime) trailBuilder;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: MomentumBuilder(
            controllers: [AnimeTopController],
            builder: (context, snapshot) {
              var settings = ctrl<AppSettingsController>(context).model;
              var s2 = ctrl<SettingsController>(context).model;
              var mal = ctrl<MyAnimeListController>(context).model;
              var animeTop = ctrl<AnimeTopController>(context).model;

              var compactMode = settings.compactMode;
              var fields = s2.getSelectedAnimeFields ?? [];
              var list = animeTop.controller.getExcludedList();

              var onlyOneSelectd = animeTop.selectedAnimeIDs.length == 1;
              var selectedAnimeId = -1;
              if (onlyOneSelectd) {
                selectedAnimeId = animeTop.selectedAnimeIDs.first;
              }

              IconData orderByIcon;
              IconData sortByIcon;
              String orderBy;
              switch (animeTop.yearlyRankingOrderBy) {
                case OrderBy.ascending:
                  orderByIcon = Icons.arrow_upward;
                  sortByIcon = CustomIcons.sort_amount_up;
                  orderBy = 'Ascending';
                  break;
                case OrderBy.descending:
                  orderByIcon = Icons.arrow_downward;
                  sortByIcon = CustomIcons.sort_amount_down;
                  orderBy = 'Descending';
                  break;
              }

              return Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    color: AppTheme.of(context).primary,
                  ),
                  SafeArea(
                    child: Container(
                      color: AppTheme.of(context).primaryBackground,
                      child: Column(
                        children: [
                          Toolbar(
                            height: sy(33),
                            title: 'Excluded Entries',
                            actions: [
                              ToolbarAction(
                                icon: orderByIcon,
                                tooltip: orderBy,
                                onPressed: () {
                                  animeTop.controller.toggleOrderBy();
                                },
                              ),
                              YearlyAnimeRankingSortMenu(
                                value: animeTop.yearlyRankingSortBy,
                                orderByIcon: sortByIcon,
                                onChanged: (sortBy) {
                                  animeTop.controller.changeSortBy(sortBy);
                                },
                              ),
                            ],
                          ),
                          SelectionToolWidget(
                            actionIcon: Icons.remove_red_eye,
                            actionSize: sy(12),
                            actionTooltip: 'Include all selected',
                            onActionCallback: () {
                              animeTop.controller.moveSelectionToIncluded();
                            },
                            onSelectAbove: () {
                              animeTop.controller.selectAllAboveExcludedIndex(selectedAnimeId);
                            },
                            onSelectBelow: () {
                              animeTop.controller.selectAllBelowExcludedIndex(selectedAnimeId);
                            },
                          ),
                          Expanded(
                            child: Container(
                              color: AppTheme.of(context).primaryBackground,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  var anime = list[index];
                                  var inMyList = mal.inMyList(anime?.id);
                                  var selected = animeTop.isAnimeSelected(anime.id);
                                  return AnimeItemCard(
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
                                    fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                                    onPressed: (anime) {
                                      if (animeTop.selectionMode) {
                                        if (selected) {
                                          animeTop.controller.unselectAnime(anime.id);
                                        } else {
                                          animeTop.controller.selectAnime(anime.id);
                                        }
                                      }
                                    },
                                    onLongPress: (anime) {
                                      if (selected) {
                                        animeTop.controller.unselectAnime(anime.id);
                                      } else {
                                        animeTop.controller.selectAnime(anime.id);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
