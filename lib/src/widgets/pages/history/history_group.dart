import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../../mixins/index.dart';
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
    var totalMinutes = minsPerEp() * widget.historyGroupData?.historyList?.length ?? 0;
    var totalHours = double.parse((totalMinutes / 60).toStringAsFixed(2));
    var reqMet = totalHours >= settings.requiredHoursPerDay;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          children: [
            ExpansionTile(
              childrenPadding: EdgeInsets.zero,
              title: Text(
                widget.historyGroupData.day,
                style: TextStyle(
                  color: AppTheme.of(context).text3,
                  fontWeight: FontWeight.w400,
                  fontSize: sy(10),
                ),
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
