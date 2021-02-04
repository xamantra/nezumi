import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../index.dart';
import 'index.dart';

class FilterPrompt extends StatefulWidget {
  const FilterPrompt({Key key}) : super(key: key);

  @override
  _FilterPromptState createState() => _FilterPromptState();
}

class _FilterPromptState extends State<FilterPrompt> with SingleTickerProviderStateMixin {
  TabController tabController;
  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    currentTab = tabController.index;
    tabController.addListener(() {
      var i = tabController.index;
      if (i != currentTab) {
        setState(() {
          currentTab = tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          Widget tab = SizedBox();
          switch (currentTab) {
            case 0:
              tab = YearlyRankingAnimeTypesDialog();
              break;
            case 1:
              tab = YearlyRankingAnimeSeasonDialog();
              break;
            case 2:
              tab = YearlyRankingAnimeAirStatusDialog();
              break;
            default:
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: tabController,
                isScrollable: true,
                labelColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                physics: BouncingScrollPhysics(),
                tabs: [
                  MyListTabItem(label: 'Format', active: currentTab == 0, count: 0),
                  MyListTabItem(label: 'Season', active: currentTab == 1, count: 0),
                  MyListTabItem(label: 'Airing Status', active: currentTab == 2, count: 0),
                ],
              ),
              tab,
            ],
          );
        },
      ),
    );
  }
}
