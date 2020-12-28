import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../mixins/index.dart';
import '../../../../../modules/anime-filter/index.dart';
import '../../../../index.dart';
import '../../index.dart';

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
                Card(
                  margin: EdgeInsets.all(sy(8)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sy(24), vertical: sy(8)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$entryCount',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ' entries',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${animeFilter.controller.resultTotalDays()}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ' days',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${animeFilter.controller.resultEpisodesPerEntry()}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ' eps/entry',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${animeFilter.controller.minutesPerEpisode()}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    ' mins/episode',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: sy(12),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
