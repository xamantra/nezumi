import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
import '../../app-theme.dart';
import '../../index.dart';
import 'index.dart';

class HistoryGroup extends StatefulWidget {
  const HistoryGroup({
    Key key,
    @required this.historyGroupData,
  }) : super(key: key);

  final HistoryGroupData historyGroupData;

  @override
  _HistoryGroupState createState() => _HistoryGroupState();
}

class _HistoryGroupState extends State<HistoryGroup> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    var totalHours = double.parse(((totalMins() / 60.0)).toStringAsFixed(2));
    var reqMet = totalHours >= settings.requiredHoursPerDay;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        String day;
        var date = trycatch(() => widget.historyGroupData.historyList.first.timestamp);
        if (date != null) {
          var now = DateTime.now();
          var diff = now.difference(date).abs();
          if (isSameDay(date, now)) {
            day = 'Today';
          } else if (diff.inDays < 6) {
            var daysDiff = now.day - date.day;
            if (isSameYearMonth(date, now) && daysDiff == 1) {
              day = 'Yesterday';
            } else {
              switch (date.weekday) {
                case DateTime.sunday:
                  day = 'Sunday';
                  break;
                case DateTime.monday:
                  day = 'Monday';
                  break;
                case DateTime.tuesday:
                  day = 'Tuesday';
                  break;
                case DateTime.wednesday:
                  day = 'Wednesday';
                  break;
                case DateTime.thursday:
                  day = 'Thursday';
                  break;
                case DateTime.friday:
                  day = 'Friday';
                  break;
                case DateTime.saturday:
                  day = 'Saturday';
                  break;
                default:
                  day = '';
              }
            }
          } else {
            day = '';
          }
        } else {
          day = '';
        }

        return Column(
          children: [
            ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.historyGroupData.day,
                    style: TextStyle(
                      color: AppTheme.of(context).text3,
                      fontWeight: FontWeight.w400,
                      fontSize: sy(10),
                    ),
                  ),
                  SizedBox(width: sy(2)),
                  Text(
                    day,
                    style: TextStyle(
                      color: AppTheme.of(context).text7,
                      fontWeight: FontWeight.w400,
                      fontSize: sy(7),
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    '$totalHours hours',
                    style: TextStyle(
                      color: reqMet ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: sy(8),
                    ),
                  ),
                  Dot(color: AppTheme.of(context).text3),
                  Text(
                    '${widget.historyGroupData.historyList.length} episodes',
                    style: TextStyle(
                      color: AppTheme.of(context).text3,
                      fontWeight: FontWeight.w300,
                      fontSize: sy(8),
                    ),
                  ),
                  Text(
                    ' (${minsPerEp()} mins/ep.)',
                    style: TextStyle(
                      color: AppTheme.of(context).text3,
                      fontWeight: FontWeight.w300,
                      fontSize: sy(7.5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              children: widget.historyGroupData.historyList.map<Widget>((x) => HistoryItem(history: x)).toList(),
            ),
            Divider(height: 1),
          ],
        );
      },
    );
  }

  double totalMins() {
    var total = 0.0;
    for (var h in widget.historyGroupData.historyList) {
      total += h.durationMins;
    }
    return total;
  }

  int minsPerEp() {
    double result = 0;
    var total = 0;
    for (var h in widget.historyGroupData.historyList) {
      total += h.durationMins;
    }
    result = total / widget.historyGroupData.historyList.length;
    return result.toInt();
  }
}
