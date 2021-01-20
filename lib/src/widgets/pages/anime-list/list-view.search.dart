import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-search/index.dart';
import '../../../mixins/index.dart';
import '../../builders/index.dart';
import '../../index.dart';
import '../../items/index.dart';

class AnimeSearchListView extends StatefulWidget {
  const AnimeSearchListView({
    Key key,
    this.isMyListResults = true,
  }) : super(key: key);

  final bool isMyListResults;

  @override
  _AnimeSearchListViewState createState() => _AnimeSearchListViewState();
}

class _AnimeSearchListViewState extends State<AnimeSearchListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var compactMode = appSettings.compactMode;
    var fields = settings.getSelectedAnimeFields ?? [];
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeSearchController],
          builder: (context, snapshot) {
            if (widget.isMyListResults) {
              var list = animeSearch.listResults ?? [];
              if (list.isEmpty) {
                return Center(
                  child: Text(
                    'There\'s nothing here.',
                    style: TextStyle(
                      color: AppTheme.of(context).text7,
                      fontSize: sy(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var anime = list[index];
                  var inMyList = mal.inMyList(anime?.id);
                  return AnimeItemCard(
                    anime: anime,
                    compactMode: compactMode,
                    editMode: inMyList,
                    fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                  );
                },
              );
            } else {
              var loading = animeSearch.loadingResult ?? false;
              if (loading) {
                return Loader();
              }
              if (animeSearch.results.isEmpty) {
                return Center(
                  child: Text(
                    'There\'s nothing here.',
                    style: TextStyle(
                      color: AppTheme.of(context).text7,
                      fontSize: sy(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              // TODO: paginate search results
              var list = animeSearch.results ?? [];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedButton(
                        height: sy(36),
                        width: sy(36),
                        radius: 100,
                        enabled: animeSearch.prevPage.isNotEmpty,
                        child: Icon(
                          Icons.chevron_left,
                          size: sy(20),
                          color: AppTheme.of(context).accent,
                        ),
                        onPressed: () {
                          animeSearch.controller.gotoPrevPageMALSearch();
                        },
                      ),
                      SizedButton(
                        height: sy(36),
                        width: sy(36),
                        radius: 100,
                        enabled: animeSearch.nextPage.isNotEmpty,
                        child: Icon(
                          Icons.chevron_right,
                          size: sy(20),
                          color: AppTheme.of(context).accent,
                        ),
                        onPressed: () {
                          animeSearch.controller.gotoNextPageMALSearch();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var anime = list[index];
                        var inMyList = mal.inMyList(anime?.id);
                        return AnimeItemCard(
                          anime: anime,
                          compactMode: compactMode,
                          editMode: inMyList,
                          fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
