import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../mixins/index.dart';
import '../../../../../modules/app/index.dart';
import '../../../../../utils/index.dart';
import '../../../../index.dart';
import 'index.dart';

class AnimeFilterList extends StatefulWidget {
  const AnimeFilterList({Key key}) : super(key: key);

  @override
  _AnimeFilterListState createState() => _AnimeFilterListState();
}

class _AnimeFilterListState extends State<AnimeFilterList> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: do check if user's anime list have already loaded before enabling filter functions.
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Stack(
          children: [
            MomentumBuilder(
              controllers: [AppController],
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: sy(4)),
                    ]..addAll(
                        filterWidgetService.filterWidgets
                            .map(
                              (e) => AnimeFilterItemWidget(filterItem: e),
                            )
                            .toList(),
                      ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(sy(8)),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    dialog(context, AnimeFilterAdd());
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
