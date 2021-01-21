import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../mixins/index.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/index.dart';
import '../../../../index.dart';

class AnimeFilterAdd extends StatefulWidget {
  const AnimeFilterAdd({Key key}) : super(key: key);

  @override
  _AnimeFilterAddState createState() => _AnimeFilterAddState();
}

class _AnimeFilterAddState extends State<AnimeFilterAdd> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          var filterItemSource = srv<AnimeFilterListService>(context).filterItemSource;
          var filterList = <Widget>[];
          for (var i = 0; i < filterItemSource.length; i++) {
            var filter = filterItemSource[i];
            filterList.add(_FilterItemWidget(item: filter));
            if (i != (filterItemSource.length - 1)) {
              filterList.add(Divider(height: 1, color: Colors.white.withOpacity(0.1)));
            }
          }

          return Container(
            width: width,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: filterList,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterItemWidget extends StatelessWidget {
  const _FilterItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final AnimeFilterItem item;

  bool get exist => item.filterExist();

  @override
  Widget build(BuildContext context) {
    return Ripple(
      child: Column(
        children: [
          RelativeBuilder(
            builder: (context, height, width, sy, sx) {
              return ListTile(
                title: Text(
                  item.title,
                  style: TextStyle(
                    color: exist ? AppTheme.of(context).text7 : AppTheme.of(context).text2,
                    fontSize: sy(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      onPressed: exist
          ? null
          : () {
              item.onAddCallback(context);
            },
    );
  }
}
