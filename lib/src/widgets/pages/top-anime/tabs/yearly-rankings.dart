import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-top/index.dart';
import '../../../../mixins/index.dart';
import '../../../builders/index.dart';
import '../../../index.dart';
import '../index.dart';

class YearlyAnimeRankingPage extends StatefulWidget {
  const YearlyAnimeRankingPage({Key key}) : super(key: key);

  @override
  _YearlyAnimeRankingPageState createState() => _YearlyAnimeRankingPageState();
}

class _YearlyAnimeRankingPageState extends State<YearlyAnimeRankingPage> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 9, vsync: this);
    animeTop.controller.loadYearRankings();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SafeArea(
          child: Column(
            children: [
              Toolbar(
                height: sy(42),
                leadingIcon: Icons.menu,
                title: 'Yearly Anime Rankings',
                actions: [
                  ToolbarAction(
                    icon: Icons.refresh,
                    onPressed: () {
                      // TODO: refresh active tab.
                    },
                  ),
                ],
                leadingAction: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              MomentumBuilder(
                controllers: [AnimeTopController],
                builder: (context, snapshot) {
                  return Container(
                    color: AppTheme.of(context).primary,
                    padding: EdgeInsets.symmetric(horizontal: sy(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedButton(
                          height: sy(32),
                          width: sy(32),
                          radius: 100,
                          enabled: !animeTop.loadingYearlyRankings,
                          child: Icon(
                            Icons.chevron_left,
                          ),
                          onPressed: () {
                            animeTop.controller.prevYear();
                          },
                        ),
                        Text(
                          '${animeTop.selectedYear}',
                          style: TextStyle(
                            fontSize: sy(11),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedButton(
                          height: sy(32),
                          width: sy(32),
                          radius: 100,
                          enabled: !animeTop.loadingYearlyRankings,
                          child: Icon(
                            Icons.chevron_right,
                          ),
                          onPressed: () {
                            animeTop.controller.nextYear();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: Container(
                  color: AppTheme.of(context).primaryBackground,
                  child: AnimeTopYearlyView(
                    leadBuilder: buildAnimeGlobalItemIndexNumber,
                    trailBuilder: buildAnimeGlobalItemScore,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
