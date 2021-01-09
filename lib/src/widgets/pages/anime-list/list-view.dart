import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/my_anime_list/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import 'index.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({
    Key key,
    @required this.status,
  }) : super(key: key);

  final String status;

  @override
  _AnimeListViewState createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [MyAnimeListController],
          builder: (context, snapshot) {
            var list = mal.userAnimeList?.getByStatus(widget.status);

            if (mal.loading) {
              return Loader();
            }

            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                mal.controller.loadAnimeListByStatus(widget.status);
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var anime = list[index];
                  return AnimeItemCard(anime: anime);
                },
              ),
            );
          },
        );
      },
    );
  }
}
