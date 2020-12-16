import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../modules/my_anime_list/index.dart';
import '../../index.dart';
import 'index.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({
    Key key,
    @required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [MyAnimeListController],
          builder: (context, snapshot) {
            var mal = snapshot<MyAnimeListModel>();
            var list = mal.fullUserAnimeList.getByStatus(status);

            if (mal.loading) {
              return Loader();
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var anime = list[index];
                return AnimeItemCard(anime: anime);
              },
            );
          },
        );
      },
    );
  }
}
