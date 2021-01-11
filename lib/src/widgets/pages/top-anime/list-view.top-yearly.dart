import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../anime-list/index.dart';
import '../anime-list/tabs/anime-filter-widgets/index.dart';

class AnimeTopYearlyView extends StatefulWidget {
  AnimeTopYearlyView({
    Key key,
    @required this.leadBuilder,
    @required this.trailBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext context, int index, AnimeDataItem anime) leadBuilder;
  final Widget Function(BuildContext context, int index, AnimeDataItem anime) trailBuilder;

  @override
  _AnimeTopYearlyViewState createState() => _AnimeTopYearlyViewState();
}

class _AnimeTopYearlyViewState extends State<AnimeTopYearlyView> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            if (animeTop.loadingYearlyRankings) {
              return Loader();
            }

            var list = animeTop?.selectedYearRankings?.data ?? [];
            return Column(
              children: [
                animeTop.fullscreen
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(sy(6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimeFilterStatItem(
                              title: 'Quantity',
                              icon: Icons.sort,
                              value: animeTop.controller.getEntryCount(),
                              label: 'entries',
                              color: Colors.deepPurple,
                            ),
                            SizedBox(width: sy(8)),
                            AnimeFilterStatItem(
                              title: 'Average',
                              icon: Icons.timeline,
                              value: animeTop.controller.getMeanScore(),
                              label: 'out of 10',
                              color: Colors.pink,
                            ),
                          ],
                        ),
                      ),
                Expanded(
                  child: ListView.builder(
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
