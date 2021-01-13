import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../components/anime-filter/index.dart';
import '../../../../../mixins/index.dart';
import '../../../../items/index.dart';
import 'index.dart';

class AnimeFilterResultView extends StatefulWidget {
  const AnimeFilterResultView({Key key}) : super(key: key);

  @override
  _AnimeFilterResultViewState createState() => _AnimeFilterResultViewState();
}

class _AnimeFilterResultViewState extends State<AnimeFilterResultView> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var list = animeFilter.results ?? [];
            var entryCount = list.length;

            return Column(
              children: [
                Container(
                  width: width,
                  padding: EdgeInsets.all(sy(8)),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AnimeFilterStatItem(
                          title: 'Results',
                          icon: Icons.sort,
                          value: '$entryCount',
                          label: 'entries',
                          color: Colors.deepPurple,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Length',
                          icon: Icons.calendar_today,
                          value: '${animeFilter.controller.resultTotalDays()}',
                          label: 'days',
                          color: Colors.pink,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Average',
                          icon: Icons.timeline,
                          value: '${animeFilter.controller.resultEpisodesPerEntry()}',
                          label: 'episodes/entry',
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Duration',
                          icon: Icons.timer_sharp,
                          value: '${animeFilter.controller.minutesPerEpisode()}',
                          label: 'minutes/episode',
                          color: Colors.purple,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Episodes',
                          icon: Icons.filter_1,
                          value: '${animeFilter.controller.resultTotalEpisodes()}',
                          label: 'total episodes',
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var anime = list[index];
                      return AnimeItemCard(anime: anime);
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
