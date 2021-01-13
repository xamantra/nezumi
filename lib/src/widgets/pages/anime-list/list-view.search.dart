import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-search/index.dart';
import '../../../mixins/index.dart';
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
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeSearchController],
          builder: (context, snapshot) {
            if (widget.isMyListResults) {
              var list = animeSearch.listResults ?? [];
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var anime = list[index];
                  var inMyList = mal.inMyList(anime?.node?.id);
                  return AnimeItemCard(
                    anime: anime,
                    compactMode: compactMode,
                    editMode: inMyList,
                  );
                },
              );
            } else {
              var loading = animeSearch.loadingResult ?? false;
              if (loading) {
                return Loader();
              }

              var list = animeSearch.results ?? [];
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var anime = list[index];
                  var inMyList = mal.inMyList(anime?.node?.id);
                  return AnimeGlobalItemCard(
                    anime: anime,
                    compactMode: compactMode,
                    editMode: inMyList,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
