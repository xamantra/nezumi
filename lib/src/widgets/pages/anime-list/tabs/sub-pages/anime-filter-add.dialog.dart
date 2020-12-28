import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../mixins/index.dart';
import '../../../../index.dart';

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
                children: filterWidgetService.filterItemSource
                    .map(
                      (e) => Ripple(
                        child: ListTile(
                          title: Text(
                            e.title,
                            style: TextStyle(
                              color: AppTheme.of(context).text2,
                            ),
                          ),
                        ),
                        onPressed: () {
                          e.onAddCallback(context);
                        },
                      ),
                    )
                    .toList(),
                // TODO: list status filter
                // TODO: release season filter
                // TODO: release date filter
                // TODO: media type filter
                // TODO: content length filter
              ),
            ),
          );
        },
      ),
    );
  }
}
