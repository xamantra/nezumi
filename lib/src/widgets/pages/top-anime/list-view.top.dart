import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../builders/index.dart';
import '../../index.dart';
import '../../items/index.dart';

// TODO: paginate top list
class AnimeTopListView extends StatefulWidget {
  AnimeTopListView({
    Key key,
    @required this.index,
    @required this.leadBuilder,
    @required this.trailBuilder,
  }) : super(key: key);

  final int index;
  final Widget Function(BuildContext context, int index, AnimeDetails anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDetails anime) trailBuilder;

  @override
  _AnimeTopListViewState createState() => _AnimeTopListViewState();
}

class _AnimeTopListViewState extends State<AnimeTopListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var top = animeTop.getTopByIndex(widget.index);
    if (top == null) {
      animeTop.controller.loadMalRankings(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    var compactMode = appSettings.compactMode;
    var index = widget.index;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            if (animeTop.isLoading(widget.index)) {
              return Loader();
            }

            var list = animeTop.getTopByIndex(widget.index)?.list ?? [];
            var fields = settings.getSelectedAnimeFields ?? [];

            return Column(
              children: [
                Paginator(
                  currentPage: animeTop.currentPage(index),
                  prevEnabled: animeTop.prevPageEnabled(index),
                  nextEnabled: animeTop.nextPageEnabled(index),
                  onPrev: () {
                    animeTop.controller.gotoPrevPageMALSearch(index);
                  },
                  onNext: () {
                    animeTop.controller.gotoNextPageMalRankings(index);
                  },
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
                        fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
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
