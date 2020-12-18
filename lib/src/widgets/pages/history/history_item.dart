import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({Key key, @required this.history}) : super(key: key);

  final AnimeHistory history;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    var requiredMinsPerEp = settings.requiredMinsPerEp;
    var reqMet = widget.history.durationMins >= requiredMinsPerEp;
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
                  widget.history.title,
                  style: TextStyle(
                    color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Episode ${widget.history.episode}',
                      style: TextStyle(
                        color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                    Dot(color: AppTheme.of(context).text3),
                    Text(
                      DateFormat('MMM dd, H:mm a').format(widget.history.timestamp),
                      style: TextStyle(
                        color: !reqMet ? Colors.red.withOpacity(0.6) : AppTheme.of(context).text3,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  '${widget.history.durationMins} mins.',
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
