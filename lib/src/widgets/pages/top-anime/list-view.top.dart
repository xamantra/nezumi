import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../anime-list/index.dart';

class AnimeTopListView extends StatefulWidget {
  AnimeTopListView({
    Key key,
    @required this.index,
    @required this.leadBuilder,
    @required this.trailBuilder,
  }) : super(key: key);

  final int index;
  final Widget Function(BuildContext context, int index, AnimeDataItem anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDataItem anime) trailBuilder;

  @override
  _AnimeTopListViewState createState() => _AnimeTopListViewState();
}

class _AnimeTopListViewState extends State<AnimeTopListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    switch (widget.index) {
      case 0:
        if (animeTop.topAll == null) animeTop.controller.loadTopAll();
        break;
      case 1:
        if (animeTop.topAiring == null) animeTop.controller.loadTopAiring();
        break;
      case 2:
        if (animeTop.topUpcoming == null) animeTop.controller.loadTopUpcoming();
        break;
      case 3:
        if (animeTop.topTV == null) animeTop.controller.loadTopTV();
        break;
      case 4:
        if (animeTop.topMovies == null) animeTop.controller.loadTopMovies();
        break;
      case 5:
        if (animeTop.topOVA == null) animeTop.controller.loadTopOVA();
        break;
      case 6:
        if (animeTop.topSpecials == null) animeTop.controller.loadTopSpecials();
        break;
      case 7:
        if (animeTop.topPopularity == null) animeTop.controller.loadTopPopularity();
        break;
      case 8:
        if (animeTop.topFavorites == null) animeTop.controller.loadTopFavorites();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            if (animeTop.isLoading(widget.index)) {
              return Loader();
            }

            var list = animeTop.getTopByIndex(widget.index)?.data ?? [];
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var anime = list[index];
                var inMyList = mal.inMyList(anime?.node?.id);
                return AnimeGlobalItemCard(
                  anime: anime,
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
                );
              },
            );
          },
        );
      },
    );
  }
}
