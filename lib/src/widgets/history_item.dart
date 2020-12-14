import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';

import '../data/index.dart';
import '../modules/settings/index.dart';
import '../utils/index.dart';
import 'app-theme.dart';

class HistoryGroup extends StatelessWidget {
  const HistoryGroup({
    Key key,
    @required this.historyGroupData,
  }) : super(key: key);

  final HistoryGroupData historyGroupData;

  int get minsPerEp {
    double result = 0;
    var total = 0;
    for (var h in historyGroupData.historyList) {
      total += h.durationMins;
    }
    result = total / historyGroupData.historyList.length;
    return result.toInt();
  }

  @override
  Widget build(BuildContext context) {
    var settings = ctrl<SettingsController>(context).model;
    var requiredMinsPerEp = settings.requiredMinsPerEp;
    var requiredEpsPerDay = settings.requiredEpsPerDay;
    var reqMetMins = minsPerEp >= requiredMinsPerEp;
    var reqMet = historyGroupData.historyList.length >= requiredEpsPerDay;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          children: [
            ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              title: Text(
                historyGroupData.day,
                style: TextStyle(
                  color: AppTheme.of(context).text3,
                  fontWeight: FontWeight.w400,
                  fontSize: sy(10),
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '${historyGroupData.historyList.length} episodes',
                    style: TextStyle(
                      color: reqMet ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: sy(8),
                    ),
                  ),
                  Text(
                    ' ($minsPerEp mins/ep.)',
                    style: TextStyle(
                      color: reqMetMins ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: sy(7.5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              children: historyGroupData.historyList.map<Widget>((x) => HistoryItem(history: x)).toList(),
            ),
            Divider(height: 1),
          ],
        );
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({Key key, @required this.history}) : super(key: key);

  final AnimeHistory history;

  @override
  Widget build(BuildContext context) {
    var settings = ctrl<SettingsController>(context).model;
    var requiredMinsPerEp = settings.requiredMinsPerEp;
    var reqMet = history.durationMins >= requiredMinsPerEp;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          children: [
            FlatButton(
              onPressed: () {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  history.title,
                  style: TextStyle(
                    color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Episode ${history.episode}',
                      style: TextStyle(
                        color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                    Dot(color: AppTheme.of(context).text3),
                    Text(
                      DateFormat('MMM dd, H:mm a').format(history.timestamp),
                      style: TextStyle(
                        color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  '${history.durationMins} mins.',
                  style: TextStyle(
                    color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                dense: true,
              ),
            ),
            Divider(height: 1),
          ],
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({
    Key key,
    this.size,
    this.color,
    this.spacing,
  }) : super(key: key);

  final double size;
  final Color color;
  final EdgeInsets spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 3,
      width: size ?? 3,
      margin: spacing ?? EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.white,
      ),
    );
  }
}
