import 'package:flutter/material.dart';
import 'package:nezumi/src/data/filter-anime-types/index.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../mixins/index.dart';
import '../../../../index.dart';
import '../../filter-types/index.dart';

class AnimeFilterDialog extends StatefulWidget {
  const AnimeFilterDialog({Key key}) : super(key: key);

  @override
  _AnimeFilterDialogState createState() => _AnimeFilterDialogState();
}

class _AnimeFilterDialogState extends State<AnimeFilterDialog> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            width: width,
            color: AppTheme.of(context).primaryBackground,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Ripple(
                    child: ListTile(
                      title: Text(
                        'Genre Filter',
                        style: TextStyle(
                          color: AppTheme.of(context).text2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      filterWidgetService.addFilter(GenreFilterWidget());
                      animeFilter.controller.addFilter(animeFilter.animeGenreFilter);
                      app.triggerRebuild();
                      Navigator.pop(context);
                    },
                  ),
                  Ripple(
                    child: ListTile(
                      title: Text(
                        'Watch Date Filter',
                        style: TextStyle(
                          color: AppTheme.of(context).text2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      filterWidgetService.addFilter(WatchDateFilterWidget());
                      animeFilter.controller.addFilter(animeFilter.animeWatchDateFilter);
                      app.triggerRebuild();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
