import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../../modules/anime-filter/index.dart';
import 'index.dart';

class AnimeFilterListView extends StatefulWidget {
  const AnimeFilterListView({Key key}) : super(key: key);

  @override
  _AnimeFilterListViewState createState() => _AnimeFilterListViewState();
}

class _AnimeFilterListViewState extends State<AnimeFilterListView> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var list = animeFilter.results ?? [];

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
